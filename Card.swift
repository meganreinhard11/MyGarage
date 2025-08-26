
import SwiftUI

struct Card<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        VStack(alignment: .leading, spacing: 12) { content }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 18).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4))
    }
}
