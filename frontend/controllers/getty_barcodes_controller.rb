class GettyBarcodesController < ApplicationController

  skip_before_action :unauthorised_access

  def image
    self.response.headers["Content-Type"] = "image/png"
    self.response.headers["Content-Disposition"] = "attachment; filename=\"#{params[:name]}.png\""

    self.response_body = Enumerator.new do |stream|
#      JSONModel::HTTP.stream('/getty_barcode', {:data => 'aa10b2bdad82f54bac5aa58098fd2200'}) do |response|
      JSONModel::HTTP.stream('/getty_barcode', {:data => params[:data]}) do |response|
        response.read_body do |chunk|
          stream << chunk
        end
      end
    end
  end
end
