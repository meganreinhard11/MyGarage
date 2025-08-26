
import SwiftData

@Model
final class Address {
    var city: String?
    var country: String?
    var latitude: Double?
    var line1: String?
    var line2: String?
    var longitude: Double?
    var postalCode: String?
    var stateOrProvince: String?
    var shop: Merchant?
}
