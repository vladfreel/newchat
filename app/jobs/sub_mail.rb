# submail
class SubMail
  @queue = :sub_queue
  def self.perform(sub_id)
    curr_sub = Sub.find(sub_id)
    UserMailer.welcome_subs(curr_sub.user).deliver
  end
end
