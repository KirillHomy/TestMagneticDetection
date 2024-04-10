//
//  HomeCollectionViewCell.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 09.04.2024.
//

import UIKit

enum HomeType {
    case infrared, bluetooth, magnetic, antispy
}
struct HomeModel {
    let imageSection: UIImage
    let textSection: String
    let typeSection: HomeType
}

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Private UI elements
    private let mainView = UIView().then {
        $0.layer.cornerRadius = 8.0
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(hex: "251663")
    }
    private let homeImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
    }
    private let homeTypeLabel = UILabel().then {
        $0.font = .font(.medium500, 17.0)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(c-oder:) has not been implemented")
    }
}

// MARK: - Interface methods
extension HomeCollectionViewCell {

    func configure(model: HomeModel) {
        homeImageView.image = model.imageSection
        homeTypeLabel.text = model.textSection
    }
}

// MARK: - Setup private methods
private extension HomeCollectionViewCell {

    func setupCell() {
        setupSubviews()
        setupConstraints()
        setupCellSetting()
    }

    func setupSubviews() {
        contentView.addSubview(mainView)
        [homeImageView, homeTypeLabel].forEach {
            mainView.addSubview($0)
        }
    }
    func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        homeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(24.0)
            $0.width.equalToSuperview()
        }
        homeTypeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(homeImageView.snp.bottom).inset(-8.0)
            $0.bottom.equalToSuperview().inset(24.0)
            $0.width.equalToSuperview()
        }
    }

    func setupCellSetting() {
        self.contentView.backgroundColor = .clear
    }
}
