//
//  ViewController.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import UIKit
import SnapKit

class CharactersViewController: UIViewController {
    
    
    private var collectionView: UICollectionView?
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    //setup large navigation bar
    private func setupNavBar() {
         navigationItem.largeTitleDisplayMode = .always
         navigationController?.navigationBar.prefersLargeTitles = true
         title = "Characters"
    }
    
    private func setupCollectionView() {
        // setup collection view
        collectionView?.backgroundColor = .systemBackground
        
        layout.itemSize = CGSize(
            width: view.width/2,
            height: (view.height - view.safeAreaInsets.top)/3
        )
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView?.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier
        )
        guard let collectionView = collectionView else {return}
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        cell.backgroundColor = .clear
        return cell
    }
}
