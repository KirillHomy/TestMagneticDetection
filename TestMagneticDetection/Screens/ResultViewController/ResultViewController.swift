//
//  ResultViewController.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 10.04.2024.
//

import Foundation
import Then
import UIKit
import SnapKit

class ResultViewController: UIViewController {

    // MARK: - Private variables
    private var resultModel: [ResultModel] = []

    // MARK: - Private UI elements
    private let resultDeviceStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5.0
    }
    private let resultDeviceNumberStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hex: "7158DA")
        $0.font = .font(.bold700, 28.0)
        $0.text = "5"
    }
    private let resultDeviceTextStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .font(.bold700, 28.0)
        $0.text = "Devices"
    }
    private let resultStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = .zero
    }
    private let resulWifiStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hex: "525878")
        $0.font = .font(.regular400, 15.0)
        $0.text = "WIFI_Name"
    }
    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.register(ResultTableViewCell.self, forCellReuseIdentifier: "ResultTableViewCell")
        $0.layer.cornerRadius = 8.0
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

// MARK: - Private setup methods
private extension ResultViewController {

    func setupView() {
        setupAddSubView()
        setupConstraints()
        setupResultModel()
        setupNavigationController()
        setupSettings()
    }

    func setupAddSubView() {
        resultDeviceStackView.addArrangedSubview(resultDeviceNumberStackLabel)
        resultDeviceStackView.addArrangedSubview(resultDeviceTextStackLabel)
        resultStackView.addArrangedSubview(resultDeviceStackView)
        resultStackView.addArrangedSubview(resulWifiStackLabel)
        view.addSubview(resultStackView)
        view.addSubview(tableView)
    }

    func setupConstraints() {
        resultStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(54.0)
            $0.width.equalTo(130.0)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(resultStackView.snp.bottom).inset(-32.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
    }

    func setupResultModel() {
        resultModel.append(ResultModel(networkDeviceName: "-", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "MacTick-a123", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: false))
        resultModel.append(ResultModel(networkDeviceName: "Phone", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Ms_12k", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: false))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
        resultModel.append(ResultModel(networkDeviceName: "Router Traplun", ipAddress: "192.168.1.1", deviceName: "Camera", connectionType: "Wifi", macAddress: "Not Available", hostname: "gwpc-21141234.local", isConnect: true))
    }

    func setupNavigationController() {
        guard let navigationController = navigationController else { return }
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = .init(hex: "7158DA")
        navigationItem.title = "Result"
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

// MARK: - Objc
@objc extension ResultViewController {

    func didTapBackButton() {
        if let targetViewController = navigationController?.viewControllers.dropLast().dropLast().last {
            navigationController?.popToViewController(targetViewController, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension ResultViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DeviceDetailsViewController()
        let item = resultModel[indexPath.row]
        viewController.configurate(model: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        let lastItemIndexPath = IndexPath(row: tableView.numberOfRows(inSection: indexPath.section) - 1, section: indexPath.section)
        cell.configure(model: resultModel[indexPath.row], is: indexPath == lastItemIndexPath)
        return cell
    }
}
