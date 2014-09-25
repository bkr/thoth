module Thoth
  module Output
    class Json

      def initialize(io)
        @io = io
      end

      def write(hash)
        @io.write("#{ActiveSupport::JSON.encode(hash)}\n")
      end
    end
  end
end