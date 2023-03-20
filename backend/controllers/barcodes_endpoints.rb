class ArchivesSpaceService < Sinatra::Base
  Endpoint.get('/getty_barcode')
    .description("Get a Getty Barcode")
    .params(
            ["data", String, "Data used to generate the barcode"],
            ["text", String, "Text displayed below the barcode"]
            )
    .permissions([])
    .returns([200, "Barcode PNG"]) \
  do
    [
     200,
     {"Content-Type" => "image/png"},
     GettyBarcode.generate(params[:data], {:text => params[:text], :banner => (AppConfig[:getty_barcode_banner] rescue 'JPC Archive')})
    ]
  end
end
