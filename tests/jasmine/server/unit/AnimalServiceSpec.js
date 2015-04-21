Jasmine.onTest(function () {
  describe("Animal", function() {
      it("once hunger is above 100, makeHungry() doesn't do anything", function() {
          initialhunger = 150;
          var newAnimal = new Animal initialhunger
          newAnimal.makeHungry();
          expect(newAnimal.hunger).toEqual(initialhunger);
    });
  });

  describe("Animal", function() {
      it("animal move() should be within the specified movementSize", function() {
          movementSize = 2;
          initialx = 50;
          initialy = 50;
          var newAnimal = new Animal initialhunger
          newAnimal.move();
          expect((newAnimal.x - initialx)**2).toBeLessThan(movementSize**2);
          expect((newAnimal.y - initialy)**2).toBeLessThan(movementSize**2);
    });
  });
}