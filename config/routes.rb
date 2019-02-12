Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/pages/:origin/:currencies', to: 'pages#index', defaults: { origin: 'BRL', currencies: 'EUR,USD,AUD,BRL' }, as: :converter

  get '/', to: redirect('/pages/BRL/EUR,USD,AUD,BRL')
end
