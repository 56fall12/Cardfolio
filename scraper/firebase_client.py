import firebase_admin
from firebase_admin import credentials, firestore
from card import Card


cred = credentials.Certificate("pokemon-card-collection-f9e21-firebase-adminsdk-fbsvc-41460bda94.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

def write_to_database(card: Card):

    today_price: dict = {
        "price" : card.price
    }
    db.collection("cards").document(str(card.id)).set({
        "product_id": card.id,
    }, merge = True)
    db.collection("cards").document(str(card.id)).collection("price_history").document(card.date).set(today_price, merge = True)
