require 'sinatra'
require 'securerandom'
require 'jwt'
require 'base64'

enable :sessions
set :session_secret, SecureRandom.hex(64)
set :bind, '0.0.0.0'
set :port, 4567
set :public_folder, 'public'

FLAG = ENV['FLAG']
JWT_SECRET = SecureRandom.hex(64)

USERS = {
  'admin' => {
    password: 'asdnjiosaddmdskidsksdmakdsasdlodsidj'
  }
}

def generate_jwt(username)
  payload = {
    sub: username,
    exp: Time.now.to_i + 3600,
    iat: Time.now.to_i
  }
  JWT.encode(payload, JWT_SECRET, 'HS256')
end

def valid_jwt?(token)
  begin
    JWT.decode(token, JWT_SECRET, true, { algorithm: 'HS256' })
    true
  rescue
    false
  end
end

def current_user(request)
  token = request.cookies['session_token']
  return nil unless token && valid_jwt?(token)
  
  begin
    decoded = JWT.decode(token, JWT_SECRET, true, { algorithm: 'HS256' })
    decoded[0]['sub']
  rescue
    nil
  end
end

def styles
  <<~CSS
  <style>
    :root {
      --primary: #4361ee;
      --secondary: #3f37c9;
      --success: #4cc9f0;
      --danger: #f72585;
      --dark: #212529;
      --light: #f8f9fa;
    }
    
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
      background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
      color: var(--light);
      min-height: 100vh;
      padding: 2rem;
      line-height: 1.6;
    }
    
    .container {
      max-width: 1200px;
      margin: 0 auto;
    }
    
    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 0;
      border-bottom: 1px solid rgba(255,255,255,0.1);
      margin-bottom: 2rem;
    }
    
    .logo {
      font-size: 1.8rem;
      font-weight: bold;
      color: var(--success);
    }
    
    .card {
      background: rgba(255, 255, 255, 0.08);
      backdrop-filter: blur(10px);
      border-radius: 16px;
      padding: 2rem;
      margin-bottom: 2rem;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
      border: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    h1 {
      font-size: 2.5rem;
      margin-bottom: 1.5rem;
      background: linear-gradient(90deg, var(--primary), var(--success));
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
    }
    
    h2 {
      font-size: 1.8rem;
      margin-bottom: 1rem;
      color: var(--success);
    }
    
    .preferences {
      padding: 1rem;
      background: rgba(0,0,0,0.2);
      border-radius: 8px;
      margin: 1rem 0;
      font-size: 1.2rem;
      min-height: 60px;
    }
    
    form {
      max-width: 500px;
    }
    
    .form-group {
      margin-bottom: 1.5rem;
    }
    
    label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: 500;
    }
    
    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 0.8rem;
      border: none;
      border-radius: 8px;
      background: rgba(255,255,255,0.1);
      color: white;
      font-size: 1rem;
    }
    
    input:focus {
      outline: 2px solid var(--primary);
    }
    
    button {
      background: var(--primary);
      color: white;
      border: none;
      padding: 0.8rem 1.5rem;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
    }
    
    button:hover {
      background: var(--secondary);
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }
    
    .btn-danger {
      background: var(--danger);
    }
    
    .btn-danger:hover {
      background: #d1145a;
    }
    
    .video-list {
      list-style: none;
    }
    
    .video-list li {
      margin-bottom: 1rem;
      padding: 1rem;
      background: rgba(255,255,255,0.05);
      border-radius: 8px;
      transition: all 0.3s ease;
    }
    
    .video-list li:hover {
      background: rgba(255,255,255,0.1);
      transform: translateX(5px);
    }
    
    .video-list a {
      color: var(--success);
      text-decoration: none;
      font-size: 1.1rem;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    
    .video-list a:hover {
      text-decoration: underline;
    }
    
    .video-list a::before {
      content: "▶";
      color: var(--danger);
    }
    
    .nav-links {
      display: flex;
      gap: 1.5rem;
      align-items: center;
    }
    
    .nav-links a {
      color: var(--success);
      text-decoration: none;
      font-weight: 500;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      transition: all 0.3s ease;
    }
    
    .nav-links a:hover {
      background: rgba(255,255,255,0.1);
    }
    
    .alert {
      padding: 1rem;
      border-radius: 8px;
      margin-bottom: 1.5rem;
      background: rgba(255,255,255,0.1);
    }
    
    .alert-danger {
      background: rgba(247, 37, 133, 0.2);
      border-left: 4px solid var(--danger);
    }
    
    .alert-success {
      background: rgba(76, 201, 240, 0.2);
      border-left: 4px solid var(--success);
    }
    
    .footer {
      text-align: center;
      margin-top: 3rem;
      padding-top: 2rem;
      border-top: 1px solid rgba(255,255,255,0.1);
      color: rgba(255,255,255,0.6);
    }
  </style>
  CSS
end

def render_home(username, preferences)
  begin
    decoded_prefs = Base64.strict_decode64(preferences)
  rescue
    decoded_prefs = preferences
  end
  
  <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
      <title>Video Recommendations</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      #{styles}
  </head>
  <body>
      <div class="container">
          <header>
              <div class="logo">ytRecommender</div>
              <div class="nav-links">
                  <a href="/">Home</a>
                  <form action='/logout' method='POST' style="display:inline">
                      <button type='submit' class="btn-danger">Logout</button>
                  </form>
              </div>
          </header>
          
          <main>
              <div class="card">
                  <h1>Ciao #{username}!</h1>
                  
                  <div class="preferences">
                      <strong>Preferenze:</strong> #{ERB.new(decoded_prefs).result}
                  </div>
                  
                  <h2>Video consigliati</h2>
                  <ul class="video-list">
                      <li><a href=""></a></li>
                      <li><a href=""></a></li>
                  </ul>
              </div>
          </main>
      </div>
  </body>
  </html>
  HTML
end

get '/' do
  username = current_user(request)
  return redirect '/login' unless username
  
  preferences = request.cookies['preferences'] || Base64.strict_encode64('nuovo utente')
  render_home(username, preferences)
end

get '/register' do
  <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
      <title>Register | ytRecommender</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      #{styles}
  </head>
  <body>
      <div class="container">
          <header>
              <div class="logo">ytRecommender</div>
              <div class="nav-links">
                  <a href="/login">Login</a>
              </div>
          </header>
          
          <main>
              <div class="card">
                  <h1>Crea Account</h1>
                  
                  <form action='/register' method='POST'>
                      <div class="form-group">
                          <label for="username">Username</label>
                          <input type="text" name="username" required placeholder="username">
                      </div>
                      
                      <div class="form-group">
                          <label for="password">Password</label>
                          <input type="password" name="password" required placeholder="password">
                      </div>
                      
                      <button type="submit">Register</button>
                  </form>
                  
                  <p style="margin-top: 1.5rem">Hai già un account? <a href="/login">Login</a></p>
              </div>
          </main>
      </div>
  </body>
  </html>
  HTML
end

post '/register' do
  username = params[:username]
  password = params[:password]
  
  if username.empty? || password.empty?
    return <<~HTML
    <div class="container">
        <div class="card">
            <div class="alert alert-danger">Username and password are required!</div>
            <p><a href="/register">Try again</a></p>
        </div>
    </div>
    HTML
  end
  
  if USERS.key?(username)
    <<~HTML
    <div class="container">
        <div class="card">
            <div class="alert alert-danger">Username già occupato!</div>
            <p><a href="/register">Try again</a></p>
        </div>
    </div>
    HTML
  else
    USERS[username] = { password: password }
    
    response.set_cookie('session_token', 
        value: generate_jwt(username),
        httponly: true,
        path: '/',
        secure: ENV['RACK_ENV'] == 'production'
    )
    
    response.set_cookie('preferences',
        value: Base64.strict_encode64('nuovo utente'),
        path: '/'
    )
    
    redirect '/'
  end
end

get '/login' do
  <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
      <title>Login | ytRecommender</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      #{styles}
  </head>
  <body>
      <div class="container">
          <header>
              <div class="logo">ytRecommender</div>
              <div class="nav-links">
                  <a href="/register">Register</a>
              </div>
          </header>
          
          <main>
              <div class="card">
                  <h1>Migliori video yt!</h1>
                  
                  <form action='/login' method='POST'>
                      <div class="form-group">
                          <label for="username">Username</label>
                          <input type="text" name="username" required placeholder="Enter your username">
                      </div>
                      
                      <div class="form-group">
                          <label for="password">Password</label>
                          <input type="password" name="password" required placeholder="Enter your password">
                      </div>
                      
                      <button type="submit">Login</button>
                  </form>
                  
                  <p style="margin-top: 1.5rem">Non hai un account? <a href="/register">Registrati</a></p>
              </div>
          </main>
      </div>
  </body>
  </html>
  HTML
end

post '/login' do
  username = params[:username]
  password = params[:password]
  
  if USERS.key?(username) && USERS[username][:password] == password
    response.set_cookie('session_token', 
        value: generate_jwt(username),
        httponly: true,
        path: '/',
        secure: ENV['RACK_ENV'] == 'production'
    )
    
    redirect '/'
  else
    <<~HTML
    <div class="container">
        <div class="card">
            <div class="alert alert-danger">Login invalido!</div>
            <p><a href="/login">riprova</a></p>
        </div>
    </div>
    HTML
  end
end

post '/logout' do
  response.delete_cookie('session_token')
  response.delete_cookie('preferences')
  redirect '/login'
end

not_found do
  <<~HTML
  <div class="container">
      <div class="card">
          <h1>Page Not Found</h1>
          <div class="alert alert-danger">
              <p>The page you requested could not be found.</p>
              <p><a href="/">Return to homepage</a></p>
          </div>
      </div>
  </div>
  HTML
end

error do
  <<~HTML
  <div class="container">
      <div class="card">
          <h1>Server Error</h1>
          <div class="alert alert-danger">
              <p>An unexpected error occurred: #{env['sinatra.error'].message}</p>
              <p><a href="/">Return to homepage</a></p>
          </div>
      </div>
  </div>
  HTML
end