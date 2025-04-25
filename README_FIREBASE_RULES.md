# Firebase Security Rules Instructions

## Issue
You're experiencing permission errors when trying to access Firestore collections:
```
[cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
```

This is happening because the Firestore security rules are too restrictive and don't allow authenticated users to access their own data.

## Solution
I've created a `firestore.rules` file with the appropriate security rules to allow authenticated users to access their own data. You need to upload these rules to your Firebase project.

## How to Upload the Rules

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. In the left sidebar, click on "Firestore Database"
4. Click on the "Rules" tab
5. Replace the existing rules with the content of the `firestore.rules` file I've created
6. Click "Publish"

## What the Rules Do

The rules allow:
- Authenticated users to read and write to their own user document
- Authenticated users to read and write to their own subcollections:
  - saved_books
  - favorites
  - reading_history
  - reading_history_entries
- Access to all other documents is denied by default

This ensures that users can only access their own data, maintaining security while allowing the app to function properly.

## Verification

After uploading the rules, restart your app and verify that the permission errors are resolved. You should now be able to:
- Save books
- Add books to favorites
- View your reading history

If you continue to experience issues, please check that:
1. The user is properly authenticated
2. The user ID in the error logs matches the authenticated user's ID
3. The rules were published successfully