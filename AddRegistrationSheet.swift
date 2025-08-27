import SwiftUI
import SwiftData

struct AddRegistrationSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var ctx

    var defaultCar: Car?
    @Query(sort: [SortDescriptor<Car>(\Car.name, order: .forward)]) private var cars: [Car]
    @State private var selectedCar: Car?

    @State private var stateOrProv: String = "OH"
    @State private var validFrom: Date = .now
    @State private var validTo: Date = Calendar.current.date(byAdding: .year, value: 1, to: .now)!
    @State private var mileage: String = ""
    @State private var amount: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Picker("Car", selection: $selectedCar) {
                    ForEach(cars) { car in
                        Text(car.name).tag(Optional(car))
                    }
                }
                TextField("State / Province", text: $stateOrProv)
                DatePicker("Valid From", selection: $validFrom, displayedComponents: .date)
                DatePicker("Valid To", selection: $validTo, displayedComponents: .date)
                TextField("Mileage", text: $mileage).keyboardType(.numberPad)
                DecimalField(title: "Amount ($)", value: $amount)
            }
            .navigationTitle("Add Registration")
            .onAppear { selectedCar = defaultCar ?? cars.first }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) { Button("Save") { save() } }
            }
        }
    }

    private func save() {
        guard let car = selectedCar else { return }
        let merchant = Merchant(category: "DMV", name: "Ohio Motor Vehicle Dept.")
        let amountDec = Decimal(string: amount) ?? 0
        let mileageInt = Int(mileage) ?? 0
    
        // Use the parent initializer, then set subclass props
        let e = RegistrationExpense(
            amount: amountDec,
            date: validFrom,
            mileage: mileageInt,
            merchant: merchant,
            car: car
        )
        e.stateOrProvince = stateOrProv
        e.validFrom = validFrom
        e.validTo = validTo
    
        ctx.insert(merchant)
        ctx.insert(e)
        try? ctx.save()
        dismiss()
    }
}

#Preview("Add Registration") {
    let car: Car = PreviewSampleData.first(Car.self)
    return AddRegistrationSheet(defaultCar: car)
        .modelContainer(PreviewSampleData.container)
}
