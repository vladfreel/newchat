ActiveAdmin.register Image do
  permit_params :remote_img_url, :category_id
  form do |f|
    f.inputs 'Details' do
      f.input :category_id
      f.input :remote_img_url
      f.actions
    end
  end
end
