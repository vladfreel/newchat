ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :reset_password_token
    column :reset_password_sent_at
    column :remember_created_at
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :created_at
    column :updated_at
    column :provider
    column :uid
    column :failed_attempts
    column :unlock_token
    column :locked_at
    column :cached_failed_attempts
    column :confirmation_token
    column :confirmed_at
    column :confirmation_sent_at
    column :avatarf
    column :inet
    actions
  end

end
