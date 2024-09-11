//
//  CropScreenView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import SwiftUI
import UIKit
import EasyPeasy

struct CropScreenView: SwiftUI.View {
    @EnvironmentObject var coordinator: Coordinator
    var images: [UIImage] = (1...7).compactMap { UIImage(named: "images\($0)") }
    @StateObject var viewModel = CropScreenViewModel()

    var body: some SwiftUI.View {
        ZStack {
            VStack(spacing: 0) {
                HeaderView(title: "Crop")
                CropScreenVCRepresentable(images: images, viewModel: viewModel)

                Spacer()

                Button(action: {
                    viewModel.cropImages { croppedImages in
                        coordinator.navigateTo(page: .filter(images: croppedImages))
                    }
                }) {
                    Text("NEXT")
                }
                .buttonStyle(GradientButtonStyle())
                .padding(.horizontal, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

class CropScreenViewController: UIViewController {

    var images: [UIImage]
    let viewModel: CropScreenViewModel

    init(images: [UIImage], viewModel: CropScreenViewModel) {
        self.images = images
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset.left = (view.bounds.width - 320)/2
        return scrollView
    }()

    var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        self.view.addSubview(scrollView)
        scrollView.easy.layout([
            Leading(), Trailing(), Top(10), Height(450), Width(view.bounds.width)
        ])

        scrollView.addSubview(hStack)
        hStack.easy.layout(Edges())
        images.forEach { image in
            let cropContainerView = UIView()
            cropContainerView.backgroundColor = .red
            cropContainerView.easy.layout([Width(320), Height(450)])

            let cropPickerView = CropPickerView()
            cropPickerView.backgroundColor = .black
            cropContainerView.addSubview(cropPickerView)
            cropPickerView.easy.layout(Edges())

            DispatchQueue.main.async {
                cropPickerView.image(image)
            }
            viewModel.cropViews.append(cropPickerView)
            hStack.addArrangedSubview(cropContainerView)
        }
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

#Preview(body: {
    CropScreenView()
})
