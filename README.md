# work_order_app

Mobile work order app built with Flutter. It provides a structured architecture, offline-friendly data access, maps/location support, image capture, and integration with a REST backend.

## Quick start

1. Install Flutter and set up an emulator or device.
2. Install dependencies:
   - `flutter pub get`
3. Create a `.env` file at the project root:
   ```env
   ENVIRONMENT=development
   BACKEND_DOMAIN=https://your-backend.example.com
   # Optional; falls back to BACKEND_DOMAIN/storage/app/public/
   BACKEND_URL=https://your-backend.example.com/storage/app/public/
   ```
4. (Optional) Generate Retrofit code if you modify API interfaces:
   - `dart run build_runner build --delete-conflicting-outputs`
5. Run the app:
   - `flutter run`

## Tech stack

- State & DI: `flutter_bloc`, `get_it`
- Networking: `dio`, `retrofit`
- Persistence: `sqflite`
- Env/config: `flutter_dotenv`
- Maps & location: `google_maps_flutter`, `geolocator`, `location`
- Media: `image_picker`
- UI: `another_flushbar`, `flutter_slidable`, `iconsax_flutter`, `hugeicons`

## Configuration

- App config is loaded from `.env` via `flutter_dotenv`.
  - `ENVIRONMENT`: environment name (e.g., development, staging, production)
  - `BACKEND_DOMAIN`: base domain for API, e.g., `https://api.example.com`
  - `BACKEND_URL` (optional): base storage URL. If omitted, defaults to `${BACKEND_DOMAIN}/storage/app/public/`.
- Networking is centralized in `RemoteDatasource` (Dio) with request/response interceptors and bearer token header support.

## Project structure (high-level)

- `lib/config/`: static app configuration, theme, assets, dynamic form settings
- `lib/core/`: common widgets, utilities, data state abstractions, and base data sources
- `lib/feature/work_order/`: feature module following data/domain/presentation layers
  - `data/`: DTOs, mappers, repositories, remote/local sources
  - `domain/`: entities and use cases
  - `presentation/`: BLoCs/Cubits, views, and widgets

## Maps (optional)

If you use maps, ensure Google Maps API keys are set up:

- Android: add the API key to `android/app/src/main/AndroidManifest.xml` as a `meta-data` entry.
- iOS: add the API key in `ios/Runner/AppDelegate.swift` or `Info.plist` per `google_maps_flutter` docs.

## Development notes

- `RemoteDatasource` composes the base URL as `${BACKEND_DOMAIN}/api` by default and attaches `Authorization: Bearer <token>` when you provide a token via `RemoteDatasource.setAuthTokenGetter`.
- Run `dart run build_runner build` after changing Retrofit-annotated files.

## License

Proprietary/internal project. Update this section if you adopt an open-source license.