import unittest
from card import Card

class MyTestCase(unittest.TestCase):

    test_card = Card(0, 0, 0, "", 0, "")

    def test_card_quantity_checker(self):
        with self.assertRaises(ValueError):
            self.test_card.quantity = -1
        self.assertEqual(self.test_card.quantity,0)
        self.test_card.quantity = 5
        self.assertEqual(self.test_card.quantity, 5)

    def test_card_id_checker(self):
        with self.assertRaises(ValueError):
            self.test_card.id = -1
        self.assertEqual(self.test_card.id, 0)
        self.test_card.id = 5
        self.assertEqual(self.test_card.id, 5)

    def test_card_date(self):
        self.assertEqual(self.test_card.date, "")
        self.test_card.date = "09/08/2026"
        self.assertEqual(self.test_card.date, "09/08/2026")


if __name__ == '__main__':
    unittest.main()
