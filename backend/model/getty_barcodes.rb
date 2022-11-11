class GettyBarcode

  def self.generate(data)
    bc = org.krysalis.barcode4j.impl.datamatrix.DataMatrixBean.new()

    dpi = 200;

    # makes a dot/module exactly eight pixels
    bc.setModuleWidth(org.krysalis.barcode4j.tools.UnitConv.in2mm(8.0 / dpi));
    bc.doQuietZone(false);
    bc.setShape(org.krysalis.barcode4j.impl.datamatrix.SymbolShapeHint::FORCE_SQUARE);


    antiAlias = false
    orientation = 0

    canvas = org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider.new(dpi,
                                                                           java.awt.image.BufferedImage::TYPE_BYTE_BINARY,
                                                                           antiAlias,
                                                                           orientation)

    bc.generateBarcode(canvas, data)

    canvas.finish()

    bufimg = canvas.getBufferedImage()

    output = java.io.ByteArrayOutputStream.new

    begin
      javax.imageio.ImageIO.write(bufimg, "png", output)

      tmp = ASUtils.tempfile("barcode.png")

# this works
#      file = java.io.FileOutputStream.new("barcode.png")
#      output.writeTo(file)

      output.writeTo(tmp)



      # output_bytes = output.to_byte_array
      # return DisplayCopyObj.new(java.io.ByteArrayInputStream.new(output_bytes),
      #                           output_bytes.length,
      #                           Digest::SHA256.hexdigest(output_bytes.to_ary.pack('C*')),
      #                          'image/jpeg')
    ensure
      output.close
    end

#    {:neat => 'one'}

#    output
    tmp.flush
    tmp.rewind
    tmp
  end

end
