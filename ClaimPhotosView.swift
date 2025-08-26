
import SwiftUI

struct ClaimPhotosView: View {
    @State private var photos: [Int: UIImage] = [:]
    var body: some View {
        VStack(spacing: 0) {
            topBlueBar(title: "Attach damage photos")
            ZStack {
                RoundedRectangle(cornerRadius: 24).fill(Color(.systemGray6)).frame(height: 380).padding().overlay(Image(systemName: "car.top.door.open.fill").resizable().scaledToFit().padding(60).foregroundStyle(.secondary))
                ForEach(0..<8, id: \.self) { idx in Hotspot(index: idx, image: photos[idx]) { img in photos[idx] = img } }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(.systemGroupedBackground))
            HStack { Spacer(); Button { } label: { Label("Next step", systemImage: "arrow.right") }.buttonStyle(.borderedProminent).padding() }
        }
    }
}
