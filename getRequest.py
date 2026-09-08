from xmlrpc.client import DateTime

import requests
#we wanna get the sku and then we can pass that into the get market price request nodders


def getPrice(id: str):
    '''
    take in a product ID and return the newest market price near mint for it and the date
    :return: dict
    '''

    product_id: str = id

    url : str = f"https://infinite-api.tcgplayer.com/price/history/{product_id}/detailed?range=quarter"



    response = requests.get(url)
    data = response.json()
    results: list = data['result']
    prices: dict = results[0]['buckets'][0]
    newestPrice: int = prices.get('marketPrice')
    date: str = prices.get('bucketStartDate')
    info: dict[str, int | str] = {
        'price': newestPrice,
        'date': date
    }
    return info
