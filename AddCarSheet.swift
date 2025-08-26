
import SwiftUI
import SwiftData

struct AddCarSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var ctx
    @State private var name = "2016 Honda Accord Ex-L"
    @State private var plate = ""

    var body: some View {
        NavigationStack {
            Form { TextField("Name", text: $name); TextField("License Plate", text: $plate) }
                .navigationTitle("Add Car")
                .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Save") { let car = Car(name: name, licensePlate: plate.isEmpty ? nil : plate); ctx.insert(car); try? ctx.save(); dismiss() } } }
        }
    }
}
