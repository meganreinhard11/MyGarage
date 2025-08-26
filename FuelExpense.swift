
import SwiftData

@Model
final class FuelExpense: Expense {
    var gallons: Decimal
    var unitPrice: Decimal

    init(amount: Decimal, date: Date, mileage: Int, gallons: Decimal, unitPrice: Decimal, merchant: Merchant, car: Car, notes: String? = nil) {
        self.gallons = gallons
        self.unitPrice = unitPrice
        super.init(amount: amount, date: date, mileage: mileage, merchant: merchant, car: car, notes: notes)
    }
}
