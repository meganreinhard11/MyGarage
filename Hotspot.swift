
import SwiftUI
import PhotosUI

struct Hotspot: View { let index: Int; var image: UIImage?; var onPick: (UIImage) -> Void; @State private var showingPicker = false; var body: some View { Circle().fill(Color(.systemBlue)).frame(width: 44, height: 44).overlay(Image(systemName: image == nil ? "camera" : "checkmark").foregroundStyle(.white)).position(positionFor(index)).onTapGesture { showingPicker = true }.photosPicker(isPresented: $showingPicker, selection: .constant(nil), matching: .images) }
    func positionFor(_ i: Int) -> CGPoint { let center = CGPoint(x: UIScreen.main.bounds.width/2, y: 230); let radius: CGFloat = 150; let angle = CGFloat(i) * (.pi / 4); return CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle)) }
}
