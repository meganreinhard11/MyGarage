
import SwiftUI
import SwiftData

struct TiresView: View {
    @Query private var specs: [TireSpec]
    @State private var selected: TireSpec?
    @State private var diameter = 16
    @State private var ratio = 50
    @State private var width = 205

    var body: some View {
        ScrollView { VStack(spacing: 16) {
            topBlueBar(title: "Tires")
            TireProductCard(title: (selected?.brand ?? "Michelin") + " " + (selected?.model ?? "X-ICE X13"))
                .padding(.horizontal)
            Card { Text("Choose Tire Size").font(.headline); HStack { Picker("Width", selection: $width) { ForEach([195, 205, 215, 225, 235], id: \.self) { Text("\($0)") } }.pickerStyle(.menu); Picker("Ratio", selection: $ratio) { ForEach([35, 40, 45, 50, 55], id: \.self) { Text("\($0)") } }.pickerStyle(.menu); Picker("Diameter", selection: $diameter) { ForEach([16, 17, 18, 19, 20], id: \.self) { Text("\($0)") } }.pickerStyle(.menu) } }.padding(.horizontal) }
        }.background(Color(.systemGroupedBackground))
    }
}
