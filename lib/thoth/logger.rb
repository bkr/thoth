module Thoth
  class Logger

    attr_reader :outputs, :timestamp_format, :timestamp_key

    def initialize(outputs, options={})
      @outputs = [outputs].flatten
      @timestamp_format = options.fetch(:timestamp_format, "%d/%b/%Y:%H:%M:%S %z")
      @timestamp_key = options.fetch(:timestamp_key, :time)
    end

    def log(event_name, details={}, context={})
      event_data = marshal_event(event_name, details, context)

      outputs.each do |output|
        output.write(event_data)
      end
    end


    private

    def marshal_event(event_name, details, context)
      {
        event: event_name,
        timestamp_key => Time.now.utc.strftime(timestamp_format),
        context: context.reverse_merge(Thoth.context),
        details: details
      }
    end
  end
end