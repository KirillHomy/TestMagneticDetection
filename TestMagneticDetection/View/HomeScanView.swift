//
//  HomeScanView.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 10.04.2024.
//

import Foundation
import UIKit
import Then
import SnapKit

class HomeScanView: UIView {

    // MARK: - Private UI elements
    private let topStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = .zero
    }
    private let topStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .font(.regular400, 15.0)
        $0.text = "Current Wi-Fi"
    }
    private let bottomStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hex: "7158DA")
        $0.font = .font(.bold700, 28.0)
        $0.text = "WIFI_Name"
    }
    private let descriptionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hex: "51587B")
        $0.font = .font(.regular400, 17.0)
        $0.text = "Ready to Scan this network"
    }
    private let scanButton = UIButton().then {
        $0.backgroundColor = .init(hex: "7158DA")
        $0.layer.cornerRadius = 25.0
        $0.titleLabel?.font = .font(.bold700, 20.0)
        $0.setTitle("Scan current network", for: .normal)
    }

    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Interface methods
extension HomeScanView {

    func didTapScanButton(_ targget: Any?, action: Selector, for event: UIControl.Event) {
        scanButton.addTarget(targget, action: action, for: event)
    }
}

// MARK: - Private methods
private extension HomeScanView {

    func setupView() {
        setupAddSuview()
        setupConstraints()
        setupSettings()
    }

    func setupAddSuview() {
        topStackView.addArrangedSubview(topStackLabel)
        topStackView.addArrangedSubview(bottomStackLabel)
        [topStackView, descriptionLabel, scanButton].forEach {
            addSubview($0)
        }
    }

    func setupConstraints() {
        topStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(54.0)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).inset(-16.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        scanButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(24.0)
            $0.height.equalTo(50.0)
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-8.0)
        }
    }

    func setupSettings() {
        backgroundColor = .init(hex: "110D2E")
        layer.cornerRadius = 8.0
    }
}
