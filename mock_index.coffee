# Express application
express = require 'express'
application = new express()

# Digital Ocean API
digitalocean_credentials = require('./config.json').nautical
digitalocean = require('nautical').getClient digitalocean_credentials

# Digital Ocean droplet defaults
digitalocean_config = require('./config.json').digitalocean

# Unique generator
uuid = require 'node-uuid'

console.log process.argv[2]

# Droplets
application.get \
	'/droplets'
	, (request, response)->
		console.log 'Droplets mock'
		response.send '[{"id":2269164,"name":"gc-f118f994-b937-4175-97c4-b0cb8e859f7e","memory":512,"vcpus":1,"disk":20,"region":{"slug":"ams1","name":"Amsterdam 1","sizes":["512mb","1gb","4gb","2gb","8gb"],"available":true,"features":["virtio","backups"]},"image":{"id":5141286,"name":"Ubuntu 14.04 x64","distribution":"Ubuntu","slug":"ubuntu-14-04-x64","public":true,"regions":["nyc1","ams1","sfo1","nyc2","ams2","sgp1","lon1"],"created_at":"2014-07-23T17:08:52Z"},"size":{"slug":"512mb","transfer":1,"price_monthly":5,"price_hourly":0.00744},"locked":true,"status":"active","networks":{"v4":[{"ip_address":"146.185.153.139","netmask":"255.255.255.0","gateway":"146.185.153.1","type":"public"}],"v6":[]},"kernel":{"id":1221,"name":"* Ubuntu 14.04 x64 vmlinuz-3.13.0-24-generic (1221)","version":"3.13.0-24-generic"},"created_at":"2014-08-06T15:54:19Z","features":["virtio"],"backup_ids":[],"snapshot_ids":[],"action_ids":[30280873]}]'


application.post \
	'/droplets'
	, (request, response)->
		droplet_data =
			name: digitalocean_config.defaults.name_prefix + uuid.v4()
			region: digitalocean_config.defaults.region
			size: digitalocean_config.defaults.size
			image: digitalocean_config.defaults.image
			ssh_keys: digitalocean_config.defaults.ssh_keys

		console.log "Droplet mock create"
		if process.argv[2] == 'fail'
			# Fail
			response.send '{"id":"unprocessable_entity","message":"Name Only valid hostname characters are allowed. (a-z, A-Z, 0-9, . and -)"}'
		else
			# Success
			response.send '{"droplet":{"id":2269164,"name":"gc-f118f994-b937-4175-97c4-b0cb8e859f7e","memory":512,"vcpus":1,"disk":20,"region":{"slug":"ams1","name":"Amsterdam 1","sizes":["512mb","1gb","4gb","2gb","8gb"],"available":true,"features":["virtio","backups"]},"image":{"id":5141286,"name":"Ubuntu 14.04 x64","distribution":"Ubuntu","slug":"ubuntu-14-04-x64","public":true,"regions":["nyc1","ams1","sfo1","nyc2","ams2","sgp1","lon1"],"created_at":"2014-07-23T17:08:52Z"},"size":{"slug":"512mb","transfer":1,"price_monthly":5,"price_hourly":0.00744},"locked":true,"status":"new","networks":{},"kernel":{"id":1221,"name":"* Ubuntu 14.04 x64 vmlinuz-3.13.0-24-generic (1221)","version":"3.13.0-24-generic"},"created_at":"2014-08-06T16:02:35Z","features":["virtio"],"backup_ids":[],"snapshot_ids":[],"action_ids":[30281380]},"links":{"actions":[{"id":30281380,"rel":"create","href":"http://api.digitalocean.com/v2/actions/30281380"}]}}'


application.get \
	'/droplets/:id'
	, (request, response)->
		console.log 'Droplet mock get by id'
		if process.argv[2] == 'wip'
			# WIP
			response.send '{"droplet":{"id":2269164,"name":"gc-f118f994-b937-4175-97c4-b0cb8e859f7e","memory":512,"vcpus":1,"disk":20,"region":{"slug":"ams1","name":"Amsterdam 1","sizes":["512mb","1gb","4gb","2gb","8gb"],"available":true,"features":["virtio","backups"]},"image":{"id":5141286,"name":"Ubuntu 14.04 x64","distribution":"Ubuntu","slug":"ubuntu-14-04-x64","public":true,"regions":["nyc1","ams1","sfo1","nyc2","ams2","sgp1","lon1"],"created_at":"2014-07-23T17:08:52Z"},"size":{"slug":"512mb","transfer":1,"price_monthly":5,"price_hourly":0.00744},"locked":true,"status":"new","networks":{},"kernel":{"id":1221,"name":"* Ubuntu 14.04 x64 vmlinuz-3.13.0-24-generic (1221)","version":"3.13.0-24-generic"},"created_at":"2014-08-06T15:54:19Z","features":["virtio"],"backup_ids":[],"snapshot_ids":[],"action_ids":[30280873]}}'
		else
			# Done
			response.send '{"droplet":{"id":2269164,"name":"gc-f118f994-b937-4175-97c4-b0cb8e859f7e","memory":512,"vcpus":1,"disk":20,"region":{"slug":"ams1","name":"Amsterdam 1","sizes":["512mb","1gb","4gb","2gb","8gb"],"available":true,"features":["virtio","backups"]},"image":{"id":5141286,"name":"Ubuntu 14.04 x64","distribution":"Ubuntu","slug":"ubuntu-14-04-x64","public":true,"regions":["nyc1","ams1","sfo1","nyc2","ams2","sgp1","lon1"],"created_at":"2014-07-23T17:08:52Z"},"size":{"slug":"512mb","transfer":1,"price_monthly":5,"price_hourly":0.00744},"locked":true,"status":"active","networks":{"v4":[{"ip_address":"146.185.153.139","netmask":"255.255.255.0","gateway":"146.185.153.1","type":"public"}],"v6":[]},"kernel":{"id":1221,"name":"* Ubuntu 14.04 x64 vmlinuz-3.13.0-24-generic (1221)","version":"3.13.0-24-generic"},"created_at":"2014-08-06T15:54:19Z","features":["virtio"],"backup_ids":[],"snapshot_ids":[],"action_ids":[30280873]}}'


application.delete \
	'/droplets/:id'
	, (request, response)->
		console.log "Droplet mock remove #{request.params.id}"
		if process.argv[2] == 'fail'
			# Fail
			response.send 'bleh'
		else
			# Success
			response.send '""'


# Get action by id from all actions on the account
application.get \
	'/actions/:id'
	, (request, response)->
		console.log "Mock Get action #{request.params.id}"
		if process.argv[2] == 'wip'
			response.send '{"action":{"id":30451157,"status":"in-progress","type":"create","started_at":"2014-08-09T10:12:39Z","completed_at":"2014-08-09T10:15:04Z","resource_id":2292375,"resource_type":"droplet","region":"ams1"}}'
		if process.argv[2] == 'fail'
			response.send '{"action":{"id":30451157,"status":"errored","type":"create","started_at":"2014-08-09T10:12:39Z","completed_at":"2014-08-09T10:15:04Z","resource_id":2292375,"resource_type":"droplet","region":"ams1"}}'
		else
			response.send '{"action":{"id":30451157,"status":"completed","type":"create","started_at":"2014-08-09T10:12:39Z","completed_at":"2014-08-09T10:15:04Z","resource_id":2292375,"resource_type":"droplet","region":"ams1"}}'


# Regions
application.get \
	'/regions'
	, (request, response)->
		console.log 'Regions'
		digitalocean.regions.list (error, reply)->
			console.log reply.body
			response.send JSON.stringify(reply.body)

# Images
application.get \
	'/images'
	, (request, response)->
		console.log 'Images'
		do (request, response)->
			images = []
			images_list = (error, reply)->
				images = images.concat reply.body.images

				if reply.next
					reply.next images_list
				else
					console.log "Done"
					response.send JSON.stringify(images)

			digitalocean.images.list images_list

# Sizes
application.get \
	'/sizes'
	, (request, response)->
		console.log 'Sizes'
		do (request, response)->
			sizes = []
			sizes_list = (error, reply)->
				sizes = sizes.concat reply.body.sizes

				if reply.next
					reply.next sizes_list
				else
					console.log "Done"
					response.send JSON.stringify(sizes)

			digitalocean.sizes.list sizes_list

# Keys
application.get \
	'/keys'
	, (request, response)->
		console.log 'Keys'
		do (request, response)->
			keys = []
			keys_list = (error, reply)->
				keys = keys.concat reply.body.ssh_keys

				if reply.next
					reply.next keys_list
				else
					response.send JSON.stringify(keys)

			digitalocean.keys.list keys_list

# Start server
server = application.listen \
	8000
	, ()->
		console.log "Listening on port #{server.address().port}"
