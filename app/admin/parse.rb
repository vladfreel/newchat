require 'open-uri'
require 'nokogiri'
ActiveAdmin.register_page "Parse" do
  page_action :img, :method => :get do
    @doc = Nokogiri::HTML(open(params['url']))
    @category = Category.all
    render partial: 'img'
  end
  content do
    form action: "parse/img", method: :get do |f|
      f.input :url, type: :text, name: 'url'
      f.input :submit, type: :submit
    end
  end
end


