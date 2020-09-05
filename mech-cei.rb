require 'mechanize'
require 'timeout'
require 'io/console'

# Get username and password
puts 'username'
username = gets.chomp
pass = STDIN.getpass("pass\n")
puts 'Logging in...'

# Initialize Mechanize agent for crawling and populate SSL certs
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
cert_store = OpenSSL::X509::Store.new
cert_store.add_file 'certs/cei-b3-com-br.pem'
cert_store.add_file 'certs/cei-b3-com-br-chain.pem'
agent.cert_store = cert_store

# Submits login form
cei = agent.get 'https://cei.b3.com.br/CEI_Responsivo/'
login_form = cei.form('aspnetForm')
login_form.field_with(id: 'ctl00_ContentPlaceHolder1_txtLogin').value = username
login_form.field_with(id: 'ctl00_ContentPlaceHolder1_txtSenha').value = pass
Timeout.timeout(10) do
  # Using a timeout to deal with CEI unresponsiveness
  cei = agent.submit(login_form, login_form.buttons.first)
end

# Get and print consolidated position
positions = cei.xpath('//tbody/tr/td')
positions.pop # We don't want CEI advertising
puts "\n\n"
positions.each do |position|
  puts position.text
end

puts "\nFinished!"
