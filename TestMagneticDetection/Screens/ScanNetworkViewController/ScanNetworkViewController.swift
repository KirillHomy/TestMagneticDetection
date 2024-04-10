//
//  ScanNetworkViewController.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 10.04.2024.
//

import Foundation
import Then
import UIKit
import SnapKit
import Lottie

class ScanNetworkViewController: UIViewController {

    // MARK: - Private property
    private var timer: Timer?
    private var count = 0

    // MARK: - Private UI elements
    private let topStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = .zero
    }
    private let topStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .font(.regular400, 15.0)
        $0.text = "Scanning Your Wi-Fi"
    }
    private let bottomStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hex: "7158DA")
        $0.font = .font(.bold700, 28.0)
        $0.text = "TLind_246_lp"
    }
    private let animationView = LottieAnimationView(name: "scan").then {
        $0.animationSpeed = 0.5
        $0.loopMode = .loop
        $0.play()
    }
    private let descriptionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = .zero
    }
    private let descriptionNumberStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hex: "7158DA")
        $0.font = .font(.bold700, 28.0)
        $0.text = "23"
    }
    private let descriptionTextStackLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .font(.regular400, 15.0)
        $0.text = "Devices Found..."
    }
    private lazy var stopButton = UIButton().then {
        $0.backgroundColor = .init(hex: "7158DA")
        $0.layer.cornerRadius = 25.0
        $0.titleLabel?.font = .font(.bold700, 20.0)
        $0.setTitle("Stop", for: .normal)
        $0.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
    }
    private let procentLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "0 %"
        $0.font = .font(.bold700, 15)
        $0.textAlignment = .center
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.hidesBackButton = true
    }
}

// MARK: - Private setup methods
private extension ScanNetworkViewController {

    func setupView() {
        setupAddSubView()
        setupConstraints()
        setupSettings()
        startTimer()
    }

    func setupAddSubView() {
        topStackView.addArrangedSubview(topStackLabel)
        topStackView.addArrangedSubview(bottomStackLabel)
        view.addSubview(topStackView)
        view.addSubview(animationView)
        descriptionStackView.addArrangedSubview(descriptionNumberStackLabel)
        descriptionStackView.addArrangedSubview(descriptionTextStackLabel)
        view.addSubview(descriptionStackView)
        view.addSubview(stopButton)
        animationView.addSubview(procentLabel)
    }

    func setupConstraints() {
        topStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(37.0)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20.0)
            $0.height.equalTo(54.0)
        }
        animationView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).inset(-0.1 * view.bounds.height)
            $0.height.equalTo(0.4 * view.bounds.height)
            $0.width.equalTo(0.9 * view.bounds.width)
            $0.centerX.equalToSuperview()
        }
        descriptionStackView.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).inset(-38.0)
            $0.width.equalTo(150.0)
            $0.centerX.equalToSuperview()
        }
        stopButton.snp.makeConstraints {
            $0.height.equalTo(50.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height <= 667 ? 0.05 * view.bounds.height : 70.0)
        }
        procentLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100.0)
        }
    }

    func setupSettings() {
        view.backgroundColor = .init(hex: "070616")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.navigationController?.pushViewController(ResultViewController(), animated: true)
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCount), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.stopTimer()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Objc
@objc extension ScanNetworkViewController {

    func updateCount() {
        count += 20
        procentLabel.text = "\(count) %"
    }

    func didTapStopButton() {
        guard let navigationController else { return }

        navigationController.popViewController(animated: true)
    }
}
