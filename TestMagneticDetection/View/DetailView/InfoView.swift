//
//  InfoView.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 10.04.2024.
//

import Foundation
import UIKit
import Then
import SnapKit

class InfoView: UIView {

    // MARK: - Private UI elements
    private let infoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    private let titleLabel = UILabel().then {
        $0.font = .font(.regular400, 17.0)
        $0.textAlignment = .left
        $0.textColor = .white
    }
    private let descriptionLabel = UILabel().then {
        $0.font = .font(.regular400, 17.0)
        $0.textAlignment = .right
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .init(hex: "525878")
    }
    private let underLineView = UIView().then {
        $0.backgroundColor = .init(hex: "4A5073")
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
extension InfoView {

    func configure(title: String, description: String, is hidden: Bool = false) {
        titleLabel.text = title
        descriptionLabel.text = description
        underLineView.isHidden = hidden
    }
}

// MARK: - Private methods
private extension InfoView {

    func setupView() {
        setupAddSuview()
        setupConstraints()
    }

    func setupAddSuview() {
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(descriptionLabel)
        addSubview(infoStackView)
        addSubview(underLineView)
    }

    func setupConstraints() {
        infoStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(1.0)
        }
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
}
