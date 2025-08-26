
import SwiftUI

struct RootTabs: View {
    var body: some View {
        TabView {
            GarageView().tabItem { Label("Dashboard", systemImage: "gauge.with.dots.needle.67percent") }
            ServiceHistoryView().tabItem { Label("Service", systemImage: "wrench.and.screwdriver") }
            ScheduleView().tabItem { Label("Schedule", systemImage: "calendar") }
            FuelLogView().tabItem { Label("Costs", systemImage: "dollarsign.square") }
            TiresView().tabItem { Label("Shops", systemImage: "car.rear.waves.up") }
        }.tint(Color("TopBarBlue"))
    }
}
