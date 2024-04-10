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

    private let imageView = UIImageView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24.0
        layout.minimumInteritemSpacing = 24.0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
//        collectionView.contentInset = UIEdgeInsets(top: isIpad ? .zero : 12.0, left: .zero, bottom: isIpad ? 24.0 : 12.0, right: .zero)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

private extension HomeViewController {

    func setupView() {
        setupAddSubView()
        setupConstraints()
    }

    func setupAddSubView() {
        
    }

    func setupConstraints() {
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}
