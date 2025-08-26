
import SwiftUI

struct RegistrationRecordDetailView: View {
    let expense: RegistrationExpense
    var body: some View {
        ScrollView { VStack(alignment: .leading, spacing: 16) { topBlueBar(title: "Registration Detail"); Card { Text(expense.car.name).font(.headline); LabeledRow(icon: "calendar", text: "Valid From", trailing: expense.validFrom.formatted(date: .abbreviated, time: .omitted)); LabeledRow(icon: "calendar", text: "Valid To", trailing: expense.validTo.formatted(date: .abbreviated, time: .omitted)); LabeledRow(icon: "dollarsign.circle", text: "Amount", trailing: MoneyFormatter.currency.string(from: NSDecimalNumber(decimal: expense.amount)) ?? "") ; Button("Renew Registration") {}.buttonStyle(.borderedProminent) } } .padding(.horizontal) }.background(Color(.systemGroupedBackground))
    }
}
