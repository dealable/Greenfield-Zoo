animals = []
refresh_speed = 500
#Meteor.startup -> Session.set "data_loaded", false
Meteor.subscribe "animals"

#    start = ->
#      animals.push animal for animal in AnimalService.createAnimals()
#      moveAndDraw = ->
#        AnimalService.moveAnimals animals
#        Canvas.update animals
#
#      setInterval(moveAndDraw, 700);
#    start()

Template.zoo.onRendered ->
  refresh_interval = Session.get "refresh_interval"
  unless refresh_interval is undefined
    Meteor.clearInterval refresh_interval
  refresh_interval = Meteor.setInterval Zoo.refresh, refresh_speed
  Session.set "refresh_interval", refresh_interval
#  callback = (err, animalsData) ->
#  for animalData in animalsData
#    animal = new Animal animal.hunger, animal.metabolism, animal.x0, animal.y0, animal.size, animal._id
#    moveAndDraw = ->
#        animal.makeHungry()
#        animal.move()
#      Zoo.update animals
#    Meteor.setInterval(moveAndDraw, 700)

#  Zoo.initialize()
#  Zoo.refresh()
  
  
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

#
#  if subscription.ready()
#    callback()
#  else
#    Meteor.setTimeout callback, 1000

#  sub = Meteor.subscribe "animals"
#  console.log "sub.onReady ",sub.onReady 
#  console.log "sub",sub.ready()


#  docs = (console.log doc._id for doc in cursor)
#  console.log "docs",docs

#  animalDataGroup = Animals.find().map(makeAnimal)
#  console.log animalDataGroup
#  console.log animal for animal in animalDataGroup
#
#  for animalData in animalDataGroup
#    console.log "animal data", animalData
#    newanimal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
#    console.log "animal data", newanimal
#    animals.push newanimal


#    start = ->
#      animals.push animal for animal in AnimalService.createAnimals()
#  moveAndDraw = ->
#    AnimalService.moveAnimals animals
#    Canvas.update animals
#
#    setInterval(moveAndDraw, 700);
#    start()
