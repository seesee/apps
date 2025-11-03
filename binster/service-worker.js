self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open("bin-generator-v1").then((cache) => {
      return cache.addAll(["./", "index.html", "manifest.json"]);
    })
  );
});

self.addEventListener("fetch", (e) => {
  e.respondWith(caches.match(e.request).then((r) => r || fetch(e.request)));
});
