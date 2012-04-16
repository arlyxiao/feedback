require 'tempfile'
module SimpleCaptcha #:nodoc
  module ImageHelpers #:nodoc
    
    private

    def generate_simple_captcha_image(simple_captcha_key) #:nodoc
      amplitude, frequency = ImageHelpers.distortion(SimpleCaptcha.distortion)
      text = Utils::simple_captcha_value(simple_captcha_key)

      params = ImageHelpers.image_params(SimpleCaptcha.image_style).dup
      params << "-size #{SimpleCaptcha.image_size}"
      params << "-wave #{amplitude}x#{frequency}"
      params << "-gravity 'Center'"
      params << "-pointsize 22"
      params << "-implode 0.2"
      
      dst = Tempfile.new(RUBY_VERSION < '1.9' ? 'simple_captcha.jpg' : ['simple_captcha', '.jpg'])
      dst.binmode

      params << "label:#{text} '#{File.expand_path(dst.path)}'"

      SimpleCaptcha::Utils::run("convert", params.join(' '))

      dst.close

      File.expand_path(dst.path)
      #dst
    end
    
  end
end