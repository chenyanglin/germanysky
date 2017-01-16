# encoding: utf-8

namespace :jobs do
    desc "確認是否完成訂單" #此處可自行輸入task的描述
    		task :test => :environment do
               message = Message.first
               message.update(content: message.content+"[a]")
            end
            task :checkorder => :environment do
               @orders = Order.where("delivery_status = ? AND pay_status = ?",2,3)
               @orders.each do |o|
               	days = DateTime.parse(Time.now.strftime("%Y-%m-%d")) - DateTime.parse(o.updated_at.strftime("%Y-%m-%d"))
               	if days > 7
               		o.update(delivery_status: 5, pay_status:6)
               		content_to_user = "您的訂單編號"+o.ordernumber.to_s+"已經完成所有程序，感謝您的購買。您可以登入網站查看訂單詳細資訊，謝謝。"
      				NewsMailer.normal_email("訂單完成通知",content_to_user,o.account.id).deliver_now!
      				content = "訂單編號"+o.ordernumber.to_s+"已經完成所有程序。此筆訂單為"+o.account.name.to_s+"訂購，請逕行確認"
      				NewsMailer.system_email("訂單完成通知",content).deliver_now!
               	end
               end
            end
    end