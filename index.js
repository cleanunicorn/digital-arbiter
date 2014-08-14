// Generated by CoffeeScript 1.7.1
var application, digitalocean, digitalocean_config, digitalocean_credentials, express, server, uuid;

express = require('express');

application = new express();

digitalocean_credentials = require('./config.json').nautical;

digitalocean = require('nautical').getClient(digitalocean_credentials);

digitalocean_config = require('./config.json').digitalocean;

uuid = require('node-uuid');

application.get('/droplets', function(request, response) {
  console.log('Droplets');
  return (function(request, response) {
    var droplets, droplets_list;
    droplets = [];
    droplets_list = function(error, reply) {
      droplets = droplets.concat(reply.body.droplets);
      if (reply.next) {
        return reply.next(droplets_list);
      } else {
        return response.send(JSON.stringify(droplets));
      }
    };
    return digitalocean.droplets.list(droplets_list);
  })(request, response);
});

application.post('/droplets/:size', function(request, response) {
  var droplet_data, _ref;
  droplet_data = {
    name: digitalocean_config.defaults.name_prefix + uuid.v4(),
    region: digitalocean_config.defaults.region,
    size: (_ref = request.params.size) != null ? _ref : digitalocean_config.defaults.size,
    image: digitalocean_config.defaults.image,
    ssh_keys: digitalocean_config.defaults.ssh_keys
  };
  console.log("Droplet create");
  return digitalocean.droplets.create(droplet_data, function(error, reply) {
    return response.send(JSON.stringify(reply.body));
  });
});

application.get('/droplets/:id', function(request, response) {
  console.log('Droplet get by id');
  return (function(request, response) {
    return digitalocean.droplets.fetch(request.params.id, function(error, reply) {
      return response.send(JSON.stringify(reply.body));
    });
  })(request, response);
});

application["delete"]('/droplets/:id', function(request, response) {
  console.log("Droplet remove " + request.params.id);
  return (function(request, response) {
    return digitalocean.droplets.remove(request.params.id, function(error, reply) {
      return response.send(JSON.stringify(reply.body));
    });
  })(request, response);
});

application.post('/droplets/:id/reboot', function(request, response) {
  console.log("Droplet " + request.params.id + " reboot");
  return (function(request, response) {
    return digitalocean.dropletActions.reboot(request.params.id, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.post('/droplets/:id/shutdown', function(request, response) {
  console.log("Droplet " + request.params.id + " shutdown");
  return (function(request, response) {
    return digitalocean.dropletActions.shutdown(request.params.id, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.post('/droplets/:id/power_on', function(request, response) {
  console.log("Droplet " + request.params.id + " power_on");
  return (function(request, response) {
    return digitalocean.dropletActions.powerOn(request.params.id, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.post('/droplets/:id/power_off', function(request, response) {
  console.log("Droplet " + request.params.id + " power_off");
  return (function(request, response) {
    return digitalocean.dropletActions.powerOff(request.params.id, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.post('/droplets/:id/power_cycle', function(request, response) {
  console.log("Droplet " + request.params.id + " power_cycle");
  return (function(request, response) {
    return digitalocean.dropletActions.power_cycle(request.params.id, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.post('/droplets/:id/resize/:size', function(request, response) {
  console.log("Droplet " + request.params.id + " resize to " + request.params.size);
  return (function(request, response) {
    return digitalocean.dropletActions.resize(request.params.id, request.params.size, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.get('/droplets/:id/actions', function(request, response) {
  console.log("Droplet " + request.params.id + " get actions");
  return (function(request, response) {
    return digitalocean.droplets.fetchActions(request.params.id, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.get('/actions/:id', function(request, response) {
  console.log("Get action " + request.params.id);
  return (function(request, response) {
    return digitalocean.actions.fetch(request.params.id, function(error, reply) {
      return response.send(reply.res.statusCode, JSON.stringify(reply.body));
    });
  })(request, response);
});

application.get('/regions', function(request, response) {
  console.log('Regions');
  return digitalocean.regions.list(function(error, reply) {
    console.log(reply.body);
    return response.send(JSON.stringify(reply.body));
  });
});

application.get('/images', function(request, response) {
  console.log('Images');
  return (function(request, response) {
    var images, images_list;
    images = [];
    images_list = function(error, reply) {
      images = images.concat(reply.body.images);
      if (reply.next) {
        return reply.next(images_list);
      } else {
        console.log("Done");
        return response.send(JSON.stringify(images));
      }
    };
    return digitalocean.images.list(images_list);
  })(request, response);
});

application.get('/sizes', function(request, response) {
  console.log('Sizes');
  return (function(request, response) {
    var sizes, sizes_list;
    sizes = [];
    sizes_list = function(error, reply) {
      sizes = sizes.concat(reply.body.sizes);
      if (reply.next) {
        return reply.next(sizes_list);
      } else {
        console.log("Done");
        return response.send(JSON.stringify(sizes));
      }
    };
    return digitalocean.sizes.list(sizes_list);
  })(request, response);
});

application.get('/keys', function(request, response) {
  console.log('Keys');
  return (function(request, response) {
    var keys, keys_list;
    keys = [];
    keys_list = function(error, reply) {
      keys = keys.concat(reply.body.ssh_keys);
      if (reply.next) {
        return reply.next(keys_list);
      } else {
        return response.send(JSON.stringify(keys));
      }
    };
    return digitalocean.keys.list(keys_list);
  })(request, response);
});

server = application.listen(8000, function() {
  return console.log("Listening on port " + (server.address().port));
});
