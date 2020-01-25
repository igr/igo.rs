const { Spig } = require('spignite');

Spig.hello();

Spig
  .on('/**/*.{md,njk}')

  ._("INIT")
  .pageCommon()
  .tags()

  ._("RENDER")
  .render()
  .applyTemplate()
  .htmlMinify()
;

Spig
  .on('/**/*.{png,jpg,gif}')

  ._("INIT")
  .assetCommon()

  ._("IMG")
  .imageMinify()
;

Spig.run();
