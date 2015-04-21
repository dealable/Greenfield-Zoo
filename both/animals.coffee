
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
#    createdAt: new Date()  need to add below

@locateAnimal = (x, y, action) ->
  console.log "locate", x, y
  found = false
  Animals.find().map (animalData) ->
    unless found
      distance = ((x - animalData.x)**2 + (y - animalData.y)**2)**(1/2)
      inrange = distance < animalData.size
      if inrange
        console.log "found", animalData
        found = true
        action(animalData)

Meteor.methods
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

  deleteAnimal: (x,y) -> 
    animal = locateAnimal x, y
    if animal
      Animals.remove(animal._id)

#  feedAnimal: (x,y) -> 
#    animal = locateAnimal x, y
#    if animal
#      Animals.update(animal._id, { $set: { hunger: 0} })

#  makeHungry: (animal) ->
#    Animals.update(animal._id, { $set: { hunger: animal.hunger} })
#
#  move: (animal) ->
#    Animals.update(animal._id, { $set: { x: animal.x, y: animal.y} })

#  getAnimals: -> Animals.find().fetch()