
import SwiftData

@Model
class Expense {
    @Attribute(.unique) var id: UUID
    var amount: Decimal
    var date: Date
    var mileage: Int
    var notes: String?
    var isReimbursable: Bool
    var merchant: Merchant
    var car: Car
    var claim: InsuranceClaim?

    init(id: UUID = UUID(), amount: Decimal, date: Date, mileage: Int, merchant: Merchant, car: Car, notes: String? = nil, isReimbursable: Bool = false) {
        self.id = id
        self.amount = amount
        self.date = date
        self.mileage = mileage
        self.merchant = merchant
        self.car = car
        self.notes = notes
        self.isReimbursable = isReimbursable
    }
}
