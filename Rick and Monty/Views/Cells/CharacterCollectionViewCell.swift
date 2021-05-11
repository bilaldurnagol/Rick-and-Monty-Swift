//
//  CharacterCollectionViewCell.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import UIKit
import SnapKit


class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharacterCollectionViewCell"
    
    private let characterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Bilal Durnagöl"
        label.font = UIFont(name: "SFProText-Bold", size: 18)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(characterImageView)
        addSubview(nameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(
                UIEdgeInsets(
                    top: 0, left: 20, bottom: 0, right: 10
                )
            )
            make.height.equalToSuperview().multipliedBy(0.80)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }
}
