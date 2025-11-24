# Firebase Console Setup Steps 📝

## Project ID Issue

The CLI failed because `braincount_app` contains underscore (invalid). Use Firebase Console instead:

## Step-by-Step in Firebase Console

### 1. Open Firebase Console
https://console.firebase.google.com/

### 2. Create Project
- Click **"Add Project"**
- Project name: `braincount` (or any name)
- Disable Google Analytics (optional)
- Click **"Create Project"**
- Click **"Continue"**

### 3. Add Android App
- Click **"Add App"** icon
- Select **Android** platform
- Enter details:
  ```
  Package name: org.braincount.braincount
  App nickname: braincount (optional)
  ```
- Click **"Register App"**

### 4. Download google-services.json
- Click **"Download google-services.json"**
- **STOP HERE** - Save this file!

### 5. Continue Setup (Skip for now)
- Click **"Next"** (skip remaining steps)
- You can set up later

## Next Steps

After you download `google-services.json`, we'll:
1. Place it in `android/app/`
2. Update Gradle files
3. Test Google Sign-In

## You Are Here ⬇️

Currently at: **Download google-services.json**

Next: Tell me when you have the file downloaded!

