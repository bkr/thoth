module Thoth
  module Rails
    module ControllerContext

      def self.included(base)
        base.around_filter(:set_thoth_request_context)
      end

      def set_thoth_request_context
        Thoth.context = Thoth.context.merge(thoth_request_context)
        yield
        Thoth.clear_context!
      end

      def thoth_request_context
        context = params.dup
        context[:current_user] = current_user.try(:id) if defined?(current_user)
        context
      end
    end
  end
end

if defined?(::ActionController)
  ::ActiveSupport.on_load(:action_controller) { include Thoth::Rails::ControllerContext }
end
