
import SwiftUI
import SwiftData

struct ScheduleView: View {
    @Query(sort: [SortDescriptor(\.validTo)]) private var registrations: [RegistrationExpense]
    @Query(sort: [SortDescriptor(\.termEnd)]) private var policyTerms: [InsuranceExpense]
    @Query(sort: [SortDescriptor(\.nextDueDate)]) private var maint: [MaintenanceExpense]

    var body: some View {
        VStack(spacing: 0) {
            topBlueBar(title: "Schedule")
            List {
                Section("Registration") {
                    ForEach(registrations) { r in
                        NavigationLink { RegistrationRecordDetailView(expense: r) } label: { Card { row(title: "Registration (\(r.car.name))", subtitle: r.stateOrProvince, date: r.validTo) } }
                            .listRowSeparator(.hidden).listRowBackground(Color.clear)
                    }
                }
                Section("Insurance") {
                    ForEach(policyTerms) { e in
                        if let policy = e.policy { NavigationLink { PolicyDetailView(policy: policy) } label: { Card { row(title: "Insurance (\(e.car.name))", subtitle: e.coverageType ?? "Policy", date: e.termEnd) } } .listRowSeparator(.hidden).listRowBackground(Color.clear) }
                    }
                }
                Section("Maintenance") {
                    ForEach(maint) { m in
                        NavigationLink { MaintenanceDetailView(expense: m) } label: { Card { row(title: m.serviceType, subtitle: m.car.name, date: m.nextDueDate ?? Date()) } }
                            .listRowSeparator(.hidden).listRowBackground(Color.clear)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .background(Color(.systemGroupedBackground))
        }
    }

    @ViewBuilder private func row(title: String, subtitle: String, date: Date) -> some View {
        HStack { VStack(alignment: .leading, spacing: 6) { Text(title).font(.headline); Text(subtitle).foregroundStyle(.secondary) }; Spacer(); VStack(alignment: .trailing) { Text(date, style: .date).bold(); Text(date, style: .time).foregroundStyle(.secondary) } }
    }
}
