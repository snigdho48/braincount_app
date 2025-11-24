# Google Sign-In Firebase Setup Guide 🔥

## Error: ApiException: 10 (DEVELOPER_ERROR)

This error occurs because Google Sign-In requires Firebase configuration. Follow these steps:

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add Project"**
3. Enter project name: `braincount` (or your choice)
4. Disable Google Analytics (optional)
5. Click **"Create Project"**

## Step 2: Add Android App to Firebase

1. In Firebase Console, click **"Add App"** → Select **Android**
2. Register app:
   - **Package name**: `org.braincount.braincount` (from build.gradle)
   - **App nickname**: `braincount`
   - **Debug signing certificate SHA-1**: (Optional, needed for OAuth)

3. Download **`google-services.json`** file

## Step 3: Add google-services.json to Android Project

1. Copy `google-services.json` to:
   ```
   braincount/android/app/
   ```

2. Your file structure should be:
   ```
   braincount/
   └── android/
       └── app/
           ├── google-services.json  ← ADD THIS FILE
           ├── build.gradle
           └── src/
   ```

## Step 4: Update Android Build Files

### Update `braincount/android/build.gradle`:

Add this at the bottom:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.2'  // Add this line
    }
}
```

### Update `braincount/android/app/build.gradle`:

Add at the top:
```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
    id "com.google.gms.google-services"  // Add this line
}
```

### Update `braincount/android/settings.gradle`:

Make sure it has Google repository:
```gradle
pluginManagement {
    repositories {
        google()  // Must be first
        mavenCentral()
        gradlePluginPortal()
    }
}
```

## Step 5: Get SHA-1 Certificate (for OAuth)

### For Debug Build:

**Windows:**
```bash
cd C:\Program Files\Java\jdk-*\bin
keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
```

**macOS/Linux:**
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

Copy the **SHA-1** fingerprint (e.g., `A1:B2:C3:D4:E5:F6:...`)

### Add SHA-1 to Firebase:

1. In Firebase Console → Project Settings → Your Android App
2. Scroll to **"SHA certificate fingerprints"**
3. Click **"Add fingerprint"**
4. Paste your SHA-1
5. Click **"Save"**

## Step 6: Enable Google Sign-In in Firebase Console

1. In Firebase Console, go to **Authentication**
2. Click **"Get Started"**
3. Go to **"Sign-in method"** tab
4. Click **"Google"** provider
5. Toggle **"Enable"**
6. Enter support email
7. Click **"Save"**

## Step 7: Configure OAuth Consent Screen (Google Cloud)

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project
3. Go to **APIs & Services** → **OAuth consent screen**
4. Configure:
   - **User Type**: External
   - **App name**: BrainCount
   - **User support email**: Your email
   - **Developer contact**: Your email
5. Add scopes:
   - `email`
   - `profile`
   - `openid`
6. Add test users (your Gmail for testing)
7. Click **"Save and Continue"**

### Add OAuth Credentials:

1. Go to **APIs & Services** → **Credentials**
2. You should see **"Web client"** auto-created
3. Note the **"Client ID"**

### Authorized redirect URIs:

Add these to OAuth 2.0 Client:
```
com.googleusercontent.apps.YOUR-CLIENT-ID
```

## Step 8: Update Flutter Google Sign-In Configuration (Optional)

If needed, you can specify a web client ID in code:

In `lib/app/modules/auth/controllers/login_controller.dart`:

```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  // Optional: Add your web client ID
  // serverClientId: 'YOUR-WEB-CLIENT-ID.apps.googleusercontent.com',
);
```

## Step 9: Clean and Rebuild

```bash
cd braincount

# Clean build
flutter clean
flutter pub get

# Rebuild
flutter run
```

## Step 10: Test Google Sign-In

1. Run the app
2. Tap **"Login with Google"**
3. You should see Google account picker
4. Select your Google account
5. Grant permissions
6. Should login successfully!

## Troubleshooting

### Error: "PlatformException: sign_in_failed, 10"

**Cause**: Missing `google-services.json` or incorrect configuration

**Solution**: 
- Ensure `google-services.json` is in `android/app/`
- Verify `google-services` plugin is applied in `app/build.gradle`
- Clean rebuild: `flutter clean && flutter run`

### Error: "ApiException: 12500"

**Cause**: Sign-in was cancelled

**Solution**: Try signing in again

### Error: SHA-1 mismatch

**Cause**: Different signing certificate

**Solution**: 
- Add correct SHA-1 to Firebase
- For release: Generate SHA-1 from release keystore
- Wait 5–10 minutes after adding SHA-1 for changes to propagate

### Error: App not authorized

**Cause**: App not in test users list or consent screen not configured

**Solution**:
- Add your email to OAuth test users
- Complete OAuth consent screen setup
- Wait for Google approval (can take hours)

### No Account Picker Appears

**Cause**: Previously signed in, cached account

**Solution**: Already fixed in code! Our `loginWithGoogle()` calls `signOut()` first to force account picker.

## Files Modified

After setup, these files should exist/be modified:

```
braincount/
├── android/
│   ├── app/
│   │   ├── google-services.json  ← NEW FILE
│   │   └── build.gradle          ← MODIFIED
│   ├── build.gradle              ← MODIFIED
│   └── settings.gradle           ← CHECKED
└── lib/app/modules/auth/
    └── controllers/
        └── login_controller.dart  ← READY
```

## Verification Checklist

- [ ] Firebase project created
- [ ] Android app added to Firebase
- [ ] `google-services.json` downloaded and placed in `android/app/`
- [ ] `build.gradle` files updated with Google Services
- [ ] SHA-1 added to Firebase (both debug and release)
- [ ] Google Sign-In enabled in Firebase Console
- [ ] OAuth consent screen configured
- [ ] Test user added
- [ ] Project cleaned and rebuilt
- [ ] Google Sign-In tested successfully

## Quick Reference

**Firebase Console**: https://console.firebase.google.com/  
**Google Cloud Console**: https://console.cloud.google.com/  
**Package Name**: `org.braincount.braincount`

## Production Considerations

### Before Release:

1. **Add Release SHA-1**:
   ```bash
   keytool -list -v -keystore your-release-key.jks -alias your-key-alias
   ```

2. **OAuth Consent Screen**:
   - Submit for verification
   - Add privacy policy URL
   - Add terms of service URL
   - Complete app verification

3. **Production Firebase**:
   - Use production `google-services.json`
   - Enable app check
   - Configure security rules

## Need Help?

Common issues and solutions are in troubleshooting section above.

For more help:
- [Firebase Docs](https://firebase.google.com/docs)
- [Google Sign-In for Android](https://developers.google.com/identity/sign-in/android/start)
- [Flutter google_sign_in plugin](https://pub.dev/packages/google_sign_in)

