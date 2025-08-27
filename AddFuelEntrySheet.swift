import SwiftUI
import SwiftData

struct AddFuelEntrySheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var ctx

    let car: Car

    @State private var merchantName: String = ""
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
                    TextField("Mileage", text: $mileage)
                        .keyboardType(.numberPad)
                }
                Section("Fuel") {
                    DecimalField(title: "Gallons", value: $gallons)
                    DecimalField(title: "Unit Price ($/gal)", value: $unitPrice)
                    DecimalField(title: "Amount ($)", value: $amount)
                        .onChange(of: (gallons, unitPrice), initial: true) { _, new in
                            let (gStr, pStr) = new
                            if let g = Decimal(string: gStr), let p = Decimal(string: pStr) {
                                amount = NSDecimalNumber(decimal: g * p).stringValue
                            } else {
                                amount = ""
                            }
                        }
                }
            }
            .navigationTitle("Add Fuel")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                }
            }
        }
    }

    private func save() {
        let m = Merchant(category: "Gas", name: merchantName)
        let mileageInt = Int(mileage) ?? 0
        let g = Decimal(string: gallons) ?? 0
        let p = Decimal(string: unitPrice) ?? 0
        // If user overwrote amount, respect it; otherwise derive it from g * p
        let a = Decimal(string: amount) ?? (g * p)

        let e = FuelExpense(
            amount: a,
            date: date,
            mileage: mileageInt,
            gallons: g,
            unitPrice: p,
            merchant: m,
            car: car
        )

        // Insert models individually (no insert(contentsOf:))
        ctx.insert(m)
        ctx.insert(e)

        try? ctx.save()
        dismiss()
    }
}
