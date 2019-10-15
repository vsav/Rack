require_relative 'time_output'

class App

  def call(env)
    @request = Rack::Request.new(env)
    @path = @request.path
    @formats = @request.params['format']
    check_request
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def check_request
    if @path != '/time'
      [404, headers, ["Error: Invalid URL\n"]]
    elsif @formats.nil?
      [400, headers, ["Error: Time formats missing\n"]]
    else
      convert_time
    end
  end

  def convert_time
    output = TimeOutput.new(@formats)
    if output.formats_valid?
      status = 200
      body = output.converted_time
    else
      status = 400
      body = "Error: Unknown format(s) #{output.unknown_time_formats}
      Allowed time formats: #{TimeOutput::FORMATS_ALLOWED.keys}"
    end
    [status, headers, ["#{body}\n"]]
  end

end
