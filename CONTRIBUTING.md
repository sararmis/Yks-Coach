# Katkı rehberi

Bu repo üç kişilik ekipte küçük, kolay incelenebilir değişikliklerle ilerler.
Doğrudan `main` veya `develop` üzerinde çalışmayın.

## İlk kurulum

1. Flutter stable kanalını ve projenin `pubspec.yaml` dosyasında istenen Dart
   sürümünü kurun.
2. `flutter pub get` çalıştırın.
3. VS Code kullanıyorsanız önerilen eklentileri yükleyin.
4. Backend için `backend/README.md` içindeki stack'e özel adımları izleyin.

## Günlük akış

1. Güncel `develop` dalından `feat/kisa-aciklama`, `fix/kisa-aciklama` veya
   `chore/kisa-aciklama` dalı açın.
2. Bir dalda tek bir işi tamamlayın. API sözleşmesini etkileyen kararları PR
   açmadan önce ekipte paylaşın.
3. Conventional Commits biçimini kullanın: `feat:`, `fix:`, `refactor:`,
   `test:`, `docs:` veya `chore:`. İsteğe bağlı kapsam örneği:
   `feat(backend): öğrenci oturumu ekle`.
4. Push öncesi `dart format .`, `flutter analyze --fatal-infos` ve
   `flutter test` çalıştırın. VS Code'da varsayılan test görevi üçünü birlikte
   çalıştırır.
5. `develop` hedefine PR açın ve en az bir ekip arkadaşının incelemesinden sonra
   squash merge yapın. Yayınlanabilir durumdaki `develop`, ayrı bir PR ile
   `main` dalına alınır.

## Çakışmaları azaltma

- İşe başlamadan önce issue oluşturup sorumlu kişiyi belirleyin.
- Büyük ortak dosyalara dokunacak işleri önceden haber verin.
- Dalınızı her gün `develop` ile güncelleyin; çatışmaları dal sahibi çözsün.
- Kilit dosyalarını (`pubspec.lock` ve backend eşdeğeri) bağımlılık değiştiğinde
  commit edin, elle düzenlemeyin.
- Gerçek anahtarları commit etmeyin. Yeni ortam değişkenini ilgili
  `.env.example` dosyasına güvenli örnek değer ve açıklamayla ekleyin.

## Tamamlanma ölçütü

Kod formatlı, analiz ve testler başarılı, gerekli test/doküman güncel ve CI
yeşil olduğunda iş tamamlanmış sayılır.

