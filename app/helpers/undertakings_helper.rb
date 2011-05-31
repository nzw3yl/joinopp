module UndertakingsHelper

 def current_undertaking=(undertaking)
   @current_undertaking = undertaking
 end

 def current_undertaking
  @current_undertaking ||= undertaking_from_undertaking_token
 end
 
 def current_undertaking?
    !current_undertaking.nil?
 end

 def undertakings
   @undertakings ||= current_user.undertakings.find(:all)
 end

 def last_undertaking(undertaking)
   cookies.permanent[:undertaking_token] = { :value => undertaking.id, :expires => 1.year.from_now }
   self.current_undertaking = undertaking
 end

 def wrap(content)
   sanitize(raw(content.split.map{ |s| wrap_long_string(s)}.join(' ')))
 end


 private

   def undertaking_from_undertaking_token
     Undertaking.find_by_id(cookies[:undertaking_token])
   end

   def wrap_long_string(text, max_width = 25, max_length = 75)
     zero_width_space = "&#8203;"
     regex = /.{1,#{max_width}}/
      if (text.length > max_length)
	text = text.truncate(max_length)
      end
     (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
   end
end
