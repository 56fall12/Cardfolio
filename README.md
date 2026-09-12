# Pokémon Card Tracker

A Pokémon card tracking Android application built with **Flutter** and **web scraping**. The app allows users to manage their Pokémon card collection and maintain a watchlist of cards they are interested in.

## Features

* Track Pokémon cards in a personal collection
* Add and remove cards from the collection
* Add and remove cards from a watchlist
* View collection and watchlist through the Android app
* Retrieve Pokémon card information using web scraping
* User authentication with Firebase
* Store collection and watchlist data using Cloud Firestore

## Technologies

* **Flutter / Dart** — Android application and user interface
* **Firebase Authentication** — User authentication
* **Cloud Firestore** — Collection and watchlist data storage
* **Python** — Web scraping and data collection
* **Web Scraping** — Retrieving Pokémon card information from online sources

## How It Works

The project consists of two main components.

### Web Scraper

The web scraper retrieves Pokémon card information from online sources. The collected data can then be used by the Flutter application to display card information.

### Flutter Android App

The Flutter application provides the interface for managing cards.

Users can:

1. Sign into their account.
2. View their Pokémon card collection.
3. Add or remove cards from their collection.
4. Add or remove cards from their watchlist.
5. Access application settings and sign out.

Collection and watchlist data are stored separately for each authenticated user.

## Data Storage

User data is organized using the Firebase user ID:

```text
users/
└── {userId}/
    ├── collection/
    └── watchlist/
```

This allows each user to maintain their own collection and watchlist.

## Getting Started

### Prerequisites

* Flutter
* Android Studio
* Android SDK
* Firebase project
* Python 3.x

### Clone the Repository

```bash
git clone <repository-url>
cd pokemon-card-tracker
```

### Run the Flutter App

Navigate to the Flutter project:

```bash
cd flutter_app
```

Install dependencies:

```bash
flutter pub get
```

Configure Firebase for the Android application, then run:

```bash
flutter run
```

## Firebase

The application uses **Firebase Authentication** and **Cloud Firestore** to manage user accounts and store collection/watchlist data.

To run the project locally, you will need to configure your own Firebase project and add the required Firebase configuration files.

## Web Scraping

The scraping component is responsible for retrieving Pokémon card information from online sources.

When modifying the scraper, requests should be kept reasonable and the policies of the target website should be followed.

## Future Improvements

* Card search functionality
* Card images and detailed card information
* Collection sorting and filtering
* Card quantity tracking
* Price tracking
* Collection statistics
* Watchlist notifications
* Automatic card data updates
* Detailed card pages

## Disclaimer

This project is not affiliated with or endorsed by The Pokémon Company, Nintendo, or Game Freak.
