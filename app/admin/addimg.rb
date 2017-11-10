require 'open-uri'
require 'nokogiri'
ActiveAdmin.register_page "Addimg" do
  content do
    render :partial => 'admin/addimg/about'
    end
end