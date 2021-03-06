require 'open-uri'
ActiveAdmin.register_page 'Dashboard' do
  content do
    @images = Image.all
    columns do
      column do
        panel 'Recent Category' do
          table_for Category.order('created_at desc').limit(5) do
            column :name
            column :created_at
          end
        end
        panel 'Recent Comments' do
          table_for Comment.order('created_at desc').limit(5) do
            column :com_email
            column :body
            column :image
          end
        end
      end
    end
    render partial: 'form'
  end
end
