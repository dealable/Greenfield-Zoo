# Set up a collection to contain information about each animal.

Animals = new Meteor.Collection 'animals'

# size of random animal movement
movementSize = 2

# maximum color strength
colorMax = 217

#    Hungryanimal extends Animal
class Animal
  constructor: (@hunger = 0, @metabolism = 1, @x0 = 150, @y0 = 150, @size = 10) ->
  getHungry: ->
    @hunger += @metabolism unless @hunger >= 100
    #console.log "hunger", @hunger
  move: ->
    randomMovement = -> Math.random() * (2 * movementSize) - movementSize
    @x = @x0 + randomMovement()
    @y = @y0 + randomMovement()

AnimalService =
  createAnimals: ->
    animal1 = new Animal
    animal2 = new Animal 0, 2, 50, 50
    animal3 = new Animal 100, 10, 50, 100
    animals = [animal1, animal2, animal3]
    animals
  
  moveAnimals: (animals) ->
    for animal in animals
      animal.getHungry()
      animal.move()

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
  Meteor.startup -> 
    start = ->
      animals.push animal for animal in AnimalService.createAnimals()
      moveAndDraw = ->
        AnimalService.moveAnimals animals
        Canvas.update animals

      setInterval(moveAndDraw, 700);
    start()
      
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
#        else # some other button
#          alert('You have a strange Mouse!')
#      keys = []
#      for a in ["client","offset","page"]
#        for b in ["X","Y"]
#          keys.push "#{a}#{b}"
#      console.log "evt", (("#{key} #{event[key]}") for key in keys)

    
if Meteor.isServer 
  Meteor.startup ->
#    // code to run on server at startup

