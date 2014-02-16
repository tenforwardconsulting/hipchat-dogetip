desc 'Create hipcat webhook to listen for dogecoin tip'
task :create_webhook => :dotenv do |t|
  abort 'Set ROOM_ID in .env' unless ENV['ROOM_ID']
  abort 'Set AUTH_TOKEN in .env' unless ENV['AUTH_TOKEN']

  url = "https://api.hipchat.com/v2/room/#{ENV['ROOM_ID']}/webhook"

  body = {
    url: 'http://doge.10fw.net',
    pattern: '\+\d*\s*\(doge(coin)?\)\s*@(\w*)',
    event: 'room_notification',
    hook_name: 'dogetip_listener'
  }.to_json

  headers = {
    'content-type' => 'application/json',
    'accept' => 'application/json'
  }

  query = {
    auth_token: ENV['AUTH_TOKEN']
  }
  query.merge! auth_test: true if ENV['AUTH_TEST']

  resp = HTTParty.post url,
    body: body,
    headers: headers,
    query: query

  ap resp
end
