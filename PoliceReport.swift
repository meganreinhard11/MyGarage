
import SwiftData

@Model
final class PoliceReport {
    var reportNumber: String?
    var incidentDateTime: Date?
    var location: String?
    var jurisdiction: String?
    var officerName: String?
    var badgeNumber: String?
    var narrative: String?
    var attachmentsCount: Int?
    @Attribute(.externalStorage) var document: Data
    var claim: InsuranceClaim?

    init(document: Data) { self.document = document }
}
