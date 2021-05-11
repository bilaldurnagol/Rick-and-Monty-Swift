//
//  UIButton+Extensions.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import UIKit

class IconTextButton: UIButton {
    
    private let buttonText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let buttonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonText)
        addSubview(buttonIcon)
        clipsToBounds = true
        layer.cornerRadius = 10.0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, icon: UIImage) {
        buttonText.text = text
        buttonIcon.image = icon
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonText.sizeToFit()
        let iconSize: CGFloat = 30.0
        buttonIcon.frame = CGRect(x: frame.width - iconSize - 30, y: (frame.size.height - iconSize)/2, width: iconSize, height: iconSize)
        buttonText.frame = CGRect(x: 30, y: 0, width: buttonText.frame.size.width, height: frame.size.height)
    }
}
