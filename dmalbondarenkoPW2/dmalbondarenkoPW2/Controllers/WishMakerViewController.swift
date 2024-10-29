//
//  WishMakerViewController.swift
//  dmalbondarenkoPW2
//
//  Created by dread on 23.10.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    // MARK: - Properties
    private let wishMakerView = WishMakerView()
    private var isStackHidden = false
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = wishMakerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCallbacks()
        updateBackgroundAndTextColor()
    }

    // MARK: - Private Methods
    private func configureCallbacks() {
        wishMakerView.onColorChange = { [weak self] color in
            self?.updateBackgroundAndTextColor(to: color)
        }
        
        wishMakerView.onToggleButtonPressed = { [weak self] in
            self?.toggleStackVisibility()
        }
    }

    private func updateBackgroundAndTextColor(to color: UIColor? = nil) {
        let backgroundColor = color ?? UIColor(
            red: CGFloat(wishMakerView.redSliderValue),
            green: CGFloat(wishMakerView.greenSliderValue),
            blue: CGFloat(wishMakerView.blueSliderValue),
            alpha: CGFloat(wishMakerView.alphaSliperValue)
        )
        
        wishMakerView.updateBackgroundColor(to: backgroundColor)
        wishMakerView.updateTextColor(to: backgroundColor.inverted())
    }
    
    private func toggleStackVisibility() {
        isStackHidden.toggle()
        wishMakerView.setStackVisibility(isHidden: isStackHidden)
        wishMakerView.updateButtonTitle(isHidden: isStackHidden)
    }
}
