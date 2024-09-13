//
//  CameraPreview.swift
//  CustomCameraApp
//
//  Created by Amisha Italiya on 03/10/23.
//

import SwiftUI
import Photos
import AVFoundation // To access the camera related swift classes and methods

struct CameraPreview: UIViewRepresentable { // for attaching AVCaptureVideoPreviewLayer to SwiftUI View
	
	let session: AVCaptureSession
	var onTap: (CGPoint) -> Void
    var onDoubleTap: () -> Void

	func makeUIView(context: Context) -> VideoPreviewView {
		let view = VideoPreviewView()
		view.backgroundColor = .black
		view.videoPreviewLayer.session = session
		view.videoPreviewLayer.videoGravity = .resizeAspect
		view.videoPreviewLayer.connection?.videoOrientation = .portrait
		
		// Add a tap gesture recognizer to the view
		let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTapGesture(_:)))
		view.addGestureRecognizer(tapGesture)

        let doubleTapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleDoubleTapGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
		return view
	}
	
	public func updateUIView(_ uiView: VideoPreviewView, context: Context) { }
	
	class VideoPreviewView: UIView {
		override class var layerClass: AnyClass {
			 AVCaptureVideoPreviewLayer.self
		}
		
		var videoPreviewLayer: AVCaptureVideoPreviewLayer {
			return layer as! AVCaptureVideoPreviewLayer
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject {
		
		var parent: CameraPreview
		
		init(_ parent: CameraPreview) {
			self.parent = parent
		}
		
		@objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
			let location = sender.location(in: sender.view)
			parent.onTap(location)
		}

        @objc func handleDoubleTapGesture(_ sender: UITapGestureRecognizer) {
            parent.onDoubleTap()
        }
	}
}
