class SearchController < ApplicationController
def google_images
    params[:start] = params[:start].to_i
    @page_title = "Import image from Google"
    @google_images = GoogleImage.all("Bob", params[:start])
  end
end