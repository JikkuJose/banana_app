desc 'Setup project'
task :setup do
  system("bundle install")
  File.open('.env', 'w') { |f| f.write env_content }
end

def env_content
  <<-TEXT
BANANA_APP_ID = 999999999999
BANANA_APP_SECRET = 'long-string-from-FD'
BANANA_COOKIE_SECRET = 'long-random-string'
TEXT
end
