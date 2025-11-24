# Quick Google Sign-In Setup (5 Minutes) ⚡

## Minimum Setup Required

You only need to complete **Steps 1-4** to get Google Sign-In working.

## Step 1: Create Firebase Project (2 min)

1. Go to https://console.firebase.google.com/
2. Click **"Add Project"**
3. Name: `braincount` → Create
4. Skip analytics → Continue

## Step 2: Add Android App (2 min)

1. Click **"Add App"** → **Android**
2. Package: `org.braincount.braincount`
3. Register app
4. **Download `google-services.json`**

## Step 3: Add google-services.json (30 sec)

Copy `google-services.json` to:
```
braincount/android/app/google-services.json
```

## Step 4: Update build.gradle (30 sec)

### File: `braincount/android/app/build.gradle`

Add this plugin at the top:
```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
    id "com.google.gms.google-services"  // ← ADD THIS LINE
}
```

### File: `braincount/android/build.gradle`

Add this at the bottom:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.2'  // ← ADD THIS LINE
    }
}
```

## Step 5: Run App (30 sec)

```bash
cd braincount
flutter clean
flutter run
```

## Done! ✅

Google Sign-In should now work!

## Optional: Add SHA-1 for OAuth

Only needed if you want to skip "Verify it's you" screen.

Get SHA-1:
```bash
keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
```

Add to Firebase:
1. Firebase Console → Project Settings
2. Scroll to "SHA certificate fingerprints"
3. Add SHA-1
4. Save

## Troubleshooting

**Error: "ApiException: 10"**
- Make sure `google-services.json` is in `android/app/`
- Verify plugin added to `app/build.gradle`
- Run `flutter clean && flutter run`

**Still not working?**
- See detailed guide: `GOOGLE_SIGNIN_FIREBASE_SETUP.md`

