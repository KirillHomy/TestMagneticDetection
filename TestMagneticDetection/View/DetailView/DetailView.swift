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
        $0.textColor = .white
        $0.font = .font(.bold700, 28.0)
        $0.text = "Current Wi-Fi"
    }
    private let bottomStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hex: "7158DA")
        $0.font = .font(.regular400, 15.0)
        $0.text = "WIFI_Name"
    }
    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
        $0.layer.cornerRadius = 8.0
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
extension DetailView {

    func didTapScanButton(_ targget: Any?, action: Selector, for event: UIControl.Event) {
//        scanButton.addTarget(targget, action: action, for: event)
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
        [topStackView, tableView].forEach {
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
        tableView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).inset(-24.0)
            $0.left.right.bottom.equalToSuperview()
        }
    }

    func setupSettings() {
        backgroundColor = .init(hex: "110D2E")
        layer.cornerRadius = 8.0
    }
}

// MARK: - UITableViewDelegate
extension DetailView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
}

// MARK: - UITableViewDataSource
extension DetailView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        let lastItemIndexPath = IndexPath(row: tableView.numberOfRows(inSection: indexPath.section) - 1, section: indexPath.section)
        cell.configure(model: resultModel[indexPath.row], is: indexPath == lastItemIndexPath)
        return cell
    }
}

