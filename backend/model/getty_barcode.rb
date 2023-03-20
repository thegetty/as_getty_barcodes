class GettyBarcode
  def self.generate(data, opts = {})
    opts[:format] ||= 'png'
    opts[:dpi] ||= 200
    opts[:dot_size_px] ||= 8
    opts[:border] ||= true
    opts[:image_size_in] ||= 2

    resolution = opts[:image_size_in] * opts[:dpi]
    barcode_size = 0.6 # 1 = whole image, 0.5 = half the image
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

    if opts[:text]
      rect = font.getStringBounds(opts[:text], java.awt.font.FontRenderContext.new(nil, true, true))
      xoff = (50 - (rect.width / 2)).round
      g2d.drawString(opts[:text], xoff, 97)
    end

    g2d.scale(1 / text_scale, 1 / text_scale)

    bc_scale = barcode_size * bi.getWidth() / dim.getWidthPlusQuiet(orientation)

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
