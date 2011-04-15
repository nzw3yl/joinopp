module UndertakingsHelper

 def current_undertaking=(undertaking)
    @current_undertaking = undertaking
 end

 def current_undertaking
  @current_undertaking ||= undertaking_from_undertaking_token
 end


 def set_undertaking(undertaking)
   cookies.permanent.signed[:undertaking_token] = [undertaking.id, current_user.salt]
   self.current_undertaking = undertaking
 end

 private

   def undertaking_from_undertaking_token
      valid_undertaking_with_salt(*undertaking_token)
   end
   
   def undertaking_token
     cookies.signed[:undertaking_token] || [nil,nil]
   end

end
