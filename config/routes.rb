Thumbnailer::Application.routes.draw do
  scope "api" do
    resources :products
  end
  match '*path', to: 'main#index'
  root to: "main#index"
end
