//
//  WishMakerView.swift
//  dmalbondarenkoPW2
//
//  Created by dread on 28.10.2024.
//

import UIKit

final class WishMakerView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 40
        static let stackLeading: CGFloat = 20
        
        static let colorValue = 0.3
        static let alphaValue: CGFloat = 1.0
        static let borderWidth = 1.0
        
        static let red = "Red"
        static let green = "Green"
        static let blue = "Blue"
        
        static let titleSize: CGFloat = 32
        static let titleTopPadding: CGFloat = 30
        static let descriptionSize: CGFloat = 16
        static let descriptionPadding: CGFloat = 20
        static let titleText: String = "WishMaker"
        static let descriptionText: String = "This app will bring you joy and will fulfill three of your wishes!"
        
        static let buttonBottom: CGFloat = 10
        static let buttonHeight: CGFloat = 40
        static let buttonTitleShow = "Show sliders"
        static let buttonTitleHide = "Hide sliders"
        static let buttonTitleColor: UIColor = .black
        static let buttonBackgroundColor: UIColor = .white
    }

    // MARK: - UI Elements
    private let titleView = UILabel()
    private let descr = UILabel()
    private let stack = UIStackView()
    private let toggleButton = UIButton()
    private let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    
    // MARK: - Callbacks
    var onColorChange: ((UIColor) -> Void)?
    var onToggleButtonPressed: (() -> Void)?
    
    // MARK: - Properties
    var redSliderValue: Float { sliderRed.slider.value }
    var greenSliderValue: Float { sliderGreen.slider.value }
    var blueSliderValue: Float { sliderBlue.slider.value }
    var alphaSliperValue = Constants.alphaValue
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func updateTextColor(to color: UIColor) {
        titleView.textColor = color
        descr.textColor = color
    }

    func updateBackgroundColor(to color: UIColor) {
        backgroundColor = color
    }
    
    func setStackVisibility(isHidden: Bool) {
        stack.isHidden = isHidden
    }
    
    func updateButtonTitle(isHidden: Bool) {
        toggleButton.setTitle(isHidden ? Constants.buttonTitleShow : Constants.buttonTitleHide, for: .normal)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = UIColor(
            red: Constants.colorValue,
            green: Constants.colorValue,
            blue: Constants.colorValue,
            alpha: Constants.alphaValue
        )
        configureTitle()
        configureDescription()
        configureSliders()
        configureButton()
    }

    private func configureTitle() {
        titleView.text = Constants.titleText
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleSize)
        
        addSubview(titleView)
        titleView.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.titleTopPadding)
        titleView.pinCenterX(to: self)
    }
    
    private func configureDescription() {
        descr.text = Constants.descriptionText
        descr.font = UIFont.systemFont(ofSize: Constants.descriptionSize)
        descr.numberOfLines = .zero
        descr.lineBreakMode = .byWordWrapping
        
        addSubview(descr)
        descr.pinLeft(to: self, Constants.descriptionPadding)
        descr.pinRight(to: self, Constants.descriptionPadding)
        descr.pinTop(to: titleView.bottomAnchor, Constants.descriptionPadding)
    }
    
    private func configureSliders() {
        stack.axis = .vertical
        stack.layer.cornerRadius = Constants.stackRadius
        stack.layer.borderWidth = Constants.borderWidth
        stack.clipsToBounds = true

        addSubview(stack)
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
            slider.valueChanged = { [weak self] _ in self?.notifyColorChange() }
        }
        
        stack.pinCenterX(to: self)
        stack.pinLeft(to: self.leadingAnchor, Constants.stackLeading)
        stack.pinBottom(to: self.bottomAnchor, Constants.stackBottom)
    }

    private func configureButton() {
        toggleButton.setTitle(Constants.buttonTitleHide, for: .normal)
        toggleButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
        toggleButton.backgroundColor = Constants.buttonBackgroundColor
        toggleButton.layer.cornerRadius = Constants.stackRadius
        toggleButton.layer.borderWidth = Constants.borderWidth
        toggleButton.addTarget(self, action: #selector(toggleButtonPressed), for: .touchUpInside)

        addSubview(toggleButton)
        toggleButton.pinBottom(to: stack.topAnchor, Constants.buttonBottom)
        toggleButton.setHeight(Constants.buttonHeight)
        toggleButton.pinCenterX(to: centerXAnchor)
        toggleButton.pinLeft(to: stack.leadingAnchor)
    }
    
    private func notifyColorChange() {
        onColorChange?(UIColor(
            red: CGFloat(redSliderValue),
            green: CGFloat(greenSliderValue),
            blue: CGFloat(blueSliderValue),
            alpha: Constants.alphaValue
        ))
    }

    @objc private func toggleButtonPressed() {
        onToggleButtonPressed?()
    }
}
