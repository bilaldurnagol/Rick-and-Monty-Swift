//
//  CharacterDetailsViewController.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import UIKit
import SnapKit

class CharacterDetailsViewController: UIViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .large
        spinner.color = .label
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 45
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var episodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Episodes", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 8.0
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 18,bottom: 0,right: 0)
        button.tintColor = .label
        return button
    }()
    
    private let episodeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 8.0
        tableView.separatorStyle = .none
        tableView.isHidden = true
        return tableView
    }()
    
    private var isClicked = false
    private var characterViewModel: CharacterViewModel!
    private var eposideListViewModel: EposideListViewModel!
    private var alert = CustomAlert()
    
    private var id: Int?
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        APICaller.shared.getCharacterDetails(with: id!, completion: {[weak self] result in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self?.characterViewModel = CharacterViewModel(character)
                    self?.configure(with: self?.characterViewModel)
                    APICaller.shared.getEposide(with: self?.characterViewModel.episode, completion: {eposides in
                        DispatchQueue.main.async {
                            self?.eposideListViewModel = EposideListViewModel(eposides: eposides)
                            self?.episodeTableView.reloadData()
                            self?.spinner.stopAnimating()
                        }
                    })
                }
            case .failure(_):
                self?.alert.showAlert(
                    with: "Character Details Not Fetched",
                    message: "Check your internet connection and try again later. If there is a problem, we are trying to solve it.",
                    on: self!)
                
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20.5)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(26)
        }
        characterImageView.snp.makeConstraints{ make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.height.width.equalTo(90)
        }
        speciesLabel.snp.makeConstraints{ make in
            make.leading.equalTo(characterImageView.snp.trailing).offset(18)
            make.top.equalTo(nameLabel.snp.bottom).offset(43)
        }
        
        genderLabel.snp.makeConstraints{ make in
            make.leading.equalTo(characterImageView.snp.trailing).offset(18)
            make.top.equalTo(speciesLabel.snp.bottom).offset(14)
        }
        episodeButton.snp.makeConstraints{ make in
            make.top.equalTo(characterImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        episodeTableView.snp.makeConstraints{ make in
            make.top.equalTo(episodeButton.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(280)
        }
        spinner.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        episodeButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: (episodeButton.bounds.width - 35), bottom: 5, right: 5)
        episodeButton.addTarget(self, action: #selector(didTapDropDownButton), for: .touchUpInside)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        spinner.startAnimating()
        view.addSubview(nameLabel)
        view.addSubview(genderLabel)
        view.addSubview(speciesLabel)
        view.addSubview(characterImageView)
        view.addSubview(episodeButton)
        view.addSubview(episodeTableView)
        view.addSubview(spinner)
        
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
    }
    
    private func configure(with character: CharacterViewModel?) {
        guard let character = character else {return}
        nameLabel.text = character.name
        speciesLabel.text = "\(character.species), \(character.status)"
        genderLabel.text = character.gender
        characterImageView.sd_setImage(with: URL(string: character.imageURL), completed: nil)
        episodeTableView.reloadData()
    }
    
    //MARK: - objc
    
    @objc private func didTapDone() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDropDownButton() {
        if isClicked {
            UIView.animate(withDuration: 0.3) {
                self.episodeTableView.isHidden = true
                self.isClicked = false
                self.episodeButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.episodeTableView.isHidden = false
                self.isClicked = true
                self.episodeButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            }
        }
    }
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eposideListViewModel == nil ? 0: self.eposideListViewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eposideListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let eposide = eposideListViewModel.characterAtIndex(indexPath.row)
        cell.textLabel?.text = eposide.eposideName
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
