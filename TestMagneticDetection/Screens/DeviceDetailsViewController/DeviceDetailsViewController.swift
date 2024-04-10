//
//  DeviceDetailsViewController.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 10.04.2024.
//

import Foundation
import Then
import UIKit
import SnapKit

class DeviceDetailsViewController: UIViewController {

    // MARK: - Private variables
    private var model: ResultModel?

    // MARK: - Private UI elements
    private let topImageView = UIImageView().then {
        $0.image = .deviceDetailsTop
        $0.contentMode = .scaleAspectFill
    }
    private let wifiImageView = UIImageView().then {
        $0.image = .deviceDetailsWifi
        $0.contentMode = .scaleAspectFill
    }
    private let connectWifiImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    private lazy var detailView = DetailView().then {
        guard let model else { fatalError("ResultModel is empty") }

        $0.configure(model: model)
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

// MARK: - Private setup methods
private extension DeviceDetailsViewController {

    func setupView() {
        setupAddSubView()
        setupConstraints()
        setupNavigationController()
        setupSettings()
    }

    func setupAddSubView() {
        topImageView.addSubview(wifiImageView)
        wifiImageView.addSubview(connectWifiImageView)
        [topImageView, detailView].forEach {
            view.addSubview($0)
        }
    }

    func setupConstraints() {
        topImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(329.0)
        }
        wifiImageView.snp.makeConstraints {
            $0.size.equalTo(128.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(78.0)
        }
        connectWifiImageView.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6.0)
        }
        detailView.snp.makeConstraints {
            $0.top.equalTo(topImageView.snp.bottom).inset(50.0)
            $0.height.equalTo(294.0)
            $0.left.right.equalToSuperview().inset(20.0)
        }
    }

    func setupNavigationController() {
        guard let navigationController else { return }

        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = .init(hex: "7158DA")
        navigationItem.title = "Device Details"
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                  .font: UIFont.font(.bold700, 17.0)]
        let backButtonImage = UIImage(named: "back_icon")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButton
    }

    func setupSettings() {
        view.backgroundColor = .init(hex: "070616")
    }
}

// MARK: - Interface methods
extension  DeviceDetailsViewController {

    func configurate(model: ResultModel) {
        connectWifiImageView.image = model.isConnect ? .deviceDetailsConnect : .deviceDetailsError
        self.model = model
    }
}

// MARK: - Objc
@objc extension DeviceDetailsViewController {

    func didTapBackButton() {
        guard let navigationController else { return }

        navigationController.popViewController(animated: true)
    }
}
