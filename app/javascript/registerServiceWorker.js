async function subscribeForWebPush(data = {}) {

  const pwaDemoSession = () =>
    JSON.parse(localStorage.getItem('pwa-demo:session'));

  const {
    user_email, user_token
  } = pwaDemoSession();

  // Default options are marked with *
  const response = await fetch('/api/webpush/subscribe', {
    method: 'POST', // *GET, POST, PUT, DELETE, etc.
    body: JSON.stringify(data), // body data type must match "Content-Type" header
    headers: {
      'Content-Type': "application/json",
      'X-User-Email': user_email,
      'X-User-Token': user_token
    }
  });
  return response.json(); // parses JSON response into native JavaScript objects
}

function urlBase64ToUint8Array(base64String) {
  const padding = '='.repeat((4 - (base64String.length % 4)) % 4);
  const base64 = (base64String + padding)
    .replace(/\-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

function setupPushManager(registration, vapidPublicKey) {
  const convertedVapidKey = urlBase64ToUint8Array(vapidPublicKey);

  return registration.pushManager.getSubscription().then(subscription => {
    if (subscription) {
      return subscription;
    }

    return registration.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: convertedVapidKey
    });
  });
}

export default function registerServiceWorker(vapidPublicKey) {
  // if ('serviceWorker' in navigator && process.env.NODE_ENV === 'production') {
  if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      navigator.serviceWorker
        .register('/sw.js')
        .then(registration => {
          console.log('SW registered: ', registration);

          return setupPushManager(registration, vapidPublicKey)
            .then(subscription => {
              console.log('Push manager subscribed: ', subscription);

              return subscribeForWebPush({ subscription: subscription });
            })
            .catch(error => {
              console.log('Push manager subscription failed: ', error);
            });
        })
        .catch(registrationError => {
          console.log('SW registration failed: ', registrationError);
        });
    });
  }

  // check if the browser supports notifications
  if (!('Notification' in window)) {
    console.error('This browser does not support desktop notification');
  }
  // check whether notification permissions have already been granted
  else if (Notification.permission === 'granted') {
    console.log('Permission to receive notifications has been granted');
  }
  // Otherwise, we need to ask the user for permission
  else if (Notification.permission !== 'denied') {
    Notification.requestPermission(function (permission) {
      // If the user accepts, let's create a notification
      if (permission === 'granted') {
        console.log('Permission to receive notifications has been granted');
      }
    });
  }

  if ('BroadcastChannel' in window) {
    const channel = new BroadcastChannel('sw-messages');
    channel.addEventListener('message', event => {
      if ('PushSubscriptionChange' === event.data.type) {
        console.log(`Received subcription change event`);
        return subscribeForWebPush({
          subscription: event.data.subscription
        });
      }
    });
  }
}
