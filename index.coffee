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

# Droplets
application.get \
	'/droplets'
	, (request, response)->
		console.log 'Droplets'
		do (request, response)->
			droplets = []
			droplets_list = (error, reply)->
				droplets = droplets.concat reply.body.droplets

				if reply.next
					reply.next droplets_list
				else
					response.send JSON.stringify(droplets)

			digitalocean.droplets.list droplets_list

application.post \
	'/droplets'
	, (request, response)->
		droplet_data =
			name: digitalocean_config.defaults.name_prefix + uuid.v4()
			region: digitalocean_config.defaults.region
			size: digitalocean_config.defaults.size
			image: digitalocean_config.defaults.image
			ssh_keys: digitalocean_config.defaults.ssh_keys

		console.log "Droplet create"

		digitalocean.droplets.create \
			droplet_data
			, (error, reply)->
				response.send JSON.stringify(reply.body)

application.get \
	'/droplets/:id'
	, (request, response)->
		console.log 'Droplet get by id'
		do (request, response)->
			digitalocean.droplets.fetch \
				request.params.id
				, (error, reply)->
					response.send JSON.stringify(reply.body)

application.delete \
	'/droplets/:id'
	, (request, response)->
		console.log "Droplet remove #{request.params.id}"
		do (request, response)->
			digitalocean.droplets.remove \
				request.params.id
				, (error, reply)->
					response.send JSON.stringify(reply.body)

# Get actions executed on the droplet
application.get \
	'/droplets/:id/actions'
	, (request, response)->
		console.log "Droplet #{request.params.id} get actions"
		do (request, response)->
			digitalocean.droplets.fetchActions \
				request.params.id
				, (error, reply)->
					response.send JSON.stringify(reply.body)

# Get action by id from all actions on the account
application.get \
	'/actions/:id'
	, (request, response)->
		console.log "Get action #{request.params.id}"
		do (request, response)->
			digitalocean.actions.fetch \
				request.params.id
				, (error, reply)->
					response.send JSON.stringify(reply.body)

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
