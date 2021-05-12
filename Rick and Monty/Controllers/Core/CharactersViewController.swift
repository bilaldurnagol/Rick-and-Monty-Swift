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
    private var characterListViewModel: CharacterListViewModel!
    
    private let alert = CustomAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        configure()
  
        APICaller.shared.getCharacters(completion: {[weak self] result in
            switch result {
            case .failure(_):
                self?.alert.showAlert(
                    with: "Characters Not Fetched",
                    message: "Check your internet connection and try again later. If there is a problem, we are trying to solve it.",
                    on: self!)
            case .success(let characters):
                self?.characterListViewModel = CharacterListViewModel(characters: characters)
                DispatchQueue.main.async {
                    if characters.isEmpty {
                        self?.emptyLabel.isHidden = false
                    } else {
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
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
    }
    // setup collection view
    private func setupCollectionView() {
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
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    private func configure() {
        view.addSubview(spinner)
        view.addSubview(emptyLabel)
    }
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.characterListViewModel == nil ? 0: self.characterListViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characterListViewModel.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        
        let characterViewModel = self.characterListViewModel.characterAtIndex(indexPath.row)
        
        cell.configure(with: characterViewModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
       let id = self.characterListViewModel.characterAtIndex(indexPath.row).id
        let vc = CharacterDetailsViewController(id: id)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true)
    }
}
