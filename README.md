# ruby-brstocks

Ruby script to login and retrieve financial information from B3 brazilian stock exchange CEI (Canal Eletrônico do Investidor).

## Running the script
- ruby 2.6.6 ++
- run bundle
- edit the script with your username (CPF) and password
- run ruby script.rb

## TODO
- save and retrieve position information
- use a more robust crawling library so that we can extract more information (mechanize, which this script uses, doesn't support evaluating javascript)
- test interaction with B3's upcoming apis (https://developers.b3.com.br)


