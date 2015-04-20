# Set up a collection to contain information about each animal.

Animals = new Meteor.Collection 'animals'

# size of random animal movement
movementSize = 2

# maximum color strength
colorMax = 217

class Animal
  constructor: (@hunger = 0, @x0 = 150, @y0 = 150) ->
  getHungry: @hunger += 10 unless @hunger <= 0
  move: ->
    randomMovement = -> Math.random() * (2 * movementSize) - movementSize
    @x1 = @x0 + randomMovement()
    @y1 = @y0 + randomMovement()

#    Hungryanimal extends Animal
#AnimalService =

  
if Meteor.isClient
  Meteor.startup ->
    canvas = document.getElementById("canvas");
    ctx = canvas.getContext("2d");
    radius = 10;

    animal1 = new Animal
    animal2 = new Animal 0, 50, 50
    animal3 = new Animal 100, 50, 100
      
    updateCanvas = (animals) ->
      ctx.clearRect(0,0,canvas.width, canvas.height);
      
      for animal in animals
        getColor = ->
          red = animal.hunger/100 * colorMax # hunger percentage x maximum color strength
          blue = (1 - animal.hunger/100) * colorMax
          color = "rgb(#{red}, 0, #{blue})"
          console.log 'color', color
          color
        ctx.fillStyle = getColor()
        ctx.beginPath();
        ctx.arc(animal.x1, animal.y1, radius, 0, Math.PI*2, true); 
        ctx.closePath();
        ctx.fill();
      
    moveAndDraw = ->
      animal1.move()
      animal2.move()
      animal3.move()
      animals = [animal1, animal2, animal3]
      updateCanvas(animals)
      
    init = -> setInterval(moveAndDraw, 700);
    init()
    
if Meteor.isServer 
  Meteor.startup ->
#    // code to run on server at startup

