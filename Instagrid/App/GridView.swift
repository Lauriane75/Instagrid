//
//  GridView.swift
//  singleton-clean-archi
//
//  Created by Lau on 23/02/2021.
//  Copyright © 2021 Lauriane Haydari. All rights reserved.
//

import UIKit

final class GrideView: UIView, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - Properties

    var mode: SelectedMode? = nil
    
    private let button1: UIButton
    private let button2: UIButton
    private let button3: UIButton
    private let button4: UIButton
    let stackView: UIStackView
    let upStackView: UIStackView
    let downStackView: UIStackView

    var buttons: [UIButton] {
        return [button1, button2, button3, button4]
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
                
        button1 = UIButton()
        button1.setImage(UIImage(named: "plus"), for: .normal)
        button1.imageView?.contentMode = .scaleAspectFit
        
        button2 = UIButton()
        button2.setImage(UIImage(named: "plus"), for: .normal)

        button3 = UIButton()
        button3.setImage(UIImage(named: "plus"), for: .normal)
        button3.imageView?.contentMode = .scaleAspectFit
        
        button4 = UIButton()
        button4.setImage(UIImage(named: "plus"), for: .normal)

        upStackView = UIStackView(arrangedSubviews: [button1, button2])
        upStackView.spacing = 8
        upStackView.axis = .horizontal
        upStackView.distribution = .fillEqually
        
        downStackView = UIStackView(arrangedSubviews: [button3, button4])
        downStackView.spacing = 8
        downStackView.axis = .horizontal
        downStackView.distribution = .fillEqually
        
        stackView = UIStackView(arrangedSubviews: [upStackView, downStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor(named: "dark-blue")
        self.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func update(_ mode: SelectedMode) {
        self.mode = mode
        self.buttons.forEach { $0.isHidden = false }
        self.button2.isHidden = mode == .mode1
        self.button4.isHidden = mode == .mode2
        
        if mode == .mode1 {
            upStackView.backgroundColor = UIColor(named: "white-gray")
            downStackView.backgroundColor = .clear
        }
        if mode == .mode2 {
            upStackView.backgroundColor = .clear
            downStackView.backgroundColor = UIColor(named: "white-gray")
        }
        if mode == .mode3 {
            upStackView.backgroundColor = .clear
            downStackView.backgroundColor = .clear
        }
    }
}
// j'ai un doute est ce aque je dois mettre cette fonction ici ou dans mno vcl ?
//func checkForSwipe(viewController: ViewController) {
//    let alert = Alert()
//    if mode == .first {
//        if firtButton.image(for: .normal) != UIImage(named: "plus") &&
//            thirdButton.image(for: .normal) != UIImage(named: "plus") &&
//            fourthButton.image(for: .normal) != UIImage(named: "plus") {
//            print("OK")
//        } else {
//            alert.missingImage(viewController: viewController)
//        }
//    }
//    if mode == .second {
//        if firtButton.image(for: .normal) != UIImage(named: "plus") &&
//            secondButton.image(for: .normal) != UIImage(named: "plus") &&
//            thirdButton.image(for: .normal) != UIImage(named: "plus") {
//            print("OK")
//        } else {
//            alert.missingImage(viewController: viewController)
//        }
//    }
//    if mode == .third {
//        if firtButton.image(for: .normal) != UIImage(named: "plus") &&
//            secondButton.image(for: .normal) != UIImage(named: "plus") &&
//            thirdButton.image(for: .normal) != UIImage(named: "plus") &&
//            fourthButton.image(for: .normal) != UIImage(named: "plus") {
//            print("OK")
//        } else {
//            alert.missingImage(viewController: viewController)
//        }
//    }
//}
