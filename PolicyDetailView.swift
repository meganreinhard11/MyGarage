
import SwiftUI
import SwiftData

struct PolicyDetailView: View {
    var policy: InsurancePolicy
    @Query private var relatedExpenses: [InsuranceExpense]
    @Query private var claims: [InsuranceClaim]
    @State private var showAdd = false

    init(policy: InsurancePolicy) {
        self.policy = policy
        _relatedExpenses = Query(filter: #Predicate<InsuranceExpense> { $0.policy == policy }, sort: [SortDescriptor(\.termEnd, order: .reverse)])
        _claims = Query(filter: #Predicate<InsuranceClaim> { $0.policy == policy }, sort: [SortDescriptor(\.incidentDate, order: .reverse)])
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                topBlueBar(title: "Policy \(policy.policyNumber)", showsAdd: true) { showAdd = true }
                Card { Text(policy.merchant.name ?? "Insurer").font(.title3).bold(); Text("Covers: \(policy.cars.map{ $0.name }.joined(separator: ", "))").foregroundStyle(.secondary) }
                Card { Text("Terms").font(.headline); ForEach(relatedExpenses, id: \.id) { e in HStack { Text(e.termStart, style: .date); Image(systemName: "arrow.right"); Text(e.termEnd, style: .date); Spacer(); Text(MoneyFormatter.currency.string(from: NSDecimalNumber(decimal: e.amount)) ?? ""); } } }
                Card { Text("Claims").font(.headline); if claims.isEmpty { Text("No claims").foregroundStyle(.secondary) } else { ForEach(claims, id: \.self) { c in VStack(alignment: .leading) { Text("#\(c.claimNumber ?? "—")").bold(); Text(c.incidentDate ?? .now, style: .date).foregroundStyle(.secondary); Divider() } } } }
            }.padding(.horizontal)
        }.background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showAdd) { AddPolicyPremiumSheet(policy: policy) }
    }
}
