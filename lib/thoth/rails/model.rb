module Thoth
  module Rails::Model

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def log_events(options={})
        defaults = {on: [:create, :update, :destroy]}
        options = options.reverse_merge!(defaults)

        options[:on] = Array(options[:on])
        options[:only] = Array(options[:only])

        class_attribute :thoth_options
        self.thoth_options = options

        after_create  :thoth_log_create if options[:on].include?(:create)
        before_update :thoth_log_update if options[:on].include?(:update)
        after_destroy :thoth_log_destroy if options[:on].include?(:destroy)
      end
    end

    def thoth_log_create
      return unless self.class.thoth_options[:on].include?(:create)
      thoth_log_model(:create)
    end

    def thoth_log_update
      return unless self.class.thoth_options[:on].include?(:update)

      only_options = self.class.thoth_options[:only]
      if only_options.empty? || !(only_options.map(&:to_s) & changes.keys).empty?
        thoth_log_model(:update)
      end
    end

    def thoth_log_destroy
      return unless self.class.thoth_options[:on].include?(:destroy)
      thoth_log_model(:destroy)
    end

    def thoth_log_model(action)
      Thoth.logger.log("#{self.class.name} #{action}", changes: changes, attributes: attributes)
    end
  end
end
