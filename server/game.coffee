gameSpeed = 700 # ms

Meteor.methods

  startGame: () ->
    startmoving = ->
      cursor = Animals.find()
      cursor.map (animalData) ->
        animal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
        animal.move()
        animal.makeHungry()
        Animals.update {_id: animalData._id}, {$set: animal.toObj()}

    info = Games.findOne()
    unless info.movement_interval is undefined
      Meteor.clearInterval movement_interval

    movement_interval = Meteor.setInterval startmoving, gameSpeed
    console.log "movement_interval", movement_interval
    running = true
    #Games.update {_id: info._id}, {$set: {movement_interval: movement_interval, running: running}}