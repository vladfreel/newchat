ActiveAdmin.register Category do
  permit_params :name, :user_id
  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :owner
      f.actions
    end
  end
end
