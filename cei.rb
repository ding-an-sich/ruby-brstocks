require 'mechanize'
require 'timeout'
require 'io/console'

# Get username and password
puts 'username'
username = gets.chomp
pass = STDIN.getpass("pass\n")

# Initialize Mechanize agent for crawling
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
cert_store = OpenSSL::X509::Store.new
cert_store.add_file 'certs/cei-b3-com-br.pem'
cert_store.add_file 'certs/cei-b3-com-br-chain.pem'
agent.cert_store = cert_store

# Crawl CEI
cei = agent.get 'https://cei.b3.com.br/CEI_Responsivo/'
login_form = cei.form('aspnetForm')
login_form.field_with(id: 'ctl00_ContentPlaceHolder1_txtLogin').value = username
login_form.field_with(id: 'ctl00_ContentPlaceHolder1_txtSenha').value = pass
Timeout.timeout(10) do
  cei = agent.submit(login_form, login_form.buttons.first)
end
pp cei
