ActiveAdmin.register Event do
  permit_params :user_id, :action_type, :orig_url
  form do |f|
    f.inputs 'Details' do
      f.input :user
      f.input :action_type
      f.input :orig_url
      f.actions
    end
  end
end
