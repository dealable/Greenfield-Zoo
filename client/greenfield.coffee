animals = []
refresh_speed = 500

Meteor.subscribe "animals"

Template.zoo.onRendered ->
  refresh_interval = Session.get "refresh_interval"
  unless refresh_interval is undefined
    Meteor.clearInterval refresh_interval
  refresh_interval = Meteor.setInterval Zoo.refresh, refresh_speed
  Session.set "refresh_interval", refresh_interval