import SwiftData
import Foundation

@MainActor
func seedIfNeeded() async {
    let context = ModelContext(AppModelContainer.shared)

    let carsReq = FetchDescriptor<Car>()
    if let count = try? context.fetchCount(carsReq), count > 0 { return }

    let costco  = Merchant(category: "Gas",      name: "Costco Gasoline")
    let sunoco  = Merchant(category: "Gas",      name: "Sunoco")
    let bp      = Merchant(category: "Gas",      name: "BP - Dublin")
    let dmv     = Merchant(category: "DMV",      name: "Ohio Motor Vehicle Dept.")
    let insurer = Merchant(category: "Insurance",name: "Allied Insurance")

    let car = Car(name: "2016 Honda Accord Ex-L", licensePlate: "")
    
    let merchants: [Merchant] = [costco, sunoco, bp, dmv, insurer]
    merchants.forEach { context.insert($0) }
    context.insert(car)

    let f1 = FuelExpense(amount: 3,   date: .now.addingTimeInterval(-3600*24),    mileage: 9000, gallons: 20, unitPrice: 0.15, merchant: sunoco, car: car)
    let f2 = FuelExpense(amount: 15,  date: .now.addingTimeInterval(-3600*24-1),  mileage: 8888, gallons: 3,  unitPrice: 5,    merchant: costco, car: car)
    let f3 = FuelExpense(amount: 1000,date: .now.addingTimeInterval(-3600*24*3),  mileage: 2220, gallons: 20, unitPrice: 50,   merchant: bp,     car: car)

    let reg = RegistrationExpense(
        amount: 75,
        date: Date(timeIntervalSinceNow: -3600*24*90),
        mileage: 69616,
        stateOrProvince: "OH",
        validFrom: Date(timeIntervalSinceNow: -3600*24*100),
        validTo: Calendar.current.date(byAdding: .year, value: 1, to: Date())!,
        merchant: dmv,
        car: car
    )

    let policy = InsurancePolicy(policyNumber: "POL-12345", merchant: insurer)
    policy.cars.append(car)
    context.insert(policy)

    let premium = InsuranceExpense(
        amount: 450,
        date: Date(timeIntervalSinceNow: -3600*24*30),
        mileage: 69000,
        coverageType: "Full",
        deductible: 500,
        termStart: Date(timeIntervalSinceNow: -3600*24*30),
        termEnd: Calendar.current.date(byAdding: .year, value: 1, to: Date())!,
        paidInFull: true,
        policy: policy,
        merchant: insurer,
        car: car
    )

    let maint = MaintenanceExpense(amount: 120, date: .now.addingTimeInterval(-3600*24*40), mileage: 68000, serviceType: "Oil Change", merchant: bp, car: car)
    maint.nextDueDate  = Calendar.current.date(byAdding: .month, value: 6, to: Date())
    maint.nextDueMiles = 72000
    let item = MaintenanceItem(description: "Full Synthetic 0W-20", itemType: "Part", quantity: 1, unitCost: 75, maintenance: maint)
    maint.items.append(item)

    let expenses: [Expense] = [f1, f2, f3, reg, premium, maint]
    expenses.forEach { context.insert($0) }

    try? context.save()
}
