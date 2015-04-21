gameSpeed = 700 # ms

Meteor.methods
#  gameInfo: () -> Game.findOne()
#  toggleGame: () ->
#    info = Game.findOne()
#    newrunningStatus = not info.running
#    info.running = newrunningStatus
#    if newrunningStatus
#      startmoving = 
#      info.refreshIntervalId = Meteor.setInterval startmoving gameSpeed
#
#    Game.update(info._id, {$set: info})
#    info
  startGame: () ->
    startmoving = ->
#      console.log "a"
      cursor = Animals.find()
      cursor.map (animalData) ->
        animal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
#        console.log "move hungry animal", animal
        animal.move()
#        console.log "a1"
        animal.makeHungry()
#        console.log "move hungry animal after", animal
#        console.log "a2"
        Animals.update {_id: animalData._id}, {$set: animal.toObj()}
#        console.log "a3"

    info = Games.findOne()
    unless info.movement_interval is undefined
      Meteor.clearInterval movement_interval

    movement_interval = Meteor.setInterval startmoving, gameSpeed
    console.log "movement_interval", movement_interval
    running = true
    console.log "game update", info
    Games.update {_id: info._id}, {$set: {movement_interval: movement_interval, running: running}}
    false
    
    #move, draw,  test
#      animals = for animalData in animalDataBatch
#      animal

#  refreshZoo = ->
#    animals = Meteor.call "getAnimals", (err, animalDataBatch) ->
#      animals = for animalData in animalDataBatch
#        animal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
#        animal
#        
#      Zoo.update()
#  Meteor.setInterval(refreshZoo, 700)
#        
#    moveAndDraw = ->
#        animal.makeHungry()
#        animal.move()
#      Zoo.update animals
#    Meteor.setInterval(moveAndDraw, 700)
#  @subscribe "animals", 


      
#    Animals.getHungry; Animals.move