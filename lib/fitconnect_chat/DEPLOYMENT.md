[//]: # (# Flutter App Deployment Guide)

[//]: # ()
[//]: # (## Quick Start)

[//]: # ()
[//]: # (### 1. Get Your Backend URL)

[//]: # (Your web backend is already running and ready. Get the URL from your Replit deployment:)

[//]: # (- Development: `http://localhost:5000` &#40;when running locally&#41;)

[//]: # (- Production: `https://your-app-name.replit.app` &#40;when deployed&#41;)

[//]: # ()
[//]: # (### 2. Configure Flutter App)

[//]: # (Update the `baseUrl` in `lib/services/api_service.dart`:)

[//]: # ()
[//]: # (```dart)

[//]: # (static const String baseUrl = 'https://your-app-name.replit.app';)

[//]: # (```)

[//]: # ()
[//]: # (### 3. Build and Test)

[//]: # (```bash)

[//]: # (# Install dependencies)

[//]: # (flutter pub get)

[//]: # ()
[//]: # (# Run on emulator/device)

[//]: # (flutter run)

[//]: # ()
[//]: # (# Build for Android)

[//]: # (flutter build apk --release)

[//]: # ()
[//]: # (# Build for iOS)

[//]: # (flutter build ios --release)

[//]: # (```)

[//]: # ()
[//]: # (## Backend Connection)

[//]: # ()
[//]: # (Your Flutter app connects to these existing API endpoints:)

[//]: # ()
[//]: # (### Authentication)

[//]: # (- `POST /api/auth/register` - Create new user account)

[//]: # (- `POST /api/auth/login` - User login)

[//]: # ()
[//]: # (### Gym Discovery)

[//]: # (- `GET /api/gyms?lat=12.9716&lng=77.5946` - Get gyms by location)

[//]: # (- `GET /api/gyms?search=gold` - Search gyms by name)

[//]: # (- `GET /api/gyms/:id/members` - Get gym members)

[//]: # ()
[//]: # (### Social Features)

[//]: # (- `POST /api/users/:id/gyms` - Join a gym)

[//]: # (- `GET /api/chats` - Get user's chat rooms)

[//]: # (- `POST /api/chats` - Create new chat)

[//]: # (- `GET /api/chats/:id/messages` - Get chat messages)

[//]: # (- `POST /api/chats/:id/messages` - Send message)

[//]: # ()
[//]: # (## Testing the Connection)

[//]: # ()
[//]: # (1. **Register a Test User**)

[//]: # (   ```dart)

[//]: # (   // The Flutter app will call:)

[//]: # (   // POST https://your-app.replit.app/api/auth/register)

[//]: # (   ```)

[//]: # ()
[//]: # (2. **Search for Gyms**)

[//]: # (   ```dart)

[//]: # (   // With city selector coordinates:)

[//]: # (   // GET https://your-app.replit.app/api/gyms?lat=19.0760&lng=72.8777)

[//]: # (   ```)

[//]: # ()
[//]: # (3. **Join Gym and Chat**)

[//]: # (   ```dart)

[//]: # (   // Join gym and view members:)

[//]: # (   // POST https://your-app.replit.app/api/users/{userId}/gyms)

[//]: # (   // GET https://your-app.replit.app/api/gyms/{gymId}/members)

[//]: # (   ```)

[//]: # ()
[//]: # (## App Store Deployment)

[//]: # ()
[//]: # (### Google Play Store &#40;Android&#41;)

[//]: # (1. Create a signed APK:)

[//]: # (   ```bash)

[//]: # (   flutter build apk --release --dart-define=API_BASE_URL=https://your-app.replit.app)

[//]: # (   ```)

[//]: # ()
[//]: # (2. Upload to Google Play Console)

[//]: # (3. Set app name: "FitConnect - Gym Social Network")

[//]: # (4. Add screenshots and description)

[//]: # ()
[//]: # (### Apple App Store &#40;iOS&#41;)

[//]: # (1. Build for iOS:)

[//]: # (   ```bash)

[//]: # (   flutter build ios --release --dart-define=API_BASE_URL=https://your-app.replit.app)

[//]: # (   ```)

[//]: # ()
[//]: # (2. Use Xcode to create archive)

[//]: # (3. Upload to App Store Connect)

[//]: # (4. Submit for review)

[//]: # ()
[//]: # (## Features Available)

[//]: # ()
[//]: # (### ✅ Working Features &#40;Ready to Use&#41;)

[//]: # (- User registration and login)

[//]: # (- City-based gym discovery &#40;40+ Indian cities&#41;)

[//]: # (- Real-time gym data from your backend)

[//]: # (- Gym member viewing)

[//]: # (- Join gym functionality)

[//]: # (- Chat room creation)

[//]: # (- Message sending/receiving)

[//]: # (- Location-based search)

[//]: # ()
[//]: # (### 🔄 Google Places Integration)

[//]: # (Your backend has Google Places API integration. To enable real gym data:)

[//]: # (1. Enable Places API in Google Cloud Console)

[//]: # (2. Enable billing on your Google Cloud project)

[//]: # (3. Add Places API permissions to your existing key)

[//]: # ()
[//]: # (Once configured, the Flutter app will automatically receive:)

[//]: # (- Real gym photos from Google Maps)

[//]: # (- Authentic gym ratings and reviews)

[//]: # (- Actual gym locations and amenities)

[//]: # (- Live business hours and contact info)

[//]: # ()
[//]: # (## Architecture Benefits)

[//]: # ()
[//]: # (### Why This Approach Works)

[//]: # (1. **Single Backend**: Your web app and Flutter app share the same API)

[//]: # (2. **Consistent Data**: Same gym data, users, and chats across platforms)

[//]: # (3. **Easy Maintenance**: Update backend once, both apps benefit)

[//]: # (4. **Cost Effective**: One server, multiple client apps)

[//]: # ()
[//]: # (### Scaling Considerations)

[//]: # (- Backend can handle multiple Flutter app instances)

[//]: # (- Database shared between web and mobile users)

[//]: # (- Chat system works across platforms)

[//]: # (- Google Places API serves both applications)

[//]: # ()
[//]: # (## Next Steps)

[//]: # ()
[//]: # (1. **Complete Flutter Implementation**)

[//]: # (    - Copy all provided Flutter files)

[//]: # (    - Update backend URL configuration)

[//]: # (    - Test on device/emulator)

[//]: # ()
[//]: # (2. **Deploy Backend**)

[//]: # (    - Use Replit's deployment feature)

[//]: # (    - Get production URL)

[//]: # (    - Update Flutter configuration)

[//]: # ()
[//]: # (3. **Publish Mobile App**)

[//]: # (    - Build release versions)

[//]: # (    - Submit to app stores)

[//]: # (    - Launch to users)

[//]: # ()
[//]: # (4. **Enable Google Places &#40;Optional&#41;**)

[//]: # (    - Configure Google Cloud settings)

[//]: # (    - Get real gym data automatically)

[//]: # ()
[//]: # (Your gym networking platform is now ready for both web and mobile users!)