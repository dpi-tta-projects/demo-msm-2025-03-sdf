Rails.application.routes.draw do
  root "movies#index"

  devise_for :users

  # TODO: only need create, destroy
  resources :likes

  get("search", { controller: "search", action: "index" })
  # resources :search, only: [:index]

  # Routes for the Character resource:

  # CREATE
  post("/insert_character", { :controller => "characters", :action => "create" })

  # READ
  get("/characters", { :controller => "characters", :action => "index" })

  get("/characters/:path_id", { :controller => "characters", :action => "show" })

  # UPDATE

  post("/modify_character/:path_id", { :controller => "characters", :action => "update" })

  # DELETE
  get("/delete_character/:path_id", { :controller => "characters", :action => "destroy" })

  #------------------------------

  # Routes for the Actor resource:
  # post("/actors", { :controller => "actors", :action => "create" })
  # get("/actors", { :controller => "actors", :action => "index" })
  # get("/actors/:id", { :controller => "actors", :action => "show" })
  # post("/actors/:id", { :controller => "actors", :action => "update" })
  # delete("/actors/:id", { :controller => "actors", :action => "destroy" })
  resources :actors

  #------------------------------

  # Routes for the Movie resource:

  # CREATE
  resources :movies
  #------------------------------

  # Routes for the Director resource:

  get("/directors/youngest", { :controller => "directors", :action => "youngest" })
  get("directors/eldest", { :controller => "directors", :action => "eldest" })

  # CREATE
  post("/insert_director", { :controller => "directors", :action => "create" })

  # READ
  get("/directors", { :controller => "directors", :action => "index" })

  get("/directors/:path_id", { :controller => "directors", :action => "show" })

  # UPDATE

  post("/modify_director/:path_id", { :controller => "directors", :action => "update" })

  # DELETE
  get("/delete_director/:path_id", { :controller => "directors", :action => "destroy" })

  #------------------------------

  # TODO: add directors
  #   youngest director
  #   eldest director
  # TODO: add movies
  # TODO: add actors
end
