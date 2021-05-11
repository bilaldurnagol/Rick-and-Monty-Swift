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
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .large
        spinner.color = .label
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "We couldn't find any characters."
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.isHidden = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private var characters: Characters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        view.addSubview(spinner)
        view.addSubview(emptyLabel)
        
        APICaller.shared.getCharacters(completion: {[weak self]result in
            switch result {
            case .failure(let error): print(error)
            case .success(let characters):
                DispatchQueue.main.async {
                    if characters.results.isEmpty {
                        self?.emptyLabel.isHidden = false
                    } else {
                        self?.characters = characters
                        self?.collectionView?.reloadData()
                        self?.spinner.stopAnimating()
                        self?.collectionView?.isHidden = false
                    }
                    
                }
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        spinner.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    //MARK: - Configure
    
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
        collectionView.isHidden = true
        view.addSubview(collectionView)
    }
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        let character = characters?.results[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}
