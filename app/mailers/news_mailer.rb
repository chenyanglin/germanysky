class NewsMailer < ApplicationMailer
default from: "chenyang1205@gmail.com"

  def news_email(subject,content)
    emaillist = NewsletterEmail.where("status = ?", 1)
    @content = content
    @subject = subject
    # @url = post_url(@comment, :host => "localhost")
    list = []
    emaillist.each do |e|
    list << e.email
	end
  	mail(:to => list, :subject => @subject)
  end
  def normal_email(subject,content,id)
  	@account = Account.find(id)
  	email = @account.email
    @content = content
    @subject = "【GermanySky】"+subject
    # @url = post_url(@comment, :host => "localhost")
  	mail(:to => email, :subject => @subject)
  end
  def system_email(subject,content)
  	@subject = "【GermanySky系統通知】"+subject
  	@content = content
  	mail(:to => "chenyang1205@gmail.com", :subject => @subject)
  end
end
