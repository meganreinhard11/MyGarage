
import SwiftUI

struct MoneyFormatter {
    static let currency: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.maximumFractionDigits = 2
        return f
    }()
}

extension Decimal { var doubleValue: Double { NSDecimalNumber(decimal: self).doubleValue } }

extension View {
    func topBlueBar(title: String, showsAdd: Bool = false, onAdd: (() -> Void)? = nil) -> some View {
        VStack(spacing: 0) {
            ZStack {
                Color("TopBarBlue").ignoresSafeArea(edges: .top)
                HStack {
                    Image(systemName: "line.3.horizontal").font(.title3).foregroundStyle(.white)
                    Spacer()
                    Text(title).font(.title3).bold().foregroundStyle(.white)
                    Spacer()
                    if showsAdd, let onAdd { Button(action: onAdd) { Image(systemName: "plus").font(.title3).foregroundStyle(.white) } } else { Image(systemName: "bell.slash").opacity(0) }
                }
                .padding(.horizontal)
                .frame(height: 56)
            }
        }
    }
}
