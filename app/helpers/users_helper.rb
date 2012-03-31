module UsersHelper
	
	def gravatar_for(user, options = { :size => 50 })
		gravatar_image_tag(user.email.downcase, :alt => user.name,
												:class => 'gravatar',
												:gravatar => options) #gravatar reader is case sensitive =-
	end
	
	
	#def gravatar_for(user, options = { :size => 50 })
		#gravatar_image_tag(user.email_address.downcase, :alt => user.name,
		#												:class => 'gravatar',
		#												:gravatar => options) #gravatar reader is case sensitive =-
	#end
	
end
