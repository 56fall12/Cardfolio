
import getRequest

list_of_ids : list[str] = ['534919', '565606']


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    for i in list_of_ids:
        price: dict = getRequest.getPrice(i)
        print(f"The current market price is {price.get('price')} as of the date {price.get('date')}")

