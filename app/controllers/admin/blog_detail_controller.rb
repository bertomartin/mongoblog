class Admin::BlogDetailController < ApplicationController
	def index
		@blog_details = {}
		articles = Article.all
		articles.each do |article|
			user = User.find(article.user_id)
			@blog_details[article.id] = {'author'=>user.email, 'title'=>article.title, 'tags'=>article.tag, 'content'=>article.content.to_s[0..40]}
		end
		render json: @blog_details
	end
end
