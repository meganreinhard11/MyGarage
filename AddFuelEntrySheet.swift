
import SwiftUI
import SwiftData

struct AddFuelEntrySheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var ctx

    let car: Car

    @State private var merchantName: String = "Costco Gasoline"
    @State private var date: Date = .now
    @State private var mileage: String = ""
    @State private var gallons: String = ""
    @State private var unitPrice: String = ""
    @State private var amount: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Basics") {
                    TextField("Merchant", text: $merchantName)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Odometer", text: $mileage).keyboardType(.numberPad)
                }
                Section("Fuel") {
                    DecimalField(title: "Gallons", value: $gallons)
                    DecimalField(title: "Unit Price ($/gal)", value: $unitPrice)
                    DecimalField(title: "Amount ($)", value: $amount)
                        .onChange(of: gallons + unitPrice) { _ in
                            if let g = Decimal(string: gallons), let p = Decimal(string: unitPrice) {
                                amount = NSDecimalNumber(decimal: g * p).stringValue
                            }
                        }
                }
            }
            .navigationTitle("Add Fuel")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel", action: { dismiss() }) }
                ToolbarItem(placement: .confirmationAction) { Button("Save") { save() } }
            }
        }
    }

    private func save() {
        let m = Merchant(category: "Gas", name: merchantName)
        let mileageInt = Int(mileage) ?? 0
        let g = Decimal(string: gallons) ?? 0
        let p = Decimal(string: unitPrice) ?? 0
        let a = Decimal(string: amount).map { $0 } ?? (g * p)
        let e = FuelExpense(amount: a, date: date, mileage: mileageInt, gallons: g, unitPrice: p, merchant: m, car: car)
        ctx.insert(contentsOf: [m, e])
        try? ctx.save(); dismiss()
    }
}
