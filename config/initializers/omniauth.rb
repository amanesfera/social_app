Rails.application.config.middleware.use OmniAuth::Builder do
	ENV["GOOGLE_CLIENT_ID"]="701513583342-680l2vqq35mngg354tccrlcrpme64mih.apps.googleusercontent.com"
	ENV["GOOGLE_CLIENT_SECRET"]="SmmpKfEMGwb21PVwB9nLyPw6"
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], 
  ENV["GOOGLE_CLIENT_SECRET"], {
 scope: ['email', 'profile', 
  'https://www.googleapis.com/auth/plus.me',
  'https://www.googleapis.com/auth/plus.stream.write',
   'https://www.googleapis.com/auth/gmail.readonly',   
   'https://www.googleapis.com/auth/admin.directory.group.readonly', 
   'https://www.googleapis.com/auth/admin.directory.group.member.readonly',
    'https://www.googleapis.com/auth/admin.directory.user.readonly',
    'https://www.googleapis.com/auth/plus.media.upload'],
   access_type: 'offline',approval_prompt:'force'} 

  ENV['LINKEDIN_CLIENT_ID']="77lua7g04wrotv"
  ENV['LINKEDIN_CLIENT_SECERT']="kQ5eIi3o8l99J782"

  provider :linkedin, ENV['LINKEDIN_CLIENT_ID'], ENV['LINKEDIN_CLIENT_SECERT'], :scope => 'r_emailaddress w_share'
  
end

