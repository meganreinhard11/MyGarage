
import SwiftData

@Model
final class Car {
    @Attribute(.unique) var id: UUID
    var name: String
    var licensePlate: String?

    @Relationship(deleteRule: .cascade) var expenses: [Expense] = []
    @Relationship(deleteRule: .cascade) var claims: [InsuranceClaim] = []
    var policies: [InsurancePolicy] = []
    @Relationship(deleteRule: .cascade) var mileageLogs: [MileageLog] = []

    init(id: UUID = UUID(), name: String, licensePlate: String? = nil) {
        self.id = id
        self.name = name
        self.licensePlate = licensePlate
    }
}
