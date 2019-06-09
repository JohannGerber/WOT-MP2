# Example code from Chapter 7 of the WoT book

This repository is a fork of the [official GitHub repository](https://github.com/webofthings/wot-book)
with a few changes to make the code work with node.js version 10 and hopefully later versions.

## Changes compared to the original code

* Removed use of `Object.observe()` in `plugins/internal/ledsPlugin.js` by making use of the
  `object-observer` node.js module.
* Updated dependencies in `package.json` to make the code buildable.
* Removed all CoAP code as it made the application crash.
* Included a `Dockerfile` taken from the starting template with port changed to 8484.

Note that the `servers/websockets.js` file still includes a call to `Object.observe()`. This function
is no longer available in node.js and fixing this code is left as an exercise for those who want to
use websockets. See `plugins/internal/ledsPlugin.js` to get an idea how to fix it.
