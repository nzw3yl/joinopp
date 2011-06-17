module ApplicationHelper

   # Return a title ona per-page basis
   def title
      base_title = "JoinOpp"
      if @title.nil?
	base_title
      else
        "#{base_title} | #{@title}"
      end
   end


end
