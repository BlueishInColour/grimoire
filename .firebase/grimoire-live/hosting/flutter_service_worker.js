'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"splash/img/light-4x.png": "24426fa4754dd47b5ef0aeb9f554193f",
"splash/img/light-3x.png": "bd365097b3038df1c1bdb1e1fdd922b1",
"splash/img/dark-2x.png": "c8bfce164e95ebb4c06bcae803cbbc66",
"splash/img/dark-3x.png": "bd365097b3038df1c1bdb1e1fdd922b1",
"splash/img/dark-4x.png": "24426fa4754dd47b5ef0aeb9f554193f",
"splash/img/light-2x.png": "c8bfce164e95ebb4c06bcae803cbbc66",
"splash/img/dark-1x.png": "55db30b121b5fac14f77f0b71d077770",
"splash/img/light-1x.png": "55db30b121b5fac14f77f0b71d077770",
"favicon.png": "2fdffc4da06688585afc9e89a3aa4f33",
"version.json": "6a65c3ac8d7b9318fab998cb34bc3039",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"flutter_bootstrap.js": "3e694dc01acfd5fdc4584e9a2d49e38c",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"manifest.json": "e2cd8bdda3086a2f4789fc3f3cf05676",
"main.dart.js": "2eee7ce5a19c43b6a26c016fe9b9ce03",
"assets/fonts/MaterialIcons-Regular.otf": "0f8b05fa1e72e10bfba741f484164869",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0e33f849ad9a42bb426decc1d76db4e0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "53754c92f78fd4fcedad5a47e1a75cff",
"assets/packages/language_picker/assets/fonts/Roboto/Roboto-Regular.ttf": "8a36205bd9b83e03af0591a004bc97f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/strikethrough.png": "cb39da11cd936bd01d1c5a911e429799",
"assets/packages/syncfusion_flutter_pdfviewer/assets/highlight.png": "7384946432b51b56b0990dca1a735169",
"assets/packages/syncfusion_flutter_pdfviewer/assets/underline.png": "c94a4441e753e4744e2857f0c4359bf0",
"assets/packages/syncfusion_flutter_pdfviewer/assets/squiggly.png": "c9602bfd4aa99590ca66ce212099885f",
"assets/packages/file_previewer/assets/img.png": "52449d8a3b4f1d74f88d9858fa85795e",
"assets/packages/enefty_icons/lib/assets/fonts/icons/EneftyIcons.ttf": "77eb61472ab389c77cf6c06099b96753",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/AssetManifest.bin.json": "7a5095c7e4cd604173807688839088d9",
"assets/NOTICES": "cd685c55de293d4dd097ea9776d2a5a6",
"assets/AssetManifest.bin": "52aa9c81a689756292729ef959e0f384",
"assets/assets/image6.svg": "f7a7d4ccfe76af92e77c9924137c8925",
"assets/assets/wip.png": "e6278502d6a0d4df16fe9e32124afe92",
"assets/assets/book_cover.png": "d3b18830527a42b7ac89d2827ee90a13",
"assets/assets/empty.png": "0ad4f3494329211911f340f4409cb5a2",
"assets/assets/splash.png": "d186c120955dc4cb0b42d31a50cd4c39",
"assets/assets/image4.svg": "d10259f1ef1c644b6ec247291aa28ef1",
"assets/assets/image7.svg": "8b3bdb9002ea2c9f2417fea03435deeb",
"assets/assets/no_internet.png": "54c97f2184759d0d4400289a7740dc74",
"assets/assets/image8.svg": "677a1da6dba2836889caea9238ead18a",
"assets/assets/image2.svg": "449b83c1cffae24e2b5ae704d36be8b1",
"assets/assets/google2.png": "dde222171dc8dbe8defc38f336dca35b",
"assets/assets/image1.svg": "8584233a56f7fa01aae90134960a132b",
"assets/assets/image3.svg": "996db64167ccd306bcbba3f1c597b653",
"assets/assets/image5.svg": "74c6e91fefb696004f3c2a59add4b5cb",
"assets/assets/icon.png": "e5900f387f9d1f9c0299d6b207693315",
"assets/FontManifest.json": "23db1a58a03fe2df26011abf1c151b82",
"assets/AssetManifest.json": "ed7894ec33a3ed5d93b6514f51180cc3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"icons/Icon-maskable-192.png": "14ce0252d3cf87c0018747381ef053ba",
"icons/Icon-maskable-512.png": "28304e5dc007c1f1ad1899f3d47a9754",
"icons/Icon-512.png": "28304e5dc007c1f1ad1899f3d47a9754",
"icons/Icon-192.png": "14ce0252d3cf87c0018747381ef053ba",
"index.html": "fa1e3dfadee0a99f8f31bbe63a7d2661",
"/": "fa1e3dfadee0a99f8f31bbe63a7d2661",
".well-known/assetlinks.json": "b1fd2e57635f403e2e8eb1ced4069928"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
