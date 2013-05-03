OmniauthApp::Application.routes.draw do
  get 'auth/google_oauth2/callback' => 'sessions#create' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  end
  root to: 'home#index'
  
  get '/auth/failure' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  end

  delete '/sessions/destroy' => 'sessions#destroy', as: :log_out
end
