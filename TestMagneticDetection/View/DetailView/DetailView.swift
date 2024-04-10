//
//  DetailView.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 10.04.2024.
//

import Foundation
import UIKit
import Then
import SnapKit

class DetailView: UIView {

    // MARK: - Private UI elements
    private let topStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = .zero
    }
    private let topStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .font(.bold700, 28.0)
    }
    private let bottomStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .font(.regular400, 15.0)
    }
    private let connectInfoView = InfoView()
    private let ipInfoView = InfoView()
    private let macInfoView = InfoView()
    private let hostnameInfoView = InfoView()


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
extension DetailView {

    func configure(model: ResultModel) {
        topStackLabel.text = model.deviceName
        topStackLabel.textColor = model.isConnect ? UIColor.init(hex: "7158DA") : UIColor.init(hex: "ED0018")
        bottomStackLabel.text = model.ipAddress
        connectInfoView.configure(title: "Connection Type", description: model.connectionType)
        ipInfoView.configure(title: "IP Address", description: model.ipAddress)
        macInfoView.configure(title: "MAC Address", description: model.macAddress)
        hostnameInfoView.configure(title: "Hostname", description: model.hostname, is: true)

    }
}

// MARK: - Private methods
private extension DetailView {

    func setupView() {
        setupAddSuview()
        setupConstraints()
        setupSettings()
    }

    func setupAddSuview() {
        topStackView.addArrangedSubview(topStackLabel)
        topStackView.addArrangedSubview(bottomStackLabel)
        [topStackView, connectInfoView, ipInfoView, macInfoView, hostnameInfoView].forEach {
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
        connectInfoView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).inset(-24.0)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        ipInfoView.snp.makeConstraints {
            $0.top.equalTo(connectInfoView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        macInfoView.snp.makeConstraints {
            $0.top.equalTo(ipInfoView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        hostnameInfoView.snp.makeConstraints {
            $0.top.equalTo(macInfoView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48.0)
            $0.bottom.equalToSuperview()
        }
    }

    func setupSettings() {
        backgroundColor = .init(hex: "110D2E")
        layer.cornerRadius = 8.0
    }
}
