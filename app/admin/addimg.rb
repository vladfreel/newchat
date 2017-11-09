require 'open-uri'
require 'nokogiri'
ActiveAdmin.register_page "Addimg" do
  content do
    render :partial => 'admin/addimg/about'
    #img = Image.new(path: current_user.id)
    #img.save!
    def new
      render :partial => 'admin/addimg/parse'
    end
  end
end