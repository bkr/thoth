require 'request_store'

module Thoth
  module Context

    KEY = :thoth_context

    def context
      RequestStore.store[KEY] ||= {}
    end

    def context=(value)
      RequestStore.store[KEY] = value
    end

    def clear_context!
      self.context = {}
    end

  end
end