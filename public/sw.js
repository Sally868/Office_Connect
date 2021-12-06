importScripts("/packs/precache-manifest.f7d1f2b7116c011e7927dc562c7395db.js", "https://storage.googleapis.com/workbox-cdn/releases/4.3.1/workbox-sw.js");

// Base service worker extended by workbox in webpack

if (typeof(workbox) === 'undefined') {
  console.log(`Boo! Workbox didn't load 😬`);
} else {
  console.log(`Yay! Workbox is loaded 🎉`);

  self.addEventListener('push', function (event) {
    let json = event.data.json();
    let icon = 'icon-128.png';

    if (['Added', 'Completed'].includes(json.action)) {
      event.waitUntil(
        self.registration.showNotification(`${json.action} ${json.title}`, {
          body: json.user,
          icon: icon
        })
      );
    }

    if ('BroadcastChannel' in self) {
      const channel = new BroadcastChannel('sw-messages');
      channel.postMessage({ type: 'TodoChange' });
    }
  });

  self.addEventListener('pushsubscriptionchange', event => {
    event.waitUntil(
      self.registration.pushManager
        .subscribe(event.oldSubscription.options)
        .then(subscription => {
          if ('BroadcastChannel' in self) {
            const channel = new BroadcastChannel('sw-messages');
            channel.postMessage({ type: 'PushSubscriptionChange', subscription });
          }
        })
    );
  });

  workbox.routing.registerRoute(
    new RegExp('.*'),
    new workbox.strategies.NetworkFirst({
      cacheName: 'default'
    })
  );

  workbox.precaching.precacheAndRoute(self.__precacheManifest);
}

