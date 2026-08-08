# YKS-Coach

YKS öğrencilerinin deneme sonuçlarını, konu eksiklerini ve çalışma süreçlerini
takip edebildiği; öğretmenlerin öğrencileri yönetebildiği, ödev verebildiği ve
iletişim kurabildiği yapay zekâ destekli eğitim platformu.

## Proje yapısı

- `lib/`: Flutter uygulaması
- `test/`: Flutter testleri
- `backend/`: API ve sunucu tarafı
- `.github/`: PR kontrolleri ve ekip şablonları

## Başlangıç

```sh
flutter pub get
flutter run
```

Değişiklik göndermeden önce:

```sh
dart format .
flutter analyze --fatal-infos
flutter test
```

Branch, commit ve PR akışı için [CONTRIBUTING.md](CONTRIBUTING.md) dosyasına
bakın. Backend kurulumu seçilen teknolojiyle birlikte
[backend/README.md](backend/README.md) içinde güncellenecektir.
