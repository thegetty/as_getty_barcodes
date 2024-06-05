class GettyBarcodesController < ApplicationController

  skip_before_action :unauthorised_access

  def image
    self.response.headers["Content-Type"] = "image/png"
    self.response.headers["Content-Disposition"] = "attachment; filename=\"#{params[:name]}.png\""

    self.response_body = Enumerator.new do |stream|
      JSONModel::HTTP.stream('/getty_barcode', {:data => params[:data], :text => params[:text], :refid => params[:refid]}) do |response|
        response.read_body do |chunk|
          stream << chunk
        end
      end
    end
  end
end
