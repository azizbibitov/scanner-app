//
//  ExportScreenView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 12.09.2024.
//

import SwiftUI

struct ExportScreenView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var pdfURL: URL?
    @State var images: [UIImage] = (1...7).compactMap { UIImage(named: "images\($0)") }
    @State private var showLoading: Bool = false
    @State private var showShareSheet = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderView(title: "Export")

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 320, height: 450)
                                .cornerRadius(10)
                                .background(Color.white)
                        }
                    }
                    .padding((UIScreen.main.bounds.width - 320)/2)
                    .padding(.top, 10)
                }
                .frame(height: 450)

                Spacer()

                VStack(spacing: 15){
                    Button(action: {
                        coordinator.pop(last: 3)
                    }) {
                        Text("RETAKE")
                    }
                    .buttonStyle(GradientButtonStyle())
                    .padding(.horizontal, 50)

                    Button(action: {
                        if pdfURL == nil {
                            generatePDFAsync()
                        } else {
                            sharePDF()
                        }
                    }) {
                        Text("EXPORT PDF")
                    }
                    .buttonStyle(GradientButtonStyle())
                    .padding(.horizontal, 50)
                    .disabled(showLoading)
                }
            }
        }
        .activityOverlay(isShowing: $showLoading)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showShareSheet) {
            if let url = pdfURL {
                ActivityViewController(activityItems: [url])
            }
        }
    }

    private func generatePDFAsync() {
        showLoading = true
        print("showLoading = true")

        Task {
            if let url = await PDFGenerator.generatePDFAsync(from: images) {
                await MainActor.run {
                    print("generatePDF")
                    self.pdfURL = url
                    self.showLoading = false
                    sharePDF()
                }
            } else {
                await MainActor.run {
                    self.showLoading = false
                    // Handle error here, e.g., show an alert
                }
            }
        }
    }

    private func sharePDF() {
        showShareSheet = true
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}

struct PDFGenerator {
    static func generatePDFAsync(from images: [UIImage]) async -> URL? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let url = self.generatePDF(from: images)
                continuation.resume(returning: url)
            }
        }
    }

    static func generatePDF(from images: [UIImage]) -> URL? {
        let a4Size = CGSize(width: 595, height: 842)
        let tempDir = FileManager.default.temporaryDirectory
        let fileName = "\(UUID().uuidString).pdf"
        let fileURL = tempDir.appendingPathComponent(fileName)

        UIGraphicsBeginPDFContextToFile(fileURL.path, CGRect(origin: .zero, size: a4Size), nil)

        for image in images {
            UIGraphicsBeginPDFPage()
            let imageSize = image.size
            let scaleFactor = min(a4Size.width / imageSize.width, a4Size.height / imageSize.height)
            let scaledSize = CGSize(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
            let x = (a4Size.width - scaledSize.width) / 2
            let y = (a4Size.height - scaledSize.height) / 2
            let rect = CGRect(x: x, y: y, width: scaledSize.width, height: scaledSize.height)
            image.draw(in: rect)
        }

        UIGraphicsEndPDFContext()
        return fileURL
    }
}

#Preview {
    ExportScreenView()
}
