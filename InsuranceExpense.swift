
import SwiftData

@Model
final class InsuranceExpense: Expense {
    var coverageType: String?
    var deductible: Decimal?
    var termStart: Date
    var termEnd: Date
    var paidInFull: Bool
    var policy: InsurancePolicy?

    init(amount: Decimal, date: Date, mileage: Int, coverageType: String? = nil, deductible: Decimal? = nil, termStart: Date, termEnd: Date, paidInFull: Bool = true, policy: InsurancePolicy? = nil, merchant: Merchant, car: Car) {
        self.coverageType = coverageType
        self.deductible = deductible
        self.termStart = termStart
        self.termEnd = termEnd
        self.paidInFull = paidInFull
        self.policy = policy
        super.init(amount: amount, date: date, mileage: mileage, merchant: merchant, car: car)
    }
}
