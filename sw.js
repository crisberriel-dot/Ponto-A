const CACHE_NAME = 'ponto-a-v1';
const SHELL_FILES = ['./index.html', './manifest.json', './icon-192.png', './icon-512.png'];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(SHELL_FILES))
  );
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// App shell offline; chamadas ao Supabase sempre vão direto pra rede (dados precisam de internet)
self.addEventListener('fetch', (event) => {
  const url = event.request.url;
  if (url.includes('supabase.co')) return; // não cachear dados
  event.respondWith(
    caches.match(event.request).then((cached) => cached || fetch(event.request))
  );
});
