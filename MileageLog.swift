
import SwiftData

@Model
final class MileageLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var odometer: Int?
    var car: Car

    init(id: UUID = UUID(), date: Date, odometer: Int? = nil, car: Car) {
        self.id = id
        self.date = date
        self.odometer = odometer
        self.car = car
    }
}
