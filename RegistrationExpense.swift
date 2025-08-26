
import SwiftData

@Model
final class RegistrationExpense: Expense {
    var stateOrProvince: String
    var validFrom: Date
    var validTo: Date

    init(amount: Decimal, date: Date, mileage: Int, stateOrProvince: String, validFrom: Date, validTo: Date, merchant: Merchant, car: Car) {
        self.stateOrProvince = stateOrProvince
        self.validFrom = validFrom
        self.validTo = validTo
        super.init(amount: amount, date: date, mileage: mileage, merchant: merchant, car: car)
    }
}
