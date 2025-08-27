import SwiftUI
import SwiftData

struct FuelCard: View {
    var item: FuelExpense
    @Query private var siblings: [FuelExpense]

    init(item: FuelExpense) {
        self.item = item
        _siblings = Query(
            filter: #Predicate<FuelExpense> { $0.car == item.car },
            sort: [SortDescriptor<FuelExpense>(\FuelExpense.date)]
        )
    }

    // Compute MPG based on previous fill-up for this car
    var mpg: Double {
        guard let idx = siblings.firstIndex(where: { $0.id == item.id }), idx > 0 else { return 0 }
        let prev = siblings[idx - 1]
        let miles = item.mileage - prev.mileage
        guard miles > 0 else { return 0 }
        return Double(miles) / item.gallons.doubleValue
    }

    // Rough cost per mile since prior entry
    var costPerMile: Double {
        let total = item.amount.doubleValue
        let prevMiles = siblings.last(where: { $0.date < item.date })?.mileage ?? (item.mileage - 1)
        let miles = max(1, item.mileage - prevMiles)
        return total / Double(miles)
    }

    var body: some View {
        Card {
            HStack(alignment: .top, spacing: 12) {
                MerchantAvatar(name: item.merchant.name ?? item.merchant.category)

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(item.date, style: .date).font(.headline)
                        Spacer()
                        Text(MoneyFormatter.currency.string(from: NSDecimalNumber(decimal: item.amount)) ?? "$0.00")
                            .font(.title3).bold()
                    }

                    HStack {
                        Text("\(item.mileage) mi")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Divider().padding(.vertical, 2)

                    // FIX: remove specifier-in-interpolation (only valid for Text),
                    // format with String(format:) instead.
                    LabeledRow(
                        icon: "drop.fill",
                        text: "\(String(format: "%.0f", item.gallons.doubleValue)) gal → \(String(format: "$%.2f", item.unitPrice.doubleValue))/gal"
                    )

                    HStack {
                        LabeledRow(
                            icon: "chart.xyaxis.line",
                            text: String(format: "%.1f mpg", mpg),
                            tint: mpg < 15 ? .red : .green
                        )
                        Spacer()
                        LabeledRow(
                            icon: "dollarsign.circle",
                            text: String(format: "$%.3f/mi", costPerMile)
                        )
                    }

                    LabeledRow(icon: "mappin.and.ellipse", text: item.merchant.name ?? "")
                }
            }
        }
    }
}
