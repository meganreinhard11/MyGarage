
import SwiftUI

struct LabeledRow: View {
    var icon: String; var text: String; var trailing: String? = nil; var tint: Color = .secondary
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon).foregroundStyle(tint)
            Text(text)
            Spacer()
            if let trailing { Text(trailing).foregroundStyle(.secondary) }
        }.font(.subheadline)
    }
}
