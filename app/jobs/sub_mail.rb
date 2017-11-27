# submail
class SubMail
  @queue = :sub_queue
  def self.perform(user_id)
    UserMailer.welcome_subs(user_id).deliver
  end
end
