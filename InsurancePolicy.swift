
import SwiftData

@Model
final class InsurancePolicy {
    @Attribute(.unique) var policyNumber: String
    var expenses: [InsuranceExpense] = []
    var claims: [InsuranceClaim] = []
    var cars: [Car] = []
    var merchant: Merchant

    init(policyNumber: String, merchant: Merchant) {
        self.policyNumber = policyNumber
        self.merchant = merchant
    }
}
