import SwiftUI
import SwiftData

struct RegistrationView: View {
    @Query(
        sort: [SortDescriptor<RegistrationExpense>(\RegistrationExpense.date, order: .reverse)]
    ) private var regs: [RegistrationExpense]
    @State private var showAdd = false

    var body: some View {
        VStack(spacing: 0) {
            topBlueBar(title: "Registration", showsAdd: true) { showAdd = true }
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let latest = regs.first {
                        Card {
                            Text("Since Last Registration").font(.headline)
                            let monthsLeft = monthsUntil(latest.validTo)
                            ProgressView(value: Double(12 - monthsLeft), total: 12)
                            HStack { Text("Time Elapsed"); Spacer(); Text("\(12 - monthsLeft) Months") }
                                .foregroundStyle(.secondary)
                            HStack { Text("REGISTRATION INTERVAL"); Spacer(); Text("1 year") }
                                .font(.subheadline).foregroundStyle(.secondary)
                            NavigationLink("+ Add Registration Record") {
                                AddRegistrationSheet(defaultCar: latest.car)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        Card {
                            Text("Next Registration").font(.title3).bold()
                            Text(latest.validTo, style: .date)
                            NavigationLink("Renew Registration") { RegistrationRecordDetailView(expense: latest) }
                                .buttonStyle(.borderedProminent)
                        }
                    } else {
                        Text("No registration records yet").padding()
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
        .sheet(isPresented: $showAdd) { AddRegistrationSheet(defaultCar: nil) }
    }

    private func monthsUntil(_ date: Date) -> Int {
        let cal = Calendar.current
        let comps = cal.dateComponents([.month], from: Date(), to: date)
        return max(0, comps.month ?? 0)
    }
}
