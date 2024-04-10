//
//  ResultTableViewCell.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 10.04.2024.
//

import Foundation
import SnapKit
import UIKit
import Then

struct ResultModel {
    let networkDeviceName: String
    let ipAddress: String
    let deviceName: String
    let connectionType: String
    let macAddress: String
    let hostname: String
    var isConnect: Bool
}

class ResultTableViewCell: UITableViewCell {

    // MARK: - Private UI constants
    private let wifiImageView = UIImageView().then {
        $0.image = .resultWifiIcon
        $0.contentMode = .scaleAspectFit
    }
    private let wifiErrorImageView = UIImageView().then {
        $0.image = .resultWifiErrorIcon
        $0.contentMode = .scaleAspectFit
    } 
    private let titleLabel = UILabel().then {
        $0.font = .font(.medium500, 17.0)
        $0.textColor = .white
    }
    private let descriptionLabel = UILabel().then {
        $0.font = .font(.medium500, 13.0)
        $0.textColor = .init(hex: "525878")
    }
    private let nextImageView = UIImageView().then {
        $0.image = .resultNextIcon
        $0.contentMode = .scaleAspectFit
    }
    private let underLineView = UIView().then {
        $0.backgroundColor = .init(hex: "51587B")
    }

    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Interface methods
extension ResultTableViewCell {

    func configure(model: ResultModel, is hidden: Bool) {
        titleLabel.text = model.networkDeviceName
        descriptionLabel.text = model.ipAddress
        wifiErrorImageView.image = model.isConnect ? UIImage() : .resultWifiErrorIcon
        underLineView.isHidden = hidden
    }
}

// MARK: - Setup private methods
private extension ResultTableViewCell {

    func setupCell() {
        setupSubviews()
        setupConstraints()
        setupCellSetting()
    }

    func setupSubviews() {
        wifiImageView.addSubview(wifiErrorImageView)
        [wifiImageView, titleLabel, descriptionLabel, nextImageView, underLineView].forEach {
            contentView.addSubview($0)
        }
    }

    func setupConstraints() {
        wifiImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview().inset(7.0)
            $0.size.equalTo(36.0)
        }
        wifiErrorImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3.0)
            $0.trailing.equalToSuperview().inset(-2.0)
            $0.size.equalTo(12.0)
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(wifiImageView.snp.right).inset(-16.0)
            $0.top.equalToSuperview().inset(7.0)
            $0.height.equalTo(20.0)
            $0.right.equalTo(nextImageView.snp.left)
        }
        descriptionLabel.snp.makeConstraints {
            $0.left.equalTo(wifiImageView.snp.right).inset(-16.0)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(7.0)
            $0.height.equalTo(20.0)
            $0.right.equalTo(nextImageView.snp.left)
        }
        nextImageView.snp.makeConstraints {
            $0.height.equalTo(16.0)
            $0.width.equalTo(9.0)
            $0.top.bottom.equalToSuperview().inset(19.0)
            $0.right.equalToSuperview().inset(16.0)
        }
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }

    func setupCellSetting() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .init(hex: "110D2E")
    }
}
