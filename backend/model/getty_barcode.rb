class GettyBarcode
  def self.generate(data, opts = {})
    # image file format. default png. other supported values: jpg, gif, bmp
    opts[:format] ||= 'png'

    # dots per inch for calculating the image resolution. default 200
    opts[:dpi] ||= 200

    # size of the printed image for calculating image resolution. default 2 inches
    opts[:image_size_in] ||= 2

    # number of pixels (width and height because it's square) for the image
    resolution = opts[:image_size_in] * opts[:dpi]

    # number of pixels for each dot in the barcode. default 8px
    opts[:dot_size_px] ||= 8

    # whether to include a white border around the barcode. default true
    opts[:border] ||= true

    # text to include above the barcode. no default. if not set then no text appears
    opts[:banner]

    #SELA: text to include below the banner above the barcode. no default. if not set then no text appears
    opts[:refid]

    # text to include below the barcode. no default. if not set then no text appears
    opts[:text]

    # the factional size of the barcode with respect to the image size
    # tune this to maximize the size of the barcode while avoiding conflict
    # with the text. default 0.6 (60% of the image size)
    #SELA: reduced to 0.5
    opts[:barcode_size] ||= (AppConfig[:getty_barcode_fractional_size] rescue 0.58)


    anti_alias = false
    orientation = 0

    bc = org.krysalis.barcode4j.impl.datamatrix.DataMatrixBean.new()

    bc.setModuleWidth(org.krysalis.barcode4j.tools.UnitConv.in2mm(opts[:dot_size_px].to_f / opts[:dpi].to_f))
    bc.doQuietZone(opts[:border])
    bc.setShape(org.krysalis.barcode4j.impl.datamatrix.SymbolShapeHint::FORCE_SQUARE);

    dim = bc.calcDimensions(data);

    bi = java.awt.image.BufferedImage.new(resolution, resolution,
                                          java.awt.image.BufferedImage::TYPE_BYTE_BINARY)

    g2d = bi.createGraphics()
    g2d.setRenderingHint(java.awt.RenderingHints::KEY_FRACTIONALMETRICS,
                         java.awt.RenderingHints::VALUE_FRACTIONALMETRICS_ON)

    g2d.setRenderingHint(java.awt.RenderingHints::KEY_TEXT_ANTIALIASING,
                         java.awt.RenderingHints::VALUE_TEXT_ANTIALIAS_GASP)

    g2d.setBackground(java.awt.Color::white)
    g2d.setColor(java.awt.Color::black)
    g2d.clearRect(0, 0, bi.getWidth(), bi.getHeight())

    text_scale = resolution / 100.0
    g2d.scale(text_scale, text_scale)

    font = g2d.getFont

    if opts[:banner]
      rect = font.getStringBounds(opts[:banner], java.awt.font.FontRenderContext.new(nil, true, true))
      xoff = (50 - (rect.width / 2)).round
      g2d.drawString(opts[:banner], xoff, 10)
    end

#SELA: added code for refid display
    if opts[:refid]
      rect = font.getStringBounds(opts[:refid], java.awt.font.FontRenderContext.new(nil, true, true))
      xoff = (50 - (rect.width / 2)).round
      g2d.drawString(opts[:refid], xoff, 20)
    end

    if opts[:text]
      rect = font.getStringBounds(opts[:text], java.awt.font.FontRenderContext.new(nil, true, true))
      xoff = (50 - (rect.width / 2)).round
      g2d.drawString(opts[:text], xoff, 90)
    end

    g2d.scale(1 / text_scale, 1 / text_scale)

    bc_scale = opts[:barcode_size] * bi.getWidth() / dim.getWidthPlusQuiet(orientation)

    bc_offset = (resolution - dim.getWidthPlusQuiet(orientation) * bc_scale) / 2
    g2d.translate(bc_offset, bc_offset)

    g2d.scale(bc_scale, bc_scale)

    canvasj2d = org.krysalis.barcode4j.output.java2d.Java2DCanvasProvider.new(g2d, orientation);

    bc.generateBarcode(canvasj2d, data)

    begin
      img_output = java.io.ByteArrayOutputStream.new
      javax.imageio.ImageIO.write(bi, opts[:format], img_output)
      java.io.ByteArrayInputStream.new(img_output.toByteArray()).to_io.to_enum
    ensure
      img_output.close
    end
  end
end
