#
# qrcode_helper.rb
# 
# helper to generate QRCode and convert to Base64 code to display in web page.
# 
# created by secondwtq on 1/18/15.
#

require 'base64'
require 'rqrcode_png'

module QrcodeHelper

    extend ActiveSupport::Concern

    # use rqrcode_png library to generate QRCode
    # return Base64 code of generated QRCode
    def generate_qrcode_base64(content, size, code_size = 8, correction_level = :l)
      # rqrcode cannot handle UTF-8 properly, 
      #   so we can only force encode the source to 8bit ASCII currently
      #   refer to: https://ruby-china.org/topics/7527
      qr_object = RQRCode::QRCode.new(content.to_s.force_encoding('ASCII-8BIT'), :size => code_size, :level => correction_level)
      Base64.encode64(qr_object.to_img.resize(size, size).to_s)
    end

    # helper to use in .erb file
    # 
    # usage:
    #     <%= qrcode_img @content, size: 512 %>
    #
    # default <size> is 400.
    # height and weight property is ignored.
    # 
    # extra parameters:
    #   code_size - the size of the qrcode (not the picture size), default 4.
    #   correction_level - the error correction level, default :l
    #     please refer to: http://www.ruby-doc.org/gems/docs/a/arena_barby-0.3.2/RQRCode/QRCode.html
    #     for the two args above.
    def qrcode_img(content, options = { })
      if options[:size]
        size = options[:size]
        options.delete(:size)
        options[:width] = options[:height] = size
      else
        size = options[:width] = options[:height] = 400
      end

      options[:code_size] ||= 4
      options[:correction_level] ||= :l

      encoded_str = generate_qrcode_base64(content, size, options[:code_size], options[:correction_level])

      options[:src] = "data:image/png;base64,#{encoded_str}"
      tag(:img, options)
    end

end
