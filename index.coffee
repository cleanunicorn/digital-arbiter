# Express application
express = require 'express'
application = new express()

# Digital Ocean API
digitalocean_credentials = require('./config.json').nautical
digitalocean = require('nautical').getClient digitalocean_credentials

# Load droplet model
# droplets = require './droplets.js'

# Droplets
application.get \
	'/droplets'
	, (request, response)->
		console.log 'Droplets'
		digitalocean.droplets.list (error, reply)->
			console.log reply.body
			response.send JSON.stringify(reply.body)

application.post \
	'/droplets'
	, (request, response)->
		droplet_data =
			name: 'test'
			region: 'ams1'
			size: '512mb'
			image: '5141286' # Ubuntu 14.04 x64

		console.log "Droplet create"
		console.log droplet_data

		digitalocean.droplets.create \
			droplet_data
			, (error, reply)->
				console.log reply.body
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
		digitalocean.images.list (error, reply)->
			console.log reply.body
			response.send JSON.stringify(reply.body)

# Sizes
application.get \
	'/sizes'
	, (request, response)->
		console.log 'Sizes'
		digitalocean.sizes.list (error, reply)->
			console.log reply.body
			response.send JSON.stringify(reply.body)


server = application.listen \
	8000
	, ()->
		console.log "Listening on port #{server.address().port}"
