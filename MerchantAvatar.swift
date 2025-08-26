
import SwiftUI

struct MerchantAvatar: View {
    var name: String
    var body: some View {
        ZStack { Circle().fill(Color(.systemGray6)); Text(String(name.prefix(1))).bold().foregroundStyle(.secondary) }
            .frame(width: 52, height: 52)
    }
}
