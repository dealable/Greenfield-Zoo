// Write your tests here!
// Here is an example.
Tinytest.add('example', function (test) {
  test.equal(true, true);
});

Tinytest.add('game should not start', function (test) {
  test.equal(Template.zoo, false);
});

//Tinytest.add('start button creates game info', function (test) {
//
//  var someLocalCollectionCursor = {};
//  Games.find = function (selector, options) {
//      test.equal(options.sort.score, -1);
//      test.equal(options.sort.name, 1);
//      // expect(options.sort.score).toBe(-1);
//      // expect(options.sort.name).toBe(1);
//      return someLocalCollectionCursor;
//  };
//
//  test.equal(Template.zoo.running, someLocalCollectionCursor);
//  //expect(Template.leaderboard.players()).toBe(someLocalCollectionCursor);
//});
