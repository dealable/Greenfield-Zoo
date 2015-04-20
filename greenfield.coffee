# Set up a collection to contain information about each animal.

Animals = new Meteor.Collection 'animals'

# size of random animal movement
movementSize = 2

# maximum color strength
colorMax = 217

#    Hungryanimal extends Animal
class Animal
  constructor: (@hunger = 0, @metabolism = 1, @x0 = 150, @y0 = 150, @size = 10, @id = undefined) ->
    @x = @x0
    @y = @y0
  getHungry: ->
    @hunger += @metabolism unless @hunger >= 100
    #console.log "hunger", @hunger
  move: ->
    randomMovement = -> Math.random() * (2 * movementSize) - movementSize
    @x = @x0 + randomMovement()
    @y = @y0 + randomMovement()


Canvas = 
  update: (animals) ->
    canvas = document.getElementById("canvas");
    ctx = canvas.getContext("2d");
    ctx.clearRect(0,0,canvas.width, canvas.height);

    for animal in animals
      getColor = ->
        # hunger percentage x maximum color strength
        red = Math.round(animal.hunger/100 * colorMax)
        blue = Math.round((1 - animal.hunger/100) * colorMax)
        color = "rgb(#{red}, 0, #{blue})"
        #console.log "color", color
        color
      ctx.fillStyle = getColor()
      ctx.beginPath();
      ctx.arc(animal.x, animal.y, animal.size, 0, Math.PI*2, true); 
      ctx.closePath();
      ctx.fill();
animals = []
if Meteor.isClient
  Meteor.subscribe "animals"
  Meteor.startup -> 
#    start = ->
#      animals.push animal for animal in AnimalService.createAnimals()
#      moveAndDraw = ->
#        AnimalService.moveAnimals animals
#        Canvas.update animals
#
#      setInterval(moveAndDraw, 700);
#    start()
if Meteor.isClient
  # This code only runs on the client
  Template.zoo.helpers
    animals: "hello"
    animals2: -> Animals.find({})

  Template.zoo.onRendered ->
    console.log "zoorendered"
    animals = []
    console.log "size", Animals.find().count()
    titles = (animalData._id for animalData in Animals.find({}).fetch())
    console.log "title", titles
    cursor = Animals.find()
    console.log "foreach", cursor.forEach
    docs2 = cursor.forEach (doc) -> console.log doc._id
    console.log "docs",docs2
    docs = (console.log doc._id for doc in cursor)
    console.log "docs",docs
    makeAnimal = (animalData) ->
      newanimal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
      console.log "animal data", newanimal
      animals.push newanimal
    animalDataGroup = Animals.find().map(makeAnimal)
    console.log animalDataGroup
    console.log animal for animal in animalDataGroup
    
    for animalData in animalDataGroup
      console.log "animal data", animalData
      newanimal = new Animal animalData.hunger, animalData.metabolism, animalData.x0, animalData.y0, animalData.size, animalData._id
      console.log "animal data", newanimal
      animals.push newanimal
#    start = ->
#      animals.push animal for animal in AnimalService.createAnimals()
    moveAndDraw = ->
      AnimalService.moveAnimals animals
      Canvas.update animals

      setInterval(moveAndDraw, 700);
#    start()
    
  Template.zoo.events
#    'click #btn_game_start': ->
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
          found = false

          for animal in animals when not found
            distance = ((x - animal.x)**2 + (y - animal.y)**2)**(1/2)
            inrange = distance < animal.size
            if inrange
              animal.hunger = 0
              found = true
              console.log "fed first animal sitting on ", x, y

#        when 2  #middle button
        when 3
          console.log "newanimal", event.offsetX, event.offsetY
          newanimal = new Animal 0, 2, event.offsetX, event.offsetY
          animals.push newanimal
          mongoId = Meteor.call 'addAnimal', newanimal
          newanimal.id = mongoId
          
#        else # some other button
#          alert('You have a strange Mouse!')
#      keys = []
#      for a in ["client","offset","page"]
#        for b in ["X","Y"]
#          keys.push "#{a}#{b}"
#      console.log "evt", (("#{key} #{event[key]}") for key in keys)


Meteor.methods
#  getAnimalDataGroup: -> Animals.find({})
  addAnimal: (animal) -> 
    console.log "adding animal", animal
    mongoId = Animals.insert
      hunger: animal.hunger
      metabolism: animal.metabolism
      x0: animal.x0
      y0: animal.y0
      size: animal.size
      x: animal.x
      y: animal.y
      createdAt: new Date()
    mongoId
            
  deleteAnimal: (animal) -> Animals.remove(animal.id)

  feedAnimal: (animal) -> Animals.update(animal.id, { $set: { hunger: 0} })
    
if Meteor.isServer 
#  Meteor.publish "animals", -> Animals.find({})
  Meteor.startup ->
    
#    // code to run on server at startup

