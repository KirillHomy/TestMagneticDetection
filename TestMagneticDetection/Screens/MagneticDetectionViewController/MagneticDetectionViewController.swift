//
//  MagneticDetectionViewController.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 08.04.2024.
//

import UIKit
import SnapKit
import Then

class MagneticDetectionViewController: UIViewController {

    // MARK: - Private UI elements
    private let magneticTopImageView = UIImageView().then {
        $0.image = .magneticTop
        $0.contentMode = .scaleAspectFill
    }
    private let speedometerView = SpeedometerView()
    private let startButton = UIButton().then {
        $0.backgroundColor = .init(hex: "7158DA")
        $0.layer.cornerRadius = 25.0
        $0.titleLabel?.font = .font(.bold700, 20.0)
        $0.setTitle("Search", for: .normal)
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            UIView.animate(withDuration: 1) {
//                self.gaudeView.value = 0
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            UIView.animate(withDuration: 1) {
//                self.gaudeView.value = 50
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            UIView.animate(withDuration: 1) {
//                self.gaudeView.value = 100
//            }
//        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        gaudeView.drawTriangles()
//    }
}

private extension MagneticDetectionViewController {

    func setupView() {
        setupAddSubview()
        setupConstraints()
        setupNavigationController()
        setupViewSettings()
    }

    func setupAddSubview() {
        view.addSubview(magneticTopImageView)
        view.addSubview(speedometerView)
        view.addSubview(startButton)
    }

    func setupConstraints() {
        magneticTopImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(329.0)
        }
        speedometerView.snp.makeConstraints {
            $0.top.equalTo(magneticTopImageView.snp.bottom).inset(-62.0)
            $0.size.equalTo(view.snp.width)
        }
        startButton.snp.makeConstraints {
            $0.height.equalTo(50.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(70.0)
        }
    }

    func setupNavigationController() {
        guard let navigationController else { return }

        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = UIColor(hex: "7158D8")
        navigationItem.title = "Magnetic Detection"
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func setupViewSettings() {
        view.backgroundColor = .init(hex: "070616")
    }
}
