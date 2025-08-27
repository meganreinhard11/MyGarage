// RegistrationExpense.swift
import SwiftData

@Model
final class RegistrationExpense: Expense {
    var stateOrProvince: String
    var validFrom: Date
    var validTo: Date

    // Override the parent initializer; set your own defaults here.
    override init(
        amount: Decimal,
        date: Date,
        mileage: Int,
        merchant: Merchant,
        car: Car,
        notes: String? = nil,
        isReimbursable: Bool = false
    ) {
        self.stateOrProvince = ""
        self.validFrom = date
        self.validTo = date
        super.init(
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
