Meteor.subscribe("animals");
// counter starts at 0
Session.setDefault('counter', 0);

Template.hello.helpers({
  counter: function () {
    return Session.get('counter');
  }
});

Template.hello.events({
  'click button': function () {
    // increment the counter when button is clicked
    Session.set('counter', Session.get('counter') + 1);
  }
});

Template.zoo2.helpers({
animals: function() {
  return Animals.find({});
}
});

Template.zoo2.onRendered(function() {
var animalData, animals, count, cursor, docs2, titles, topPosts;
console.log("zoo2rendered");
animals = [];
console.log("size", Animals.find({}).count());
titles = (function() {
  var _i, _len, _ref, _results;
  _ref = Animals.find({}).fetch();
  _results = [];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    animalData = _ref[_i];
    _results.push(animalData._id);
  }
  return _results;
})();
console.log("title", titles);
cursor = Animals.find();

docs2 = cursor.forEach(function(doc) {
  return console.log(doc._id);
});
console.log("docs2", docs2);
cursor.forEach(function(doc) {
  return console.log("tryit", doc._id);
});
topPosts = Animals.find({}, {
  sort: {
    score: -1
  },
  limit: 5
});
count = 0;
return topPosts.forEach(function(post) {
  console.log('Title of post ' + count + ': ' + post._id);
  return count += 1;
});
});
