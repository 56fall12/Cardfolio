
import getRequest
from firebase_client import write_to_database
from card import Card
list_of_ids : list[str] = ['534919', '565606', '610511', '246704', '550264']


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    for i in list_of_ids:
        card: Card = getRequest.getPrice(i)
        write_to_database(card)

    print("Writing Successful")