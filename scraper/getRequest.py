from xmlrpc.client import DateTime
from card import Card
import requests
#we wanna get the sku and then we can pass that into the get market price request nodders


def getPrice(id: str):
    '''
    take in a product ID and return the newest market price near mint for it and the date
    :return: Card
    '''

    product_id: str = id

    url : str = f"https://infinite-api.tcgplayer.com/price/history/{product_id}/detailed?range=quarter"


    response = requests.get(url)
    data = response.json()
    condition_results: list[dict] = []
    results: list = data['result']

    for i in results:
        if i.get("condition") == "Near Mint":
            condition_results = i
            break
        elif i.get("condition") == "Unopened":
            condition_results = i
            break

    prices: dict = condition_results.get('buckets')[0]
    all_prices: dict = condition_results['buckets']


    newest_price: int = prices.get('marketPrice')
    date: str = prices.get('bucketStartDate')
    last_sold_price:float = 0
    last_sold_date: str = ""

    for i in all_prices:
        if int(i.get('quantitySold')) > 0:
            last_sold_price = i.get('marketPrice')
            last_sold_date = i.get('bucketStartDate')

    info: Card = Card(newest_price, 0, last_sold_price, date, int(id), last_sold_date)
    return info
