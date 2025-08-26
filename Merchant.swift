
import SwiftData

@Model
final class Merchant {
    var category: String
    var name: String?
    var notes: String?
    var phone: String?
    var storeId: String?
    var website: URL?

    var address: Address?
    var expenses: [Expense] = []
    var policies: [InsurancePolicy] = []

    init(category: String, name: String? = nil) {
        self.category = category
        self.name = name
    }
}
