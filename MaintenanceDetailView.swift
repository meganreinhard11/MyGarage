
import SwiftUI

struct MaintenanceDetailView: View {
    let expense: MaintenanceExpense
    var body: some View {
        ScrollView { VStack(spacing: 16) { topBlueBar(title: expense.serviceType); Card { LabeledRow(icon: "car", text: expense.car.name); if let miles = expense.nextDueMiles { LabeledRow(icon: "speedometer", text: "Next due miles", trailing: "\(miles)") }; if let next = expense.nextDueDate { LabeledRow(icon: "calendar", text: "Next due date", trailing: next.formatted(date: .abbreviated, time: .omitted)) }; Divider(); ForEach(expense.items) { item in HStack { Text(item.descriptionText); Spacer(); Text(MoneyFormatter.currency.string(from: NSDecimalNumber(decimal: item.unitCost * item.quantity)) ?? "") } } } }.padding(.horizontal) }.background(Color(.systemGroupedBackground))
    }
}
