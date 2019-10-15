require_relative 'app'

class TimeOutput

  FORMATS_ALLOWED = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
                      'hour' => '%H', 'minute' => '%m', 'second' => '%S' }.freeze

  def initialize(request)
    @parts = []
    @path = request.path
    @formats = request.params['format']
  end

  def converted_time
    date_time = @formats.split(',').map { |format| FORMATS_ALLOWED[format] }
    Time.now.strftime(date_time.join('-'))
  end

  def invalid_path?
    @path != '/time'
  end

  def empty_formats?
    @formats.nil?
  end

  def unknown_time_formats
    @formats.split(',') - FORMATS_ALLOWED.keys
  end

  def formats_valid?
    unknown_time_formats.empty?
  end


end
