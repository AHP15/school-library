require_relative './app'

def main
  app = App.new
  app.run
  puts 'Thank you for using this app!'
  app.store_data
end

main
