class GettyBarcode
  def self.generate(data, opts = {})
    opts[:format] ||= 'png'
    opts[:dpi] ||= 200
    opts[:dot_size_px] ||= 8

    bc = org.krysalis.barcode4j.impl.datamatrix.DataMatrixBean.new()

    bc.setModuleWidth(org.krysalis.barcode4j.tools.UnitConv.in2mm(opts[:dot_size_px].to_f / opts[:dpi].to_f));
    # bc.doQuietZone(false); # true by default adds a white border
    bc.setShape(org.krysalis.barcode4j.impl.datamatrix.SymbolShapeHint::FORCE_SQUARE);

    anti_alias = false
    orientation = 0
    canvas = org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider.new(
                 opts[:dpi],
                 java.awt.image.BufferedImage::TYPE_BYTE_BINARY,
                 anti_alias,
                 orientation)

    bc.generateBarcode(canvas, data)
    canvas.finish()

    begin
      img_output = java.io.ByteArrayOutputStream.new
      javax.imageio.ImageIO.write(canvas.getBufferedImage(), opts[:format], img_output)
      java.io.ByteArrayInputStream.new(img_output.toByteArray()).to_io.to_enum
    ensure
      img_output.close
    end
  end
end
