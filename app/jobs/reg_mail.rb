# regmail
class RegMail
  @queue = :reg_queue
  def self.perform(res)
    UserMailer.welcome(res).deliver unless resource.invalid?
  end
end
