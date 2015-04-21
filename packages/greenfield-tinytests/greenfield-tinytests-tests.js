Tinytest.add('animals are inside the canvas', function (test) {
  width = 500;
  height = 300;
  // not sure how to access collection from tiny test
  cursor = Animals.find();
  cursor.map( function (animalData) {
    console.log("animalData",animalData);
    test.isTrue(animalData.x >= 0);
    test.isTrue(animalData.x <= width);
    test.isTrue(animalData.y >= 0);
    test.isTrue(animalData.y <= height);
  })
});

// false test to check that tests properly fail
Tinytest.add('animals are outside the canvas', function (test) {
  cursor = Animals.find();
  cursor.map( function (animalData) {
    test.isFalse(animalData.x >= 0);
    test.isFalse(animalData.x <= width);
    test.isFalse(animalData.y >= 0);
    test.isFalse(animalData.y <= height);
  })
});


Tinytest.add('Animal.makeHungry', function (test) {
//animal1 = new Animal
//animal1.makeHungry()
//cursor.map( function (animalData) {
//  test.isTrue(animal1.hunger <= 100);
//})
});

//
//Tinytest.add('Template.leaderboard.players()', function (test) {
//
//var someLocalCollectionCursor = {};
//Players.find = function (selector, options) {
//    test.equal(options.sort.score, -1);
//    test.equal(options.sort.name, 1);
//    // expect(options.sort.score).toBe(-1);
//    // expect(options.sort.name).toBe(1);
//    return someLocalCollectionCursor;
//};
//
//test.equal(Template.leaderboard.players(), someLocalCollectionCursor);
////expect(Template.leaderboard.players()).toBe(someLocalCollectionCursor);
//});