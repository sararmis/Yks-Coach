# YKS Coach

YKS öğrencilerinin deneme sonuçlarını, konu eksiklerini ve çalışma süreçlerini
takip edebildiği; öğretmenlerin öğrencileri yönetebildiği AI destekli eğitim
platformu.

## Proje yapısı

- `lib/`: Flutter mobil/web uygulaması
- `backend/`: FastAPI sunucusu ve HTTP API
- `ai/`: Python algoritmaları, formüller ve yapay zeka promptları

Uygulama akışı:

`Flutter -> POST /api/v1/study-plan -> Backend -> ai.generate_study_plan()`

## Yerel çalıştırma

Backend'i depo ana dizininden başlatın:

```powershell
python -m venv backend/.venv
backend/.venv/Scripts/pip install -r backend/requirements.txt
backend/.venv/Scripts/python -m uvicorn backend.main:app --reload
```

Alternatif olarak Docker ile:

```powershell
docker compose up --build
```

Ardından Flutter uygulamasını ayrı bir terminalde çalıştırın:

```powershell
flutter pub get
flutter run
```

Android emülatörü varsayılan olarak `http://10.0.2.2:8000`, diğer platformlar
`http://localhost:8000` adresini kullanır. Fiziksel cihazda bilgisayarın yerel IP
adresini verin:

```powershell
flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8000
```

API hazır olduğunda `http://localhost:8000/docs` üzerinden denenebilir.

## Testler

```powershell
python -m unittest discover -s ai/tests
backend/.venv/Scripts/pip install -r backend/requirements-dev.txt
backend/.venv/Scripts/python -m pytest backend/tests
flutter test
```

## Ekip çalışma düzeni

Her geliştirici kendi feature branch'inde çalışır ve doğrudan `main` branch'ine
commit atmaz. Güncel `main` branch'i feature branch'ine düzenli olarak alınır;
tamamlanan değişiklikler GitHub Pull Request ile gözden geçirilip birleştirilir.

Klasör sorumlulukları ayrıdır; ortak API sözleşmesi değiştirilecekse Flutter,
backend ve AI tarafındaki testler aynı Pull Request içinde güncellenir. API
anahtarları `.env` dosyasında tutulur ve Git'e eklenmez.
