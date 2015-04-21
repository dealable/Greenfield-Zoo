Template.zoo.helpers
  running: ->
    info = Games.findOne()
    console.log "info", info
    if Games.findOne()
      Games.findOne().running
    else
      false
  
Template.zoo.events
#    'click #btn_game_start': ->
#  '#canvas': -> 
#    animals = Meteor.call "getAnimals"
#    Zoo.update animals

  "click #b2": -> 
    info = Games.findOne()
    console.log info
  "click #btn_start": ->

#    info = Games.findOne()
#    console.log "info", info
#
#    if info
#      if info.refreshIntervalId?
#        Meteor.clearInterval info.refreshIntervalId
#        info.refreshIntervalId = undefined
#        info.running = false
#      else
#        Meteor.call "startGame", info
#    else
#      _id = Games.insert {}
#      info = Games.findOne()
#      Meteor.call "startGame", info
#
#    animals = Meteor.call "getAnimals", (e,r) ->
#      console.log "animals1", r
    Meteor.call "startGame"
#    f = ->
#      cursor = Animals.find()
#      cursor.map (animalData) ->
#        animal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
##        console.log "move hungry animal", animal
#        animal.move()
#        animal.makeHungry()
##        console.log "move hungry animal after", animal
#        Animals.update {_id: animalData._id}, {$set: animal.toObj()}
#      Zoo.refresh()
#    Meteor.setInterval f, 700
#        
#        
#    info = Games.findOne()
#
#    if info
#      if info.refreshIntervalId?
#        Meteor.clearInterval info.refreshIntervalId
#        info.refreshIntervalId = undefined
#        info.running = false
#      else
#        Meteor.call "startGame", info
#    else
#      _id = Games.insert {}
#      info = Games.findOne()
#      Meteor.call "startGame", info

#    animals = Meteor.call "getAnimals", (e,r) ->
#      console.log "animals1", r
  
  'mousedown #canvas': (event, handler) ->
    event.preventDefault()
    event.stopPropagation()
  'contextmenu #canvas': (event, handler) ->
    event.preventDefault()
    event.stopPropagation()

  'mouseup #canvas': (event, handler) ->
    event.preventDefault()
    event.stopPropagation()

#   may be needed later    
#    canvasMinX = $("#canvas").offset().left;
#    canvasMaxX = canvasMinX + WIDTH;

    ## check which X, Y to use
    switch event.which
      when 1
        x = event.offsetX
        y = event.offsetY
        
        action = (animalData) ->
          Animals.update({_id: animalData._id}, { $set: { hunger: 0} })
          console.log "#{animalData._id} at #{x}, #{y} fed"
          
        animalData = locateAnimal x, y, action
        

#        found = false
#
#        for animal in animals when not found
#          distance = ((x - animal.x)**2 + (y - animal.y)**2)**(1/2)
#          inrange = distance < animal.size
#          if inrange
#            animal.hunger = 0
#            found = true
#            console.log "fed first animal sitting on ", x, y

      when 2  #middle button
        x = event.offsetX
        y = event.offsetY
        
        action = (animalData) ->
          Animals.remove({_id: animalData._id})
          console.log "#{animalData._id} at #{x}, #{y} removed"
          
        animalData = locateAnimal x, y, action
#        unless animalData is undefined
  
      when 3
        newanimal = new Animal 0, 2, event.offsetX, event.offsetY
        obj = newanimal.toObj()
        obj.created = new Date()
        _id = Animals.insert obj
        console.log "newanimal #{_id} added at  #{obj.x}, #{obj.y}"
#        mongoId = Meteor.call 'addAnimal', newanimal
#        newanimal._id = mongoId

#        else # some other button
#          alert('You have a strange Mouse!')
#      keys = []
#      for a in ["client","offset","page"]
#        for b in ["X","Y"]
#          keys.push "#{a}#{b}"
#      console.log "evt", (("#{key} #{event[key]}") for key in keys)
