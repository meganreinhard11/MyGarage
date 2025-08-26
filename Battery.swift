
import SwiftData

@Model
final class BatterySpec {
    var brand: String?
    var groupSize: String?
    var warrantyMonths: Int?
    var expenses: [BatteryExpense] = []
    @Attribute(.unique) var composite: String
    init(brand: String? = nil, groupSize: String? = nil, warrantyMonths: Int? = nil) {
        self.brand = brand; self.groupSize = groupSize; self.warrantyMonths = warrantyMonths
        self.composite = [brand ?? "", groupSize ?? "", warrantyMonths.map(String.init) ?? ""].joined(separator: "|")
    }
}

@Model
final class BatteryExpense: Expense { var cca: Int?; var coreCharge: Decimal?; var serialNumber: String?; var spec: BatterySpec? }
