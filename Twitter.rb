require 'REST'
require 'json'
require 'cgi'
#params = {"username"=>'peterneubauer', 'password'=>'xxx'}
params = {"username"=>'thoughtmade', 'password'=>'xxx'}
conn = REST::Connection.new 'http://api.twitter.com/peterneubauer', params
followers = JSON.parse(conn.request_get('/friends/ids.json'))
puts followers.inspect
for i in 0..followers.length/2 do
  first = JSON.parse(conn.request_get('/users/show.json', {'id'=>followers[i].to_s}))['screen_name']
  second = JSON.parse(conn.request_get('/users/show.json', {'id'=>followers[followers.length-1-i].to_s}))['screen_name']
  puts first + ', you should talk to ' + second
#  url = '/statuses/update.json'
#  puts JSON.parse(conn.request_post(url, {'status'=>"\@"+first+', you should hook up with ' + "\@" + second}))  
end
first = 'peterneubauer'
second = 'jakewins'
url = '/statuses/update.json'
puts JSON.parse(conn.request_post(url, {'status'=>"\@"+first+', you should talk to ' + "\@" + second}))  
