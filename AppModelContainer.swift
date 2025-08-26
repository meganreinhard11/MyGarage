
import SwiftData

@MainActor
enum AppModelContainer {
    static let shared: ModelContainer = {
        let schema = Schema([
            Address.self, Merchant.self, Car.self,
            Expense.self, FuelExpense.self, RegistrationExpense.self, InsuranceExpense.self,
            InsurancePolicy.self, InsuranceClaim.self, ClaimPhoto.self, PoliceReport.self,
            MileageLog.self,
            BatterySpec.self, BatteryExpense.self,
            TireSpec.self, TireExpense.self,
            WiperStyle.self, WiperSpec.self, WiperExpense.self,
            LightBulbSpec.self, LightBulbExpense.self,
            MaintenanceExpense.self, MaintenanceItem.self,
            ParkingExpense.self, WindowExpense.self, CarWashExpense.self, TollExpense.self,
            FloorMatsExpense.self, KeyFobBatteryExpense.self, CarTitleExpense.self,
            DriversLicenseExpense.self, WiperFluidExpense.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [config])
    }()
}
