//
//  ModeSelectionButton.swift
//  singleton-clean-archi
//
//  Created by Lau on 23/02/2021.
//  Copyright © 2021 Lauriane Haydari. All rights reserved.
//

import UIKit

enum SelectedMode {
    case mode1
    case mode2
    case mode3
}

protocol ModeSelectionDelegate: class {
    func modeSelected(selectedMode: SelectedMode)
}

final class ModeSelectionButton: UIButton {
    
    private let selectedImageView: UIImageView
    var selectedMode: SelectedMode
    weak var modeSelectionDelegate: ModeSelectionDelegate?
    
    
    override var isSelected: Bool {
        didSet {
            self.selectedImageView.isHidden = !isSelected
            if isSelected { self.modeSelectionDelegate?.modeSelected(selectedMode: self.selectedMode) }
        }
    }
    
    init(mode: SelectedMode) {
        selectedImageView = UIImageView()
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.image = UIImage(named: "selection")
        selectedImageView.contentMode = .scaleAspectFit
        
        self.selectedMode = mode
        
        super.init(frame: .zero)
        
        self.addSubview(self.selectedImageView)
        
        selectedImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        selectedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        selectedImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        selectedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        selectedImageView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
