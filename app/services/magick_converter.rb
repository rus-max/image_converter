class MagickConverter
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call(options = {})
    return unless File.file?(file)

    ext = options.delete(:format)

    image = MiniMagick::Image.new(file.path) do |b|
      options.each do |(option, value)|
        b.send(option.to_sym, value)
      end
    end

    image.format ext if ext

    image
  end
end
