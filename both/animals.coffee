
# size of random animal movement
movementSize = 2

class @Animal
  constructor: (@hunger = 0, @metabolism = 1, @x0 = 150, @y0 = 150, @size = 10, @_id = undefined) ->
    @x = @x0
    @y = @y0
  makeHungry: () ->
    @hunger += @metabolism unless @hunger >= 100
    Animals.update({_id: @id}, { $set: { hunger: @hunger} })

  move: ->
    randomMovement = -> Math.random() * (2 * movementSize) - movementSize
    @x = @x0 + randomMovement()
    @y = @y0 + randomMovement()
    Animals.update({_id: @id}, { $set: { x: @x, y: @y} })
    
  toObj: ->
    hunger: @hunger
    metabolism: @metabolism
    x0: @x0
    y0: @y0
    size: @size
    x: @x
    y: @y

@locateAnimal = (x, y, action) ->
  found = false
  Animals.find().map (animalData) ->
    unless found
      distance = ((x - animalData.x)**2 + (y - animalData.y)**2)**(1/2)
      inrange = distance < animalData.size
      if inrange
        found = true
        action(animalData)