'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4242cddda5fb3ebaf3ae7e4a0df3493d",
"assets/AssetManifest.bin.json": "2a2a22e798cdd9253241071fc8364c8e",
"assets/AssetManifest.json": "434cc1d25a8c09b0ca68066f46da636c",
"assets/assets/animations/happy_chum.riv": "f2e327a454f3771f2173b6df40740434",
"assets/assets/animations/herochums.riv": "7c741a6487a9a1a99b70f5ac2ef9b8cc",
"assets/assets/animations/rewards_chum.riv": "124393ad761b5a351b5d2b79dcfe903a",
"assets/assets/animations/sad_square_idle.riv": "a5a1b64a0e4a621361de4016cf84181e",
"assets/assets/animations/thinking_chum.riv": "c48e636bbf0161ec1df64ef9e2c3cf4b",
"assets/assets/fonts/emoji-font.ttf": "37e77bbb309de679a835cf8759b84cfc",
"assets/assets/images/avatars/a1.png": "0b56e5feb2929eedbf3f870dd2166668",
"assets/assets/images/avatars/b1.png": "c51e401193eccb61f985f3ad5b414b3f",
"assets/assets/images/avatars/c1.png": "59eaade0df66d0dc004db250ca47e6ad",
"assets/assets/images/custom_mark.png": "3bd4bcdfb79eda9f354506aa99c010eb",
"assets/assets/images/g426-4.png": "72f39d7fa167c964cdfd2067bc81a006",
"assets/assets/images/gem.png": "4fedccd8dde4b59546319d646884558e",
"assets/assets/images/leaf_mark.png": "f1486eeda3e8bff08393745e95ec20ed",
"assets/assets/images/login_motto.png": "7162c662772f545757c3bad19c1d8e3b",
"assets/assets/images/logo.png": "5a0e080773032309e4d17524af61ec36",
"assets/assets/images/logo_text.png": "acb57e433b8faf0378ddd0652760f3c0",
"assets/assets/images/rubies.png": "b8dbd8e20a2696b4569b737d71ef0bbc",
"assets/assets/images/trash-2-cans.jpg": "52747002d3ce86b2de4bd7d8b3b644bf",
"assets/assets/images/watches.png": "35443d552a3a49fb85c0ccf0ebf02f35",
"assets/assets/map_styles/style_dark.json": "f1b13f8d4dc15f22f7a0c4590d7ab72d",
"assets/assets/map_styles/style_full_standard.json": "7b674fb4aacfcfc1e4eefcc7f53a6f83",
"assets/assets/map_styles/style_silver.json": "d9b65c830e1cd0f4530faa21c42b8c6f",
"assets/FontManifest.json": "74597e3f7dc2229eaca6b1bc1261d510",
"assets/fonts/MaterialIcons-Regular.otf": "e24aadc304ecc079d05deec453981683",
"assets/NOTICES": "8f887bf184070d37e23c3360cd276ec5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "d84969611ed9a536b552ac26f1c2d5db",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "c68ac842c250219a248e224b6bbd7fa8",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "8bd724b7a3630158b08574e2b7d4fa09",
"icons/Icon-512.png": "134cab0d1658e1c9ca51829182d32b28",
"icons/Icon-maskable-192.png": "8bd724b7a3630158b08574e2b7d4fa09",
"icons/Icon-maskable-512.png": "134cab0d1658e1c9ca51829182d32b28",
"index.html": "1bead926eaca91294ec4643c2100a9cd",
"/": "1bead926eaca91294ec4643c2100a9cd",
"main.dart.js": "6df0d093b72c44f78f3270e12d9c1e91",
"manifest.json": "230b469f0584ecb05fe897ea9839cdbd",
"version.json": "f12a83bce4b87424a785eef895d2099a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
