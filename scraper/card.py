

class Card:
    def __init__(self, price: float, quantity: int, last_bought_price: float,  date: str, id: int):
        self._price: float= price
        self._quantity: int= quantity
        self._last_bought_price: float = last_bought_price
        self._current_price: float = 0
        self._date: str = date
        self._id = id

    @property
    def quantity(self):
        return self._quantity

    @quantity.setter
    def quantity(self, value):
        if value < 0:
            raise ValueError("Quantity cannot be less than 0")
        else:
            self._quantity = value
