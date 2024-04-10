//
//  HomeViewController.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 09.04.2024.
//

import Foundation
import Then
import UIKit
import SnapKit

class HomeViewController: UIViewController {

    // MARK: - Private variables
    private var homeModel: [HomeModel] = []

    // MARK: - Private UI elements
    private let imageView = UIImageView().then {
        $0.image = .homeTop
        $0.contentMode = .scaleAspectFill
    }
    private lazy var scanView = HomeScanView().then {
        $0.didTapScanButton(self, action: #selector(didTapScanButton), for: .touchUpInside)
    }
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 36.0
        layout.minimumInteritemSpacing = 36.0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 1.0, right: 16.0)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

// MARK: - Private setup methods
private extension HomeViewController {

    func setupView() {
        setupAddSubView()
        setupConstraints()
        setupHomeModel()
        setupNavigationController()
        setupSettings()
    }

    func setupAddSubView() {
        [imageView, scanView, collectionView].forEach {
            view.addSubview($0)
        }
    }

    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(329.0)
        }
        scanView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(50.0)
            $0.height.equalTo(198.0)
            $0.left.right.equalToSuperview().inset(20.0)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(scanView.snp.bottom).inset(-16.0)
            $0.left.right.equalToSuperview().inset(36.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupHomeModel() {
        homeModel.append(HomeModel(imageSection: .homeInfraredIcon, textSection: "Infrared\nDetection", typeSection: .infrared))
        homeModel.append(HomeModel(imageSection: .homeBluetoothIcon, textSection: "Bluetooth\nDetection", typeSection: .bluetooth))
        homeModel.append(HomeModel(imageSection: .homeMagneticIcon, textSection: "Magnetic\nDetection", typeSection: .magnetic))
        homeModel.append(HomeModel(imageSection: .homeAntispyIcon, textSection: "Antispy\nTips", typeSection: .antispy))
    }

    func setupNavigationController() {
        guard let navigationController else { return }

        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .homeRightBarButtonIcon,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRightBarButtonItem))
        let backButton = UIBarButtonItem()
        backButton.title = "Main"
        navigationItem.backBarButtonItem = backButton
    }

    func setupSettings() {
        view.backgroundColor = .init(hex: "070616")
    }
}

// MARK: - Objc
@objc extension HomeViewController {

    func didTapScanButton() {
        guard let navigationController else { return }

        navigationController.pushViewController(ScanNetworkViewController(), animated: true)
    }

    func didTapRightBarButtonItem() {
        print("print didTapRightBarButtonItem")
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Unable to dequeue HomeCollectionViewCell")
        }
        cell.configure(model: homeModel[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch homeModel[indexPath.row].typeSection {
        case .infrared:
            print("print infrared")
        case .bluetooth:
            print("print bluetooth")
        case .magnetic:
            guard let navigationController else { return }

            navigationController.pushViewController(MagneticDetectionViewController(), animated: true)
        case .antispy:
            print("print antispy")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140.0, height: 140.0)
    }
}
