module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, 	:alt => user.name,
						:class => 'gravatar',
						:gravatar => options)
  end

  def user_name(id)
    @user = User.find(id)
    @user.nil? ? "anonymous" : @user.name
  end

end
