
import SwiftUI
import SwiftData

struct FuelLogView: View {
    @Environment(\.modelContext) private var ctx
    var car: Car?
    @Query private var allFuel: [FuelExpense]
    @State private var showAdd = false

    init(car: Car? = nil) {
        self.car = car
        if let car { _allFuel = Query(filter: #Predicate<FuelExpense> { $0.car == car }, sort: [SortDescriptor(\.date, order: .reverse)]) }
        else { _allFuel = Query(sort: [SortDescriptor(\.date, order: .reverse)]) }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                topBlueBar(title: "Fuel Log", showsAdd: car != nil) { showAdd = true }
                List { ForEach(allFuel, id: \.id) { FuelCard(item: $0).listRowSeparator(.hidden).listRowBackground(Color.clear) } }
                    .listStyle(.plain)
                    .background(Color(.systemGroupedBackground))
            }
        }
        .sheet(isPresented: $showAdd) { if let car { AddFuelEntrySheet(car: car) } }
    }
}
