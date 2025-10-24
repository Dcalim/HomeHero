# HomeHero

Household Management Simplified — a shared dashboard for chores, bills, groceries, reminders and simple automation for families and roommates.

## Resources
- Miro board: https://miro.com/app/board/uXjVJ0ks-8k=/?share_link_id=499017191447

## Key ideas
- Problem: Difficulty coordinating chores, shared expenses and shopping across household members.
- Solution: Unified app with tasks, bills, shopping lists, smart reminders and automation rules.
- Expansion: Grocery API integrations (Walmart / Instacart), budget insights and predictive shopping.

## Features
- Shared tasks & chore schedules with assignment and completion history
- Shared bills and expense tracking, per-person splits
- Shared shopping lists with sync and item suggestions
- Push & in-app reminders, recurring schedules and simple automation
- User accounts + household invitation flow
- Offline-first sync and conflict resolution (via Firebase)

## Tech stack
- iOS app: Swift (SwiftUI + Combine recommended)
- Backend: Java Spring Boot (REST APIs, business logic, integrations)
- Realtime storage / auth / notifications: Firebase (Firestore, Auth, Cloud Messaging, Functions)
- Optional third-party integrations: Grocery APIs, payment providers

## Suggested repo layout
- /ios/            — Swift project (HomeHero.xcodeproj)
- /backend/        — Spring Boot service (Gradle/Maven)
- /firebase/       — Firestore rules, Cloud Functions, deployment scripts
- /docs/           — design, API spec, user flows
- /scripts/        — dev / CI helpers

## Getting started (dev)
1. Firebase
    - Create Firebase project, enable Auth (Email), Firestore, Cloud Messaging.
    - Add iOS app and download GoogleService-Info.plist -> place in /ios/HomeHero/Resources.
    - Add necessary Firestore rules and indexes from /firebase.
2. Backend (Spring Boot)
    - Configure application.properties / environment:
      - FIREBASE_PROJECT_ID, FIREBASE_CREDENTIALS_PATH, DATABASE_URL, JWT_SECRET
    - Run: ./gradlew bootRun (or `mvn spring-boot:run`)
3. iOS
    - Open ios/HomeHero.xcodeproj in Xcode
    - Install any SPM/CocoaPods dependencies
    - Build & run on simulator or device

## Env / config examples
- backend: application.properties
  - server.port=8080
  - spring.datasource.* (if using SQL)
  - firebase.credentials=/path/to/serviceAccount.json
  - jwt.secret=REPLACE_ME
- ios: add GoogleService-Info.plist and configure FirebaseApp.configure() in App entry

## Architecture notes
- Source of truth: Firestore for realtime sync; backend as trusted layer for integrations, webhooks, payments and heavy business logic.
- Auth: Firebase Auth for user accounts, custom tokens issued by backend when needed.
- Notifications: Firebase Cloud Messaging + APNs for iOS.
- Integrations: keep adapter layer in backend for grocery/payment APIs; use queued jobs / Cloud Functions for expensive operations.

## Roadmap (short)
- v0.1: Core features (tasks, lists, bills, basic notifications)
- v0.2: Invite flows, offline sync improvements, role-based permissions
- v0.3: Grocery API integrations, budget analytics, smart suggestions

## Contributing
- Open issues for features/bugs
- Follow branch-per-feature workflow
- Write tests for backend and UI flows where applicable
- Add docs in /docs for major changes

## Privacy & security
- Minimize PII, encrypt sensitive data at rest, secure API keys (do not commit).
- Use Firebase security rules and backend authorization checks.

## License
- Add a LICENSE file (e.g., MIT) and reference it here.

For implementation details (API schema, Firestore model, iOS data layer, Spring Boot controllers) add specs to /docs or request specific templates.
