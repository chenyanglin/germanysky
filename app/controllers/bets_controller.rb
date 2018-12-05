class BetsController < ApplicationController

	def index
		@bets = BetData.where("created_at > ?", 2.days.ago)
     render :layout => 'hcolorlayout'
	end
	def zhongxiao
		render :layout => 'hcolorlayout'
	end
end
