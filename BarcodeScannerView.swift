import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewRepresentable {
    @Binding var torchOn: Bool
    var onCode: (String) -> Void

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        // ✅ Skip live camera in previews
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            let label = UILabel()
            label.text = "Camera preview placeholder"
            label.textColor = .white
            label.textAlignment = .center
            label.backgroundColor = .darkGray
            label.layer.cornerRadius = 12
            label.clipsToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            return view
        }

        let session = AVCaptureSession()
        context.coordinator.session = session
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return view }
        if session.canAddInput(input) { session.addInput(input) }
        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(context.coordinator, queue: .main)
            output.metadataObjectTypes = [.code39, .code39Mod43, .code128, .qr]
        }
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        preview.frame = view.layer.bounds
        view.layer.addSublayer(preview)
        session.startRunning()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) { /* no-op for previews */ }

    func makeCoordinator() -> Coordinator { Coordinator(onCode: onCode) }

    final class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var onCode: (String) -> Void; weak var session: AVCaptureSession?
        init(onCode: @escaping (String) -> Void) { self.onCode = onCode }
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let obj = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
                  let str = obj.stringValue else { return }
            onCode(str)
        }
    }
}
