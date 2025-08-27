// RegistrationExpense.swift
import SwiftData

@Model
final class RegistrationExpense: Expense {
    var stateOrProvince: String
    var validFrom: Date
    var validTo: Date

    // Must match the superclass init (note the `id:` parameter)
    override init(
        id: UUID = UUID(),
        amount: Decimal,
        date: Date,
        mileage: Int,
        merchant: Merchant,
        car: Car,
        notes: String? = nil,
        isReimbursable: Bool = false
    ) {
        // Set subclass stored properties before super.init
        self.stateOrProvince = ""
        self.validFrom = date
        self.validTo = date
        super.init(
            id: id,
            amount: amount,
            date: date,
            mileage: mileage,
            merchant: merchant,
            car: car,
            notes: notes,
            isReimbursable: isReimbursable
        )
    }
}
