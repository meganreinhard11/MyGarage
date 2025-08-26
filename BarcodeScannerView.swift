
import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewRepresentable {
    @Binding var torchOn: Bool
    var onCode: (String) -> Void
    func makeUIView(context: Context) -> UIView { let view = UIView(); let session = AVCaptureSession(); context.coordinator.session = session; guard let device = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: device) else { return view }; if session.canAddInput(input) { session.addInput(input) }; let output = AVCaptureMetadataOutput(); if session.canAddOutput(output) { session.addOutput(output); output.setMetadataObjectsDelegate(context.coordinator, queue: .main); output.metadataObjectTypes = [.code39, .code39Mod43, .code128, .qr] }; let preview = AVCaptureVideoPreviewLayer(session: session); preview.videoGravity = .resizeAspectFill; preview.frame = view.layer.bounds; view.layer.addSublayer(preview); session.startRunning(); return view }
    func updateUIView(_ uiView: UIView, context: Context) { guard let device = AVCaptureDevice.default(for: .video) else { return }; try? device.lockForConfiguration(); device.torchMode = torchOn && device.hasTorch ? .on : .off; device.unlockForConfiguration() }
    func makeCoordinator() -> Coordinator { Coordinator(onCode: onCode) }
    final class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate { var onCode: (String) -> Void; weak var session: AVCaptureSession?; init(onCode: @escaping (String) -> Void) { self.onCode = onCode } ; func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) { guard let obj = metadataObjects.first as? AVMetadataMachineReadableCodeObject, let str = obj.stringValue else { return }; onCode(str) } }
}
