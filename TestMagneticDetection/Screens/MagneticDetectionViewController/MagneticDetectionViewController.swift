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

    // MARK: - Private property
    private var timer: Timer?
    private var isStart = true
    
    // MARK: - Private UI elements
    private let magneticTopImageView = UIImageView().then {
        $0.image = .magneticTop
        $0.contentMode = .scaleAspectFill
    }
    private let speedometerView = SpeedometerView()
    private lazy var startButton = UIButton().then {
        $0.backgroundColor = .init(hex: "7158DA")
        $0.layer.cornerRadius = 25.0
        $0.titleLabel?.font = .font(.bold700, 20.0)
        $0.setTitle("Search", for: .normal)
        $0.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    private let testLabel = UILabel().then {
        $0.text = "Search checking"
        $0.font = .font(.medium500, 17.0)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

// MARK: - Private methods
private extension MagneticDetectionViewController {

    func setupView() {
        setupAddSubview()
        setupConstraints()
        setupNavigationController()
        setupViewSettings()
    }

    func setupAddSubview() {
        [magneticTopImageView, speedometerView, startButton, testLabel].forEach {
            view.addSubview($0)
        }
    }

    func setupConstraints() {
        magneticTopImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(329.0)
        }
        speedometerView.snp.makeConstraints {
            $0.top.equalTo(magneticTopImageView.snp.bottom).inset(UIScreen.main.bounds.height <= 667 ? 0.0 : -62.0)
            $0.size.equalTo(view.snp.width)
        }
        startButton.snp.makeConstraints {
            $0.height.equalTo(50.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height <= 667 ? 0.05 * view.bounds.height : 70.0)
        }
        testLabel.snp.makeConstraints {
            $0.width.equalTo(120.0)
            $0.height.equalTo(20.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startButton.snp.top).inset(UIScreen.main.bounds.height <= 667 ? -15.0 : -87.0)
        }
    }

    func setupNavigationController() {
        guard let navigationController else { return }

        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = UIColor(hex: "7158D8")
        navigationItem.title = "Magnetic Detection"
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                  .font: UIFont.font(.bold700, 17.0)]
    }

    func setupViewSettings() {
        view.backgroundColor = .init(hex: "070616")
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateValue), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.stopTimer()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        self.speedometerView.value = 0
        testLabel.text = "Search checking"
        startButton.setTitle("Search", for: .normal)
    }
}

// MARK: - Objc
@objc extension MagneticDetectionViewController {

    func updateValue() {
        let randomValue = CGFloat(arc4random_uniform(101))
        speedometerView.value = Int(randomValue)
        testLabel.text = "\(randomValue) µT"
    }

    func didTapStartButton() {
        isStart.toggle()
        if isStart {
            stopTimer()
            startButton.setTitle("Search", for: .normal)
        } else {
            startTimer()
        }
        startButton.setTitle(isStart ? "Search" : "Stop", for: .normal)
        testLabel.text = isStart ? "Search checking" : "0 µT"
    }
}
