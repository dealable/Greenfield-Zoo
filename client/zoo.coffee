# maximum color strength
colorMax = 217

@Zoo = 
  initialize: ->
    canvas = document.getElementById("canvas");
    ctx = canvas.getContext("2d");
    ctx.clearRect(0,0,canvas.width, canvas.height);
    ctx.fillStyle = 'white';
    ctx.font = 'italic bold 30px sans-serif';
    ctx.textBaseline = 'bottom';
    ctx.fillText('Loading', 50, 100);

  refresh: ->
#    console.log "refresh"
    canvas = document.getElementById("canvas");
    ctx = canvas.getContext("2d");
    ctx.clearRect(0,0,canvas.width, canvas.height);

    cursor = Animals.find()
    cursor.map (animalData) ->
      
#    animals = 
#    Meteor.call "getAnimals", (err, animalDataBatch) ->
#      for animalData in animalDataBatch
        #console.log "drawing", animalData
        getColor = ->
          # hunger percentage x maximum color strength
          red = Math.round(animalData.hunger/100 * colorMax)
          blue = Math.round((1 - animalData.hunger/100) * colorMax)
          color = "rgb(#{red}, 0, #{blue})"
          #console.log "color", color
          color
        ctx.fillStyle = getColor()
        ctx.beginPath();
        ctx.arc(animalData.x, animalData.y, animalData.size, 0, Math.PI*2, true); 
        ctx.closePath();
        ctx.fill();