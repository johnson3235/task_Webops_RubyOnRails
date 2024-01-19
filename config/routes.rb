Rails.application.routes.draw do
  # AuthController routes
  post '/login', to: 'auth#login'
  post '/register', to: 'auth#register'
  post '/logout', to: 'auth#logout'

  # PostController routes
  get '/post/all', to: 'post#getallposts'
  post '/post/add', to: 'post#addPost'
  put '/post/update/:id', to: 'post#updatePost'
  delete '/post/delete/:id', to: 'post#deletePost'

  # CommentController routes
  get '/posts/:postId/comments', to: 'comment#getallComments'
  post '/comment/add', to: 'comment#addComment'
  put '/comment/update/:id', to: 'comment#updateComment'
  delete '/comment/delete/:id', to: 'comment#deleteComment'
end
