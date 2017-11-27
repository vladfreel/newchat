ActiveAdmin.register Comment, as: 'UserComment' do
  permit_params :com_email, :body, :image_id, :user_id
  form do |f|
    f.inputs 'Details' do
      f.input :com_email
      f.input :body
      f.input :image
      f.input :user
      f.actions
    end
  end
end
