class ArchivesSpaceService < Sinatra::Base
  Endpoint.get('/getty_barcode')
    .description("Barcode fiddles")
    .params(["data", String, "Something to barcode"])
    .permissions([])
    .returns([200, "Barcode PNG"]) \
  do
    [
     200,
     {"Content-Type" => "image/png"},
     GettyBarcode.generate(params[:data])
    ]
  end
end
