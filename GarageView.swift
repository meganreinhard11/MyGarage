
import SwiftUI
import SwiftData

struct GarageView: View {
    @Environment(\.modelContext) private var ctx
    @Query(sort: [SortDescriptor(\.name)]) private var cars: [Car]
    @State private var showingAdd = false

    var body: some View {
        VStack(spacing: 0) {
            topBlueBar(title: "Garage", showsAdd: true) { showingAdd = true }
            if cars.isEmpty { InitialGarageEmpty() } else {
                List {
                    ForEach(cars, id: \.id) { car in
                        NavigationLink { FuelLogView(car: car) } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray5)).frame(width: 72, height: 42).overlay(Image(systemName: "car.side.fill").foregroundStyle(.secondary))
                                Text(car.name).font(.headline)
                                Spacer(); Image(systemName: "chevron.right").foregroundStyle(.tertiary)
                            }.padding(.vertical, 6)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingAdd) { AddCarSheet() }
    }
}

private struct InitialGarageEmpty: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "car.fill").font(.system(size: 64)).foregroundStyle(.secondary)
            Text("Add a car to your garage.").font(.title3).bold()
            Text("Track your car’s service history, open recalls and service schedule all in one place.")
                .multilineTextAlignment(.center).foregroundStyle(.secondary).padding(.horizontal)
            Button("Add a Car"){}.buttonStyle(.borderedProminent).padding(.horizontal)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(.systemGroupedBackground))
    }
}
