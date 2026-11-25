# Cardfolio

A Flutter app for tracking Pokémon card prices. See a card's current market price, its recent trend, and its historical lows and highs in one place.

Built solo, Summer 2026.


<img width="267" height="541" alt="add_card" src="https://github.com/user-attachments/assets/8c9dd077-8285-4101-89ba-a1174f887970" />
<img width="266" height="559" alt="price_history" src="https://github.com/user-attachments/assets/a9c542fd-f4a4-4b4c-9fbe-377ff04e167b" />
<img width="257" height="164" alt="collection" src="https://github.com/user-attachments/assets/79a433c9-5762-4d96-abce-542d567c023e" />


## Features

- Create an account and track the Pokémon cards you care about
- Add a card to your collection by entering its card ID from the catalog
- A Collection screen (your binder) lists your saved cards
- A price history screen shows each card's latest market price, high, low and change, plus a dated price history
- Data is collected automatically every day by a companion scraper

## How it works

```
TCGPlayer price-history API  →  scraper (Python)  →  daily price data  →  Flutter app
```

1. **Scraper (`scraper/`)**: a Python script that calls TCGPlayer's internal price-history endpoint for each tracked product. I found the endpoint by inspecting network traffic in browser DevTools. For each product it records the `marketPrice` from the most recent daily price bucket and exports it to Google Sheets. It runs on a daily schedule.
2. **App (`flutter_app/`)**: the Flutter front end. It uses the scraper's data to show each card's current price, trend, and lows and highs.

The scraper can track any number of products. It currently tracks 10.

## Tech stack

- **App:** Flutter (Dart), Firebase Authentication, Cloud Firestore
- **Scraper:** Python, Google Sheets API
- **Data source:** TCGPlayer price-history API (unofficial)

## Getting started

1. Open the app and create an account.
2. Add a card to your collection by entering its card ID from the catalog.

There's nothing else to set up. The scraper runs on a daily schedule, so prices stay up to date automatically.

### Running from source

```bash
cd flutter_app
flutter pub get
flutter run
```

## Notes

- This is a personal project for my own use.
- It relies on an undocumented TCGPlayer endpoint, which may change or stop working at any time.
- Not affiliated with or endorsed by TCGPlayer or The Pokémon Company.
