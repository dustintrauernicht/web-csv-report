require "sinatra"
require_relative "./csv.rb"

get '/homepage' do
	erb(:main)
end

get '/account/:name' do
	accounts = run_csv_processer
	name = params["name"]
	erb(:account, :locals => {info: accounts[name], name: name})
end

get '/full' do
	accounts = run_csv_processer
	erb(:full, :locals => {:accounts => accounts})
end

# Showing the form that they type new row values into.
get '/add_row_form' do
  erb(:add_row_form)
end

# Processes the form that they typed new row values into.
get '/add_row' do

  name = params["account"]
  date = params["date"]
  payee = params["payee"]
  category = params["category"]
  inflow = params["inflow"]
  outflow = params["outflow"]

  open('temp.txt', 'a') { |file|
    str = ""
    str << name + ","
    str << date + ","
    str << payee + ","
    str << category + ","
    str << inflow + ","
    str << outflow + "\n"

    file << str
  }

  erb(:success)
end