
import SwiftData

@Model
final class WiperStyle { var brand: String?; var model: String?; var blade: String?; var spec: [WiperSpec] = []; @Attribute(.unique) var composite: String; init(brand: String? = nil, model: String? = nil, blade: String? = nil) { self.brand = brand; self.model = model; self.blade = blade; self.composite = [brand ?? "", model ?? "", blade ?? ""].joined(separator: "|") } }

@Model
final class WiperSpec { var position: String; var lengthInches: Int?; var expenses: [WiperExpense] = []; var style: WiperStyle?; @Attribute(.unique) var composite: String; init(position: String, lengthInches: Int? = nil, style: WiperStyle? = nil) { self.position = position; self.lengthInches = lengthInches; self.style = style; self.composite = [position, lengthInches.map(String.init) ?? ""].joined(separator: "|") } }

@Model
final class WiperExpense: Expense { var spec: WiperSpec? }

@Model
final class LightBulbSpec { var bulbType: String; var position: String; var expenses: [LightBulbExpense] = []; @Attribute(.unique) var composite: String; init(bulbType: String, position: String) { self.bulbType = bulbType; self.position = position; self.composite = bulbType + "|" + position } }

@Model
final class LightBulbExpense: Expense { var spec: LightBulbSpec? }

@Model
final class MaintenanceExpense: Expense { var serviceType: String; var warrantyMonths: Int?; var nextDueMiles: Int?; var nextDueDate: Date?; @Relationship(deleteRule: .cascade) var items: [MaintenanceItem] = []; init(amount: Decimal, date: Date, mileage: Int, serviceType: String, merchant: Merchant, car: Car) { self.serviceType = serviceType; super.init(amount: amount, date: date, mileage: mileage, merchant: merchant, car: car) } }

@Model
final class MaintenanceItem { var descriptionText: String; var itemType: String; var partNumber: String?; var quantity: Decimal; var unitCost: Decimal; var maintenance: MaintenanceExpense; init(description: String, itemType: String, partNumber: String? = nil, quantity: Decimal, unitCost: Decimal, maintenance: MaintenanceExpense) { self.descriptionText = description; self.itemType = itemType; self.partNumber = partNumber; self.quantity = quantity; self.unitCost = unitCost; self.maintenance = maintenance } }

@Model
final class ParkingExpense: Expense { var parkingFacility: String?; var isStreetMeter: Bool?; var startTime: Date?; var endTime: Date?; var durationMinutes: Int?; var violationIssued: Bool?; var citationNumber: String? }

@Model
final class WindowExpense: Expense { var position: String?; var glassCode: String?; var tintApplied: Bool?; var regulatorReplaced: Bool?; var motorReplaced: Bool?; var installationShop: String? }

@Model
final class CarWashExpense: Expense { var washFacility: String?; var packageName: String?; var includesInterior: Bool?; var includesExterior: Bool? = true; var tipAmount: Decimal? }

@Model
final class TollExpense: Expense { var tollTagId: String? }

@Model
final class FloorMatsExpense: Expense { var matCount: Int?; var material: String?; var isAllWeather: Bool? = true; var color: String?; var rowCoverage: String? }

@Model
final class KeyFobBatteryExpense: Expense { var batteryType: String?; var quantity: Int? }

@Model
final class CarTitleExpense: Expense { var titleNumber: String?; var stateOrProvinceTitle: String?; var lienholder: String?; var issuedOn: Date?; var isDuplicate: Bool? = false }

@Model
final class DriversLicenseExpense: Expense { var licenseNumber: String?; var stateOrProvinceDL: String?; var licenseClass: String?; var endorsements: String?; var restrictions: String?; var issuedOn: Date?; var expiresOn: Date?; var isRealID: Bool? = false }

@Model
final class WiperFluidExpense: Expense { var volume: Decimal?; var unit: String?; var isConcentrate: Bool? = false; var freezeProtectionF: Int?; var scent: String? }
