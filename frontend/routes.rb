ArchivesSpace::Application.routes.draw do
  [AppConfig[:frontend_proxy_prefix], AppConfig[:frontend_prefix]].uniq.each do |prefix|
    scope prefix do
      match('plugins/getty_barcode' => 'getty_barcodes#image', :via => [:get])
    end
  end
end
