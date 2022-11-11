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

#    send_file(GettyBarcode.gimme('dfzdf'), {:mime_type => "image/png"})

    # [
    #  200,
    #  {"Content-Type" => "application/octet-stream"},
    #  GettyBarcode.gimme('dfzdf')
    # ]


#    json_response({'got' => GettyBarcode.gimme('dfzdf')})

    # [
    #  200,
    #  {"Content-Type" => "text/csv"},
    #  UscStuff.csv
    # ]
  end
end
