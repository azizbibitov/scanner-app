//
//  CameraScreenView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import Foundation
import SwiftUI
import AVFoundation

struct CameraScreenView: View {

    @StateObject var viewModel = CameraViewModel()
    @EnvironmentObject var coordinator: Coordinator

    @State private var isFocused = false
    @State private var isScaled = false
    @State private var focusLocation: CGPoint = .zero
    @State private var currentZoomFactor: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            viewModel.switchFlash()
                        }, label: {
                            Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                .font(.system(size: 20, weight: .medium, design: .default))
                        })
                        .accentColor(viewModel.isFlashOn ? .yellow : .white)
                        Spacer()
                    }
                    .padding(.horizontal)

                    ZStack {
                        CameraPreview(session: viewModel.session) { tapPoint in
                            isFocused = true
                            focusLocation = tapPoint
                            viewModel.setFocus(point: tapPoint)
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        } onDoubleTap: {
//                            viewModel.switchCamera()
                        }
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                self.currentZoomFactor += value - 1.0 // Calculate the zoom factor change
                                self.currentZoomFactor = min(max(self.currentZoomFactor, 0.5), 10)
                                self.viewModel.zoom(with: currentZoomFactor)
                            })
                        //                        .animation(.easeInOut, value: 0.5)

                        if isFocused {
                            FocusView(position: $focusLocation)
                                .scaleEffect(isScaled ? 0.8 : 1)
                                .onAppear {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                                        self.isScaled = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            self.isFocused = false
                                            self.isScaled = false
                                        }
                                    }
                                }
                        }
                    }

                    HStack {
//                        CameraSwitchButton { viewModel.switchCamera() }
                        PhotoThumbnail(image: $viewModel.capturedImage)
                        Spacer()
                        CaptureButton { viewModel.captureImage() }
                        Spacer()
                        Button {
//                            var flippedImages: [UIImage] = []
//                            viewModel.capturedImages.forEach { picture in
//                                var flippedImage = UIImage(cgImage: picture.cgImage!, scale: picture.scale, orientation: .leftMirrored)
//                                flippedImages.append(flippedImage)
//                            }

                            coordinator.navigateTo(page: .crop(images: viewModel.capturedImages))
                        } label: {
                            Text("NEXT")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }

                    }
                    .padding(20)
                }
            }
            .alert(isPresented: $viewModel.showAlertError) {
                Alert(title: Text(viewModel.alertError.title), message: Text(viewModel.alertError.message), dismissButton: .default(Text(viewModel.alertError.primaryButtonTitle), action: {
                    viewModel.alertError.primaryAction?()
                }))
            }
            .alert(isPresented: $viewModel.showSettingAlert) {
                Alert(title: Text("Warning"), message: Text("Application doesn't have all permissions to use camera and microphone, please change privacy settings."), dismissButton: .default(Text("Go to settings"), action: {
                    self.openSettings()
                }))
            }
            .onAppear {
                viewModel.setupBindings()
                viewModel.requestCameraPermission()
                if !viewModel.capturedImages.isEmpty {
                    viewModel.capturedImages.removeAll()
                    viewModel.cameraManager.capturedImages.removeAll()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }

    func openSettings() {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)
        if let url = settingsUrl {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

struct PhotoThumbnail: View {
    @Binding var image: UIImage?

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            } else {
                Rectangle()
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.black)
            }
        }
    }
}

struct CameraSwitchButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        }
    }
}

struct FocusView: View {

    @Binding var position: CGPoint

    var body: some View {
        Circle()
            .frame(width: 70, height: 70)
            .foregroundColor(.clear)
            .border(Color.yellow, width: 1.5)
            .position(x: position.x, y: position.y)
    }
}
