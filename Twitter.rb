require 'REST'
require 'json'
require 'cgi'
themes = ['trees','love','innovation','disruptive thinking','sex','the best party you ever were at','going TOTAL WIN WIN later','the best dating strategies','Copenhagen','MINC Malmö','WIN WIN Total','Inkonst','the next Thoughtmade','education in Malmö','dogs','innovation','the value of creativity','art and business','possbile collaboration','parenthood and innovation','the best beer in Sweden','desserts','buying each other a beer''buying houses outside Malmö','the Öresund region','Malmö vs. Copenhagen']
params = {"username"=>ARGV[0], 'password'=>ARGV[1]}
conn = REST::Connection.new 'http://api.twitter.com/'+params['username'], params
followers = JSON.parse(conn.request_get('/friends/ids.json'))
puts followers.inspect
def resolve_name(conn, id)
  puts 'id=' + id
  name = JSON.parse(conn.request_get('/users/show.json', {'id'=>id}))['screen_name']
  if name == nil
    puts 'retrying'
    sleep 20
    resolve_name(conn, id)
  end
  puts 'name->' + name
  name
end
for i in 0..1000 do
  first_id = followers[rand(followers.length)].to_s
  first = resolve_name(conn, first_id)
  sleep 2
  second_id = followers[rand(followers.length)].to_s
  second = resolve_name(conn, second_id)
  sleep 2
  theme = themes[rand(themes.length)]
  status = "\@"+first + ", why not have a chat with \@" + second + ' about ' + theme + ' at #thoughtmade'
  puts status
  sleep 2
  url = '/statuses/update.json'
  puts JSON.parse(conn.request_post(url, {'status'=>status}))  
  sleep 60
end