Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
           {
             :scope => "userinfo.email,userinfo.profile", #info to access
             :approval_prompt => "auto"
           }
end