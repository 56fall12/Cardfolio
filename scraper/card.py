

class Card:
    def __init__(self, price: float, quantity: int, last_bought_price: float,  date: str, id: int, last_sold_date: str):
        self._price: float= price
        self._quantity: int= quantity
        self._last_bought_price: float = last_bought_price
        self._current_price: float = 0
        self._date: str = date
        self._id:int = id
        self._last_sold_date: str = last_sold_date

    @property
    def quantity(self):
        return self._quantity

    @quantity.setter
    def quantity(self, value):
        if value < 0:
            raise ValueError("Quantity cannot be less than 0")
        else:
            self._quantity = value

    @property
    def id(self):
        return self._id

    @id.setter
    def id(self, value):
        if value < 0:
            raise ValueError("ID cannot be less than 0")
        else:
            self._id = value

    @property
    def date(self):
        return self._date

    @date.setter
    def date(self, date: str):
        self._date = date

    @property
    def price(self):
        return self._price