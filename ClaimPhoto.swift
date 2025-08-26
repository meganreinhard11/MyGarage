
import SwiftData

@Model
final class ClaimPhoto {
    @Attribute(.unique) var filePath: String
    var latitude: Decimal
    var longitude: Decimal
    var notes: String?
    var position: Int
    var claim: InsuranceClaim

    init(filePath: String, latitude: Decimal, longitude: Decimal, notes: String? = nil, position: Int, claim: InsuranceClaim) {
        self.filePath = filePath
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
        self.position = position
        self.claim = claim
    }
}
