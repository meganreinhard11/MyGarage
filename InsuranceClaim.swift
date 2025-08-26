
import SwiftData

@Model
final class InsuranceClaim {
    var claimNumber: String?
    var incidentDate: Date?
    var status: String?
    var claimType: String?
    var totalDamageEstimate: Decimal?
    var deductibleApplied: Decimal?
    var payoutAmount: Decimal?
    var isAtFault: Bool
    var descriptionText: String?

    var car: Car?
    var policy: InsurancePolicy?
    var expenses: [Expense] = []
    var policeReports: [PoliceReport] = []
    var photos: [ClaimPhoto] = []

    init(claimNumber: String? = nil, incidentDate: Date? = nil, status: String? = nil, claimType: String? = nil, isAtFault: Bool = false, description: String? = nil) {
        self.claimNumber = claimNumber
        self.incidentDate = incidentDate
        self.status = status
               self.claimType = claimType
        self.isAtFault = isAtFault
        self.descriptionText = description
    }
}
