module Thoth
  module DefaultLogger

    def logger
      @default_logger
    end

    def logger=(logger)
      @default_logger = logger
    end

  end
end