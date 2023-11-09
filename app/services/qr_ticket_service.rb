class QrTicketService

    def initialize(ticket)
        @ticket = ticket
    end

    def generate_qr 
        qrcode = RQRCode::QRCode.new(@ticket.code)
        filename = "#{@ticket.code}.png"

        @png = qrcode.as_png(
            bit_depth: 1,
            border_modules: 4,
            color_mode: ChunkyPNG::COLOR_GRAYSCALE,
            color: "black",
            file: nil,
            fill: "white",
            module_px_size: 6,
            resize_exactly_to: false,
            resize_gte_to: false,
            size: 120
        )
        byebug
        @ticket.qrcode.attach(io: StringIO.new(@png.to_s), filename: filename, content_type: 'image/png')

    end    
      
end