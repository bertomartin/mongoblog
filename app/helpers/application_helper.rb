module ApplicationHelper
	def get_page_params articles
      page_params = {}
      page_params['total_articles'] = articles.count
      page_params['offset'] = 2
      page_params['number_of_pages'] = (page_params['total_articles'] .to_f / page_params['offset'].to_f).ceil
      page_params['second_to_last_page'] =  (page_params['number_of_pages'] - 1) * page_params['offset']
      page_params
    end

	def page_scroll (params, pages)
      page_num = params[:pg].to_i
      if page_num == 0
        page_num = 1
      end
      
      next_p = 1
      prev = 1
      scroll = {}
      if page_num <= pages - 1
        next_p = page_num + 1
      else
         next_p = page_num 
      end

      if page_num >= 1
        prev = page_num - 1
        if prev == 0
          prev = 1
        end
      end
      scroll['next'] = next_p
      scroll['prev'] = prev
      scroll
    end

	def get_articles(params, offset, articles)
      if params[:pg].to_i > 0 && params[:pg].to_i > 1
         @current_page = (params[:pg].to_i * offset).to_i
         @articles =  articles.skip(@current_page - offset).limit(offset) 
      else
          @articles = articles.limit(offset)      
      end    
    end
end
