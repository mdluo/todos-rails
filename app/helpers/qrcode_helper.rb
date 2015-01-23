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
    def generate_qrcode_base64(content, size)
      qr_object = RQRCode::QRCode.new(content.to_s)
      Base64.encode64(qr_object.to_img.resize(size, size).to_s)
    end

    # helper to use in .erb file
    # 
    # usage:
    #     <%= qrcode_img @content, size: 512 %>
    #
    # default <size> is 400.
    # height and weight property is ignored.
    def qrcode_img(content, options = { })
      if options[:size]
        size = options[:size]
        options.delete(:size)
        options[:width] = options[:height] = size
      else
        size = options[:width] = options[:height] = 400
      end

      encoded_str = generate_qrcode_base64(content, size)

      options[:src] = "data:image/png;base64,#{encoded_str}"
      tag(:img, options)
    end

end
