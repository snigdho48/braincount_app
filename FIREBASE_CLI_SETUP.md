# Firebase CLI Setup for Google Sign-In 🚀

## Quick Answer

**You don't need Firebase CLI for Google Sign-In!** 

Firebase CLI is great for:
- Firebase Hosting
- Cloud Functions
- Firestore rules
- Realtime Database

But for **Google Sign-In**, you only need:
1. `google-services.json` file from Firebase Console
2. Add Google Services plugin to Gradle

## Manual Setup (Recommended - 5 min)

Follow the simple guide: `GOOGLE_SIGNIN_SIMPLE_SETUP.md`

## OR Use Firebase CLI (If You Want)

If you prefer using CLI:

### 1. Login to Firebase

```bash
firebase login
```

### 2. Initialize Firebase (Optional)

```bash
cd braincount
firebase init
```

Select:
- ❌ Functions
- ✅ Hosting (if needed)
- ❌ Firestore
- ❌ Storage
- ✅ Analytics

### 3. Still Need google-services.json!

Even with CLI, you still need to:
1. Go to Firebase Console
2. Add Android app
3. Download `google-services.json`
4. Place in `android/app/`

**CLI doesn't generate `google-services.json` automatically!**

### 4. Configure Android

Update `android/app/build.gradle`:
```gradle
plugins {
    id "com.google.gms.google-services"
}
```

## Recommendation

**Use Simple Setup:** Follow `GOOGLE_SIGNIN_SIMPLE_SETUP.md`
- Faster
- Fewer steps
- Same result

Firebase CLI is optional for Google Sign-In!

