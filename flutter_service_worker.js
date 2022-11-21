'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "splash/style.css": "83ccce656629db1db8650208a20d8051",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"version.json": "009c9e65172e010890f7f65fde438006",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"favicon.png": "f17cb85027aeb75e9a4fc521cb79e477",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"index.html": "3cb0b8fbed7fe6a819a07d8b168e76a5",
"/": "3cb0b8fbed7fe6a819a07d8b168e76a5",
"jsons/lines.json": "6e43697fc619cfd8b6e98ff643d98594",
"jsons/path.json": "cabb4c2d5cbf7d451218bda0ee748c4e",
"jsons/spinning.json": "e8d8c3311edd1111c9482ab20eb49ed9",
"manifest.json": "c98ef175036c1e91763ebc1da3118ce1",
"main.dart.js": "d478776b4003698165487f1a7144088a",
"assets/AssetManifest.json": "863bafedad0460c2c0e9231a4b40da3f",
"assets/web/jsons/lines.json": "6e43697fc619cfd8b6e98ff643d98594",
"assets/web/jsons/path.json": "cabb4c2d5cbf7d451218bda0ee748c4e",
"assets/web/jsons/spinning.json": "e8d8c3311edd1111c9482ab20eb49ed9",
"assets/web/icons/facebook.png": "fbe6c0d34f7953e039b2a8552fa75789",
"assets/web/icons/github.svg": "5cfd7ab6e5646e21528e7329deba1ea7",
"assets/web/icons/facebook.svg": "a937dc2aa703eb4ab7ef54c334a0521d",
"assets/web/icons/whatsapp.svg": "0a4008576a2d83d5b74b6c46bc848d93",
"assets/web/icons/education.svg": "6b0bc33fab60b4b57530b63c4d85d9b9",
"assets/web/icons/linkedin.png": "eafcee4812b3035ac6845b9e04bf4233",
"assets/web/icons/linkedin.svg": "94025d95f969a661b109aab906d63047",
"assets/web/icons/play.png": "09f14e2b4a0a69d5d979b653c7c16982",
"assets/web/icons/instagram.png": "f8dc87de72a7e46a4018cf936f3d22f4",
"assets/web/icons/whatsapp.png": "2a1890951837c86e126d01c689f8860a",
"assets/web/icons/telegram.png": "ff17ff9c3f1885943772e4bb3527b07c",
"assets/web/icons/telegram.svg": "c55528d4703de7ee1676b1d86e92af68",
"assets/web/icons/github.png": "a48fcf3c5c10fbb8fe9e18808947524c",
"assets/web/icons/pause.png": "57f0c2deb2b26d53e0328b3751cada55",
"assets/web/icons/education.png": "f12240a98fa50f0da699bc059218e91a",
"assets/web/icons/instagram.svg": "8037d8b9b321ed0562dd7b2815913436",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "915aaabfe86531be908a4e6280d8db46",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/icons/github.svg": "5cfd7ab6e5646e21528e7329deba1ea7",
"assets/assets/icons/facebook.svg": "a937dc2aa703eb4ab7ef54c334a0521d",
"assets/assets/icons/whatsapp.svg": "0a4008576a2d83d5b74b6c46bc848d93",
"assets/assets/icons/education.svg": "6b0bc33fab60b4b57530b63c4d85d9b9",
"assets/assets/icons/linkedin.svg": "94025d95f969a661b109aab906d63047",
"assets/assets/icons/telegram.svg": "c55528d4703de7ee1676b1d86e92af68",
"assets/assets/icons/instagram.svg": "8037d8b9b321ed0562dd7b2815913436",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "1ed03b0025463b56a87ebe9d27588c8a",
"icons/facebook.png": "fbe6c0d34f7953e039b2a8552fa75789",
"icons/github.svg": "5cfd7ab6e5646e21528e7329deba1ea7",
"icons/facebook.svg": "a937dc2aa703eb4ab7ef54c334a0521d",
"icons/whatsapp.svg": "0a4008576a2d83d5b74b6c46bc848d93",
"icons/education.svg": "6b0bc33fab60b4b57530b63c4d85d9b9",
"icons/linkedin.png": "eafcee4812b3035ac6845b9e04bf4233",
"icons/linkedin.svg": "94025d95f969a661b109aab906d63047",
"icons/play.png": "09f14e2b4a0a69d5d979b653c7c16982",
"icons/instagram.png": "f8dc87de72a7e46a4018cf936f3d22f4",
"icons/whatsapp.png": "2a1890951837c86e126d01c689f8860a",
"icons/telegram.png": "ff17ff9c3f1885943772e4bb3527b07c",
"icons/telegram.svg": "c55528d4703de7ee1676b1d86e92af68",
"icons/github.png": "a48fcf3c5c10fbb8fe9e18808947524c",
"icons/pause.png": "57f0c2deb2b26d53e0328b3751cada55",
"icons/education.png": "f12240a98fa50f0da699bc059218e91a",
"icons/instagram.svg": "8037d8b9b321ed0562dd7b2815913436"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
