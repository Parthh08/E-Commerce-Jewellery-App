# Luxury Jewelry App

A sophisticated Flutter-based e-commerce application for luxury jewelry, featuring a modern UI with a premium gold and ivory color scheme.

## Features

- **Authentication**
  - Email/Password login and registration
  - Google Sign-In integration
  - Secure Firebase authentication

- **Product Management**
  - Browse jewelry collection
  - Detailed product views with high-resolution images
  - Product ratings and descriptions
  - Real-time price updates

- **Shopping Experience**
  - Interactive shopping cart
  - Quantity management
  - Smooth checkout process
  - PhonePe payment integration

- **User Features**
  - User profile management
  - Order history
  - Sales analytics visualization
  - Responsive bottom navigation

## Technology Stack

- **Frontend**: Flutter
- **State Management**: GetX
- **Backend**: Firebase
- **Authentication**: Firebase Auth
- **Payment Gateway**: PhonePe
- **Analytics**: Custom sales tracking with FL Chart

## Getting Started

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK
- Firebase account
- Android Studio / VS Code
- PhonePe merchant account

### Installation

1. Clone the repository
```bash
git clone [repository-url]
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add your `google-services.json` to the Android app directory
- Update Firebase configuration in `lib/firebase_options.dart`

4. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── controllers/      # GetX controllers for state management
├── models/          # Data models
├── pages/           # UI screens
├── services/        # Business logic and API services
├── widgets/         # Reusable UI components
└── main.dart        # Application entry point
```

## Color Scheme

- Primary (Gold): `#D4AF37`
- Secondary (Deep Royal Blue): `#1A237E`
- Background (Light Cream): `#FFF8E1`
- Surface (Ivory): `#FAF9F6`

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For support or queries, please reach out to [your-email]
