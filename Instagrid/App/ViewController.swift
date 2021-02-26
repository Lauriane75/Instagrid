//
//  ViewController.swift
//  singleton-clean-archi
//
//  Created by Lauriane Haydari on 25/06/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ModeSelectionDelegate {
    
    func modeSelected(selectedMode: SelectedMode) {
        self.gridView.update(selectedMode)
    }
    
    // MARK: - Outlets
    
    private let titleLabel: UILabel
    private let arrowImageView: UIImageView
    private let swipeLabel: UILabel
    
    private let gridView: GrideView
    
    private let modeSelectionStackView: UIStackView
    private let firstModeButton: ModeSelectionButton
    private let secondModeButton: ModeSelectionButton
    private let thirdModeButton: ModeSelectionButton
    
    private var buttons: [ModeSelectionButton] {
        return [firstModeButton,secondModeButton,thirdModeButton]
    }
    
    // MARK: - Properties
    
    var button: UIButton? = nil
    
    var swipe: UISwipeGestureRecognizer!
    
    private struct Constants {
        static let thirstySoftRegular = UIFont(name: "ThirstySoftRegular", size: 52)
        static let delmMedium = UIFont(name: "Delm-Medium", size: 30)
    }
    
    // MARK: - Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.titleLabel = CustomLabel(title: "Instagrid", color: .white, textFont: Constants.thirstySoftRegular!)
        
        self.arrowImageView = UIImageView(image: UIImage(named: "arrow-up"))
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false

        self.swipeLabel = CustomLabel(title: "Swipe up to share", color: .white, textFont: Constants.delmMedium!)
        
        self.gridView = GrideView()
        
        self.modeSelectionStackView = UIStackView()
        
        self.modeSelectionStackView.translatesAutoresizingMaskIntoConstraints = false
        self.modeSelectionStackView.axis = .horizontal
        self.modeSelectionStackView.distribution = .equalSpacing
        self.modeSelectionStackView.alignment = .center
        
        self.firstModeButton = ModeSelectionButton(mode: .mode1)
        firstModeButton.translatesAutoresizingMaskIntoConstraints = false
        firstModeButton.setImage(UIImage(named: "selected-1"), for: .normal)
        
        self.secondModeButton = ModeSelectionButton(mode: .mode2)
        secondModeButton.translatesAutoresizingMaskIntoConstraints = false
        secondModeButton.setImage(UIImage(named: "selected-2"), for: .normal)
        
        self.thirdModeButton = ModeSelectionButton(mode: .mode3)
        thirdModeButton.translatesAutoresizingMaskIntoConstraints = false
        thirdModeButton.setImage(UIImage(named: "selected-3"), for: .normal)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipe.direction = .up
        
        self.buttons.forEach { button in
            self.modeSelectionStackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(didSelectMode), for: .touchUpInside)
            button.modeSelectionDelegate = self
        }
        
        self.gridView.buttons.forEach { (button) in
            button.addTarget(self, action: #selector(didPressAddPhoto), for: .touchUpInside)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttons[2].isSelected = true
    
        view.backgroundColor = UIColor(named: "light-blue")
        
        view.addSubview(titleLabel)
        view.addSubview(arrowImageView)
        
        view.addSubview(swipeLabel)
        
        view.addSubview(gridView)
        view.addSubview(modeSelectionStackView)
        view.addGestureRecognizer(swipe)
        
        // MARK: - Constraints
        
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        self.arrowImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        self.arrowImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.arrowImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02).isActive = true
        self.arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor, multiplier: 1.4).isActive = true
        
        self.swipeLabel.topAnchor.constraint(equalTo: arrowImageView.bottomAnchor, constant: 10).isActive = true
        self.swipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.swipeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
        self.gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.gridView.topAnchor.constraint(equalTo: swipeLabel.bottomAnchor, constant: 20).isActive = true
        self.gridView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.42).isActive = true
        self.gridView.widthAnchor.constraint(equalTo: gridView.heightAnchor).isActive = true
        
        let centerYmodeSelectionStackView = (view.frame.height/4) / 2
        
        self.modeSelectionStackView.centerYAnchor.constraint(equalTo: gridView.bottomAnchor, constant: centerYmodeSelectionStackView).isActive = true
        self.modeSelectionStackView.widthAnchor.constraint(equalTo: gridView.widthAnchor, multiplier: 0.9).isActive = true
        self.modeSelectionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.modeSelectionStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let buttonWidth = (view.frame.width/3) - 40
        
        self.firstModeButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        self.firstModeButton.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        
        self.secondModeButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        self.secondModeButton.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        
        self.thirdModeButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        self.thirdModeButton.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        
    }
    
    @objc private func handleGesture() {
        swipeAnimation()
        checkForSwipe()
    }
    
    @objc func didSelectMode(_ button: UIButton) {
        self.buttons.forEach { $0.isSelected = $0 == button }
    }
    
    @objc func didPressAddPhoto(_ button: UIButton) {
        addPhoto(button: button)
    }
    
    // MARK: - Private Functions
    
    private func animationDone() {
         UIView.animate(withDuration: 0.8,
                        delay: 0,
                        usingSpringWithDamping: 0.5,
                        initialSpringVelocity: 0.5,
                        options: [],
                        animations: {
                         self.gridView.transform = .identity
         } , completion: nil )
     }
     
     private func swipeAnimation() {
         let swipePortrait = CGAffineTransform(translationX: 0, y: -self.view.frame.height * 0.3)
             UIView.animate(withDuration: 0.4, animations: {
                 self.gridView.transform = swipePortrait
             }) { [self] (success) in
                 if (success) {
                     animationDone()
             }
         }
     }
    
    fileprivate func mergeImages() -> UIImage? {
        
        let mode = gridView.mode
        
        let widthImage = gridView.frame.size.width
        let heightImage = gridView.frame.size.height * 2
        
        let topLeftImage = gridView.buttons[0].image(for: .normal)
        let topRightImage = gridView.buttons[1].image(for: .normal)
        let bottomLeftImage = gridView.buttons[2].image(for: .normal)
        let bottomRightImage = gridView.buttons[3].image(for: .normal)

        
        let width = widthImage / 2
        let height = heightImage / 2
        
        let size = CGSize(width: widthImage, height: heightImage)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        if mode == .mode1 {
            topLeftImage!.draw(in: CGRect(x:0, y: 0, width: widthImage, height: height))
            bottomLeftImage!.draw(in: CGRect(x: 0, y: height, width: width, height: height))
            bottomRightImage!.draw(in: CGRect(x: width, y: height, width: width, height: height))
        } else if mode == .mode2 {
            topLeftImage!.draw(in: CGRect(x:0, y: 0, width: width, height: height))
            topRightImage!.draw(in: CGRect(x: width, y: 0, width: width, height: height))
            bottomLeftImage!.draw(in: CGRect(x: 0, y: height, width: widthImage, height: height))
        } else if mode == .mode3 {
            topLeftImage!.draw(in: CGRect(x:0, y: 0, width: width, height: height))
            topRightImage!.draw(in: CGRect(x: width, y: 0, width: width, height: height))
            bottomLeftImage!.draw(in: CGRect(x: 0, y: height, width: width, height: height))
            bottomRightImage!.draw(in: CGRect(x: width, y: height, width: width, height: height))
        }
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    fileprivate func presentUiActivityController(finalPhoto: UIImage) {
        let uiActivityController = UIActivityViewController(activityItems: [finalPhoto] as [Any], applicationActivities: nil)
        present(uiActivityController, animated: true)
    }

    
    func checkForSwipe() {
        let mode = gridView.mode
        let firtButton = gridView.buttons[0]
        let secondButton = gridView.buttons[1]
        let thirdButton = gridView.buttons[2]
        let fourthButton = gridView.buttons[3]

        let alert = Alert()
        if mode == .mode1 {
            if firtButton.image(for: .normal) != UIImage(named: "plus") &&
                thirdButton.image(for: .normal) != UIImage(named: "plus") &&
                fourthButton.image(for: .normal) != UIImage(named: "plus") {
                print("OK")
                guard let image = mergeImages() else { return }
                presentUiActivityController(finalPhoto: image)
            } else {
                alert.missingImage(viewController: self)
            }
        }
        if mode == .mode2 {
            if firtButton.image(for: .normal) != UIImage(named: "plus") &&
                secondButton.image(for: .normal) != UIImage(named: "plus") &&
                thirdButton.image(for: .normal) != UIImage(named: "plus") {
                print("OK")
                guard let image = mergeImages() else { return }
                presentUiActivityController(finalPhoto: image)
            } else {
                alert.missingImage(viewController: self)
            }
        }
        if mode == .mode3 {
            if firtButton.image(for: .normal) != UIImage(named: "plus") &&
                secondButton.image(for: .normal) != UIImage(named: "plus") &&
                thirdButton.image(for: .normal) != UIImage(named: "plus") &&
                fourthButton.image(for: .normal) != UIImage(named: "plus") {
                print("OK")
                guard let image = mergeImages() else { return }
                presentUiActivityController(finalPhoto: image)
            } else {
                alert.missingImage(viewController: self)
            }
        }
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Add photo
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard button != nil else { return }
        
        if let image = info[.editedImage] as? UIImage {
            self.button!.setImage(image, for: .normal)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.button!.setImage(image, for: .normal)
        }
        dismiss(animated: true)
    }
    
    func imagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true)
    }
    
    func addPhoto(button: UIButton) {
        let alert = Alert()

        self.button = button
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        alert.libraryOrCameraSource(viewController: self, imagePickerController: imagePickerController)
    }
}
