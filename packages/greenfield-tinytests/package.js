Package.describe({
  name: 'greenfield-tinytests',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'unit tests for the greenfield game',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.addFiles('greenfield-tinytests.js');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use(["spacebars", "tinytest", "test-helpers"]);
  api.use("templating", "client");
  api.use('greenfield-tinytests');
//  api.addFiles('test-stubs.js', 'client');
  api.addFiles('../../both/animals.coffee', 'client');
  api.addFiles('../../both/game.coffee', 'client');
  api.addFiles('../../client/events.coffee', 'client');
  api.addFiles('../../client/greenfield.coffee', 'client');
  api.addFiles('../../client/greenfield.jade', 'client');
  api.addFiles('greenfield-tinytests-tests.js', 'client');
});
