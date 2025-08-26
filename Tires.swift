
import SwiftData

@Model
final class TireSpec {
    var brand: String?
    var model: String?
    var sizeCode: String?
    var warrantyMiles: Int?
    var expenses: [TireExpense] = []
    @Attribute(.unique) var composite: String
    init(brand: String? = nil, model: String? = nil, sizeCode: String? = nil, warrantyMiles: Int? = nil) {
        self.brand = brand; self.model = model; self.sizeCode = sizeCode; self.warrantyMiles = warrantyMiles
        self.composite = [brand ?? "", model ?? "", sizeCode ?? "", warrantyMiles.map(String.init) ?? ""].joined(separator: "|")
    }
}

@Model
final class TireExpense: Expense {
    var position: String
    var spec: TireSpec?
    init(amount: Decimal, date: Date, mileage: Int, position: String, merchant: Merchant, car: Car, spec: TireSpec? = nil) {
        self.position = position; self.spec = spec
        super.init(amount: amount, date: date, mileage: mileage, merchant: merchant, car: car)
    }
}
