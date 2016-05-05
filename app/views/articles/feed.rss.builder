#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Blog Engine"
    xml.author "Wayne Morris"
    xml.description "Blog Engine for Everyone"
    xml.link "https://www.codingfish.com"
    xml.language "en"
  

    for article in @articles
      article.content
      xml.item do
        if article.authors
          xml.title article.authors.join
        else
          xml.title ""
        end

        xml.blog_title article.title

        if article["created_at"]
          xml.pubDate article["created_at"].to_s
        else
          xml.pubDate ""
        end
        # xml.link "http://localhost:3000/articles/" +  article.slugs.join('')
        xml.link "http://wayne75.fwd.wf/articles/" +  article.slugs.join('')
        xml.guid article.id

        text = article.content
		# if you like, do something with your content text here e.g. insert image tags.
		# Optional. I'm doing this on my website.
        # if article.image.exists?
        #     image_url = article.image.url(:large)
        #     image_caption = article.image_caption
        #     image_align = ""
        #     image_tag = "
        #         <p><img src='" + image_url +  "' alt='" + image_caption + "' title='" + image_caption + "' align='" + image_align  + "' /></p>
        #       "
        #     text = text.sub('{image}', image_tag)
        # end
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end