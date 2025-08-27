import SwiftUI
import SwiftData
import PhotosUI

struct ServiceHistoryView: View {
    @Query(sort: [SortDescriptor<Expense>(\Expense.date, order: .reverse)])
    private var expenses: [Expense]

    @State private var picker: PhotosPickerItem?

    var body: some View {
        VStack(spacing: 0) {
            topBlueBar(title: "Service History")
            List {
                ForEach(expenses, id: \.id) { e in
                    Card {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(e.merchant.name ?? e.merchant.category)
                                .font(.title3).bold()
                            Text(e.date, style: .date)
                                .foregroundStyle(.secondary)
                            Text("Services Completed")
                                .font(.headline)
                            Text(e.notes ?? "—")
                                .foregroundStyle(.secondary)
                            PhotosPicker(selection: $picker, matching: .images) {
                                Label("Upload Receipt", systemImage: "camera")
                                    .font(.headline)
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .background(Color(.systemGroupedBackground))
        }
    }
}
