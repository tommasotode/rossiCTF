require 'sinatra'
require 'securerandom'
require 'jwt'
require 'base64'
require 'pstore'

enable :sessions
set :session_secret, ENV['SESSION_SECRET'] || SecureRandom.hex(64)
set :bind, '0.0.0.0'
set :port, ENV['PORT'] || 4567
set :public_folder, 'public'

FLAG = ENV['FLAG'] || "CTF{dummy_flag_for_local_testing}"
JWT_SECRET = ENV['JWT_SECRET'] || SecureRandom.hex(64)
USER_DB_FILE = "users.pstore"

USER_DB = PStore.new(USER_DB_FILE)
USER_DB.transaction do
  unless USER_DB[:users]
    USER_DB[:users] = {
      'admin' => {
        password: 'asdasdasdasd12482394',
        premium: true
      }
    }
  end
end

def generate_jwt(username)
  user = get_user(username)
  return nil unless user
  
  payload = {
    sub: username,
    exp: Time.now.to_i + 3600,
    iat: Time.now.to_i,
    premium: user[:premium]
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
    username = decoded[0]['sub']
    get_user(username) ? username : nil
  rescue
    nil
  end
end

def get_user(username)
  USER_DB.transaction(true) do
    USER_DB[:users][username]
  end
end

def add_user(username, password)
  USER_DB.transaction do
    return false if USER_DB[:users].key?(username)
    USER_DB[:users][username] = {
      password: password,
      premium: false
    }
    true
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
    
    .premium-badge {
      display: inline-block;
      background: linear-gradient(135deg, #ff9a9e, #fad0c4);
      color: #8a2387;
      padding: 0.3rem 0.8rem;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: bold;
      margin-left: 1rem;
      vertical-align: middle;
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
    
    .logo-img {
      height: 40px;
      margin-right: 10px;
      vertical-align: middle;
    }
  </style>
  CSS
end

# Vulnerable template rendering
def render_home(username, preferences)
  user = get_user(username)
  return redirect '/login' unless user
  
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
              <div class="logo">📺 TubeRec</div>
              <div class="nav-links">
                  <a href="/">Home</a>
                  <form action='/logout' method='POST' style="display:inline">
                      <button type='submit' class="btn-danger">Logout</button>
                  </form>
              </div>
          </header>
          
          <main>
              <div class="card">
                  <h1>Welcome back, #{username}!</h1>
                  #{'<span class="premium-badge">PREMIUM</span>' if user[:premium]}
                  
                  <div class="preferences">
                      <strong>Your preferences:</strong> #{ERB.new(decoded_prefs).result}
                  </div>
                  
                  <h2>Recommended Videos</h2>
                  <ul class="video-list">
                      <li><a href="https://youtu.be/dQw4w9WgXcQ">Top Security Tips for Developers</a></li>
                      <li><a href="https://youtu.be/jNQXAC9IVRw">Web Development Masterclass</a></li>
                      <li><a href="https://youtu.be/LDU_Txk06tM">Advanced CTF Techniques</a></li>
                      <li><a href="https://youtu.be/3JluqTojuME">Ruby Programming Secrets</a></li>
                      <li><a href="https://youtu.be/7Q17ubqLfaM">Modern Web Design Principles</a></li>
                  </ul>
              </div>
          </main>
          
          <footer class="footer">
              <p>TubeRec &copy; 2023 | Your personalized video recommendation system</p>
          </footer>
      </div>
  </body>
  </html>
  HTML
end

# Home page (requires authentication)
get '/' do
  username = current_user(request)
  return redirect '/login' unless username
  
  preferences = request.cookies['preferences'] || Base64.strict_encode64('Security Enthusiasts')
  render_home(username, preferences)
end

# Registration page
get '/register' do
  <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
      <title>Register | TubeRec</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      #{styles}
  </head>
  <body>
      <div class="container">
          <header>
              <div class="logo">📺 TubeRec</div>
              <div class="nav-links">
                  <a href="/login">Login</a>
              </div>
          </header>
          
          <main>
              <div class="card">
                  <h1>Create Account</h1>
                  
                  <form action='/register' method='POST'>
                      <div class="form-group">
                          <label for="username">Username</label>
                          <input type="text" name="username" required placeholder="Enter your username">
                      </div>
                      
                      <div class="form-group">
                          <label for="password">Password</label>
                          <input type="password" name="password" required placeholder="Create a password">
                      </div>
                      
                      <button type="submit">Register</button>
                  </form>
                  
                  <p style="margin-top: 1.5rem">Already have an account? <a href="/login">Sign in</a></p>
              </div>
          </main>
          
          <footer class="footer">
              <p>TubeRec &copy; 2023 | Your personalized video recommendation system</p>
          </footer>
      </div>
  </body>
  </html>
  HTML
end

# Registration handler
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
  
  if add_user(username, password)
    response.set_cookie('session_token', 
        value: generate_jwt(username),
        httponly: true,
        path: '/',
        secure: ENV['RACK_ENV'] == 'production'
    )
    
    # Set default preferences
    response.set_cookie('preferences',
        value: Base64.strict_encode64('New Users'),
        path: '/'
    )
    
    redirect '/'
  else
    <<~HTML
    <div class="container">
        <div class="card">
            <div class="alert alert-danger">Username already taken!</div>
            <p><a href="/register">Try again</a></p>
        </div>
    </div>
    HTML
  end
end

# Login page
get '/login' do
  <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
      <title>Login | TubeRec</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      #{styles}
  </head>
  <body>
      <div class="container">
          <header>
              <div class="logo">ytReccomend</div>
              <div class="nav-links">
                  <a href="/register">Register</a>
              </div>
          </header>
          
          <main>
              <div class="card">
                  <h1>Welcome to TubeRec</h1>
                  <p>Your personalized video recommendation system</p>
                  
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
                  
                  <p style="margin-top: 1.5rem">Don't have an account? <a href="/register">Register now</a></p>
              </div>
          </main>
      </div>
  </body>
  </html>
  HTML
end

# Login handler
post '/login' do
  username = params[:username]
  password = params[:password]
  
  user = get_user(username)
  
  if user && user[:password] == password
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
            <div class="alert alert-danger">Invalid credentials!</div>
            <p><a href="/login">Try again</a></p>
        </div>
    </div>
    HTML
  end
end

# Logout handler
post '/logout' do
  response.delete_cookie('session_token')
  response.delete_cookie('preferences')
  redirect '/login'
end

# Flag endpoint (only for premium users)
get '/flag' do
  username = current_user(request)
  return redirect '/login' unless username
  
  user = get_user(username)
  if user && user[:premium]
    FLAG
  else
    status 403
    <<~HTML
    <div class="container">
        <div class="card">
            <h1>Premium Access Required</h1>
            <div class="alert alert-danger">
                <p>You need a premium account to access this feature!</p>
                <p>Contact support to upgrade your account.</p>
            </div>
        </div>
    </div>
    HTML
  end
end

# Error handling
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