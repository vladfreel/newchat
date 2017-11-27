ActiveAdmin.register Like do
  permit_params :image_id, :user_id
  form do |f|
    f.inputs 'Details' do
      f.input :image
      f.input :user
      f.actions
    end
  end
end
