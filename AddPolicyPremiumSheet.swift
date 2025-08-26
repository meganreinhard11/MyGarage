
import SwiftUI
import SwiftData

struct AddPolicyPremiumSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var ctx

    let policy: InsurancePolicy
    @State private var amount: String = ""
    @State private var date: Date = .now
    @State private var mileage: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Text("Policy: \(policy.policyNumber)")
                DecimalField(title: "Amount ($)", value: $amount)
                DatePicker("Term Start", selection: $date, displayedComponents: .date)
                DatePicker("Term End", selection: .constant(Calendar.current.date(byAdding: .year, value: 1, to: date) ?? date), displayedComponents: .date).disabled(true)
                TextField("Mileage", text: $mileage).keyboardType(.numberPad)
            }
            .navigationTitle("Add Premium")
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Save") { save() } } ; ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } } }
        }
    }

    private func save() {
        guard let car = policy.cars.first else { return }
        let merchant = policy.merchant
        let amt = Decimal(string: amount) ?? 0
        let mil = Int(mileage) ?? 0
        let start = date
        let end = Calendar.current.date(byAdding: .year, value: 1, to: start)!
        let premium = InsuranceExpense(amount: amt, date: start, mileage: mil, coverageType: "Full", deductible: 500, termStart: start, termEnd: end, paidInFull: true, policy: policy, merchant: merchant, car: car)
        ctx.insert(premium)
        try? ctx.save(); dismiss()
    }
}
