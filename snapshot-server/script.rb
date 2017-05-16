require 'net/http'
require 'dotenv'
Dotenv.load

WIKI_URL = "https://wiki.metakgp.org"
ACCEPTED_RESPONSES = [200, 301, 302]
TOKEN = ENV['TOKEN']
DROPLET_ID = ENV['DROPLET_ID']
SNAPSHOT_NAME = "automatic-metakgp-wiki-#{Time.now.strftime '%Y-%m-%d'}"

puts "GET wiki => checking if Wiki is online"

uri = URI(WIKI_URL)
res = Net::HTTP.get_response(uri)

if ACCEPTED_RESPONSES.include? res.code.to_i
  puts "Wiki is up! Let's snapshot it!"

  require 'droplet_kit'

  client = DropletKit::Client.new(access_token: TOKEN)

  # droplets = client.droplets.find(id: "#{DROPLET_ID}")
  # puts droplets.inspect
  # puts droplets.snapshot_ids.inspect

  snapshots = client.droplets.snapshots(id: "#{DROPLET_ID}")

  snapshots.each do |snapshot|
    puts "#{snapshot.name} | #{snapshot.id} created at #{snapshot.created_at}"
  end

  # TODO: Decide the ID of the snapshot that we are going to delete

  snapshot_droplet = client.droplet_actions.snapshot(droplet_id: DROPLET_ID,
                                                     name: SNAPSHOT_NAME)
  puts snapshot_droplet

else
  puts "Wiki responded with #{res.code}, Wiki is NOT UP! :("
end


