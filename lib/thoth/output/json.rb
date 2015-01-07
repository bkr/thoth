module Thoth
  module Output
    class Json

      def initialize(io)
        @io = io
      end

      def write(hash)
        @io.write("#{JSON.dump(hash)}\n")
      end
    end
  end
end