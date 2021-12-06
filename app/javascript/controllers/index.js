// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import registerServiceWorker from '../registerServiceWorker';

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

registerServiceWorker('BIKLC0pbcadknh0ebmsH9KaypTwkuZw053ugxqXQ7XRA_ap2rQAUTDtUb4y5WcdKWpMZV2usVhn5TGmAwhf8dIc');

if ('BroadcastChannel' in window) {
  console.log("if this is even runnin")
  const channel = new BroadcastChannel('sw-messages');
  channel.addEventListener('message', event => {
    console.log(`Received event from service worker: ${event.data.type}`);
  });
}

console.log("hi")

window.localStorage.setItem('pwa-demo:session', JSON.stringify(window.routeParamsFromRails));
