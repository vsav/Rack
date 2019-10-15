require_relative 'app'

class TimeOutput

  FORMATS_ALLOWED = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
                      'hour' => '%H', 'minute' => '%m', 'second' => '%S' }.freeze

  def initialize(formats)
    @formats = formats.split(',')
    @parts = []
  end

  def converted_time
    @date_time = @formats.map { |format| FORMATS_ALLOWED[format] }
    Time.now.strftime(@date_time.join('-'))
  end

  def unknown_time_formats
    @formats - FORMATS_ALLOWED.keys
  end

  def formats_valid?
    unknown_time_formats.empty?
  end

end
