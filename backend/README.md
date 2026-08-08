# Backend

Backend ekibinin çalışma alanıdır. Teknoloji yığını seçildiğinde kurulum,
çalıştırma, test, migration ve API dokümantasyonu komutları burada tutulmalıdır.

## Ekip sözleşmesi

- Kaynak kodu, testler ve migration dosyaları `backend/` altında kalır.
- Yerel ayarlar `.env` dosyasında; paylaşılabilir anahtarlar `.env.example`
  dosyasında tutulur. Gerçek gizli bilgiler repoya eklenmez.
- Mobil istemciyi etkileyen endpoint değişiklikleri aynı PR'da API sözleşmesine
  yansıtılır.
- Her özellik için en azından başarılı akış ve temel hata akışı test edilir.
- Başlatma ve kalite kontrolü tek komutla yapılabilir hale geldiğinde komutlar bu
  dosyaya eklenir.

