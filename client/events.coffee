gameSpeed = 700 # ms

Template.zoo.helpers
  running: ->
    info = Games.findOne()
    console.log "info", info
    if Games.findOne()
      Games.findOne().running
    else
      false
  
Template.zoo.events
  "click #b2": -> 
    info = Games.findOne()
    console.log info

  "click #btn_local": ->
    startmoving = ->
      cursor = Animals.find()
      cursor.map (animalData) ->
        animal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
        animal.move()
        animal.makeHungry()
        Animals.update {_id: animalData._id}, {$set: animal.toObj()}

    info = Session.get "movement_interval"
    unless info?.movement_interval is undefined
      Meteor.clearInterval movement_interval

    movement_interval = Meteor.setInterval startmoving, gameSpeed
    console.log "movement_interval", movement_interval
    Session.set "movement_interval", movement_interval

    
  "click #btn_start": ->
    Meteor.call "startGame"
  
  'mousedown #canvas': (event, handler) ->
    event.preventDefault()
    event.stopPropagation()
  'contextmenu #canvas': (event, handler) ->
    event.preventDefault()
    event.stopPropagation()

  'mouseup #canvas': (event, handler) ->
    event.preventDefault()
    event.stopPropagation()

    switch event.which
      when 1 #left click feeds animal
        x = event.offsetX
        y = event.offsetY
        
        action = (animalData) ->
          Animals.update({_id: animalData._id}, { $set: { hunger: 0} })
          console.log "#{animalData._id} at #{x}, #{y} fed"
          
        animalData = locateAnimal x, y, action
        
      when 2  #middle button removes animal
        x = event.offsetX
        y = event.offsetY
        
        action = (animalData) ->
          Animals.remove({_id: animalData._id})
          console.log "#{animalData._id} at #{x}, #{y} removed"
          
        animalData = locateAnimal x, y, action

      when 3 # right click adds animal
        newanimal = new Animal 0, 2, event.offsetX, event.offsetY
        obj = newanimal.toObj()
        obj.created = new Date()
        _id = Animals.insert obj
        console.log "newanimal #{_id} added at  #{obj.x}, #{obj.y}"
