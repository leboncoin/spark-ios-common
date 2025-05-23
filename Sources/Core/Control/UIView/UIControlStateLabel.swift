//
//  UIControlStateLabel.swift
//  SparkCommon
//
//  Created by robin.lemaire on 23/10/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import UIKit

/// The custom UILabel which set the correct text or attributedText from the state of the UIControl.
/// Must be used only on UIControl.
@_spi(SI_SPI) public final class UIControlStateLabel: UILabel {

    // MARK: - Properties

    private let textStates = ControlPropertyStates<String>()
    private let attributedTextStates = ControlPropertyStates<NSAttributedString>()
    private let textTypesStates = ControlPropertyStates<DisplayedTextType>()

    /// The text must be stored to lock the posibility to set the text directly like this **self.text = "Text"**.
    /// When the storedText is set (always from **setText** function), it set the text.
    private var storedText: String? {
        didSet {
            self.isText = self.storedText != nil
            self.text = self.storedText

            // Reset styles
            if let storedTextFont = self.storedTextFont {
                self.font = storedTextFont
            }
            if let storedTextColor = self.storedTextColor {
                self.textColor = storedTextColor
            }
        }
    }

    /// The attributedText must be stored to lock the posibility to set the attributedText directly like this **self.attributedText = NSAttributedString()**.
    /// When the storedAttributedText is set (always from **setAttributedText** function), it set the attributedText.
    private var storedAttributedText: NSAttributedString? {
        didSet {
            self.isText = self.storedAttributedText != nil
            self.attributedText = self.storedAttributedText
        }
    }

    /// The storedTextFont is use to reset the font when a new text is set
    /// because the previous text can be an attributedText
    /// and attributedText has its own styles.
    private var storedTextFont: UIFont?

    /// The storedTextColor is use to reset the textColor when a new text is set
    /// because the previous text can be an attributedText
    /// and attributedText has its own styles.
    private var storedTextColor: UIColor?

    // MARK: - Published

    @Published public var isText: Bool = false
    @Published public var textChanged: Void = ()

    // MARK: - Override Properties

    /// It's not possible to set the text outside this class.
    /// The only possiblity to change the text is to use the **setText(_: String?, for: ControlState, on: UIControl)** function.
    override public var text: String? {
        get {
            return super.text
        }
        set {
            // Set the attributedText only if the current come from setText
            if newValue == self.storedText {
                super.text = newValue
                self.textChanged = ()
            }
        }
    }

    /// It's not possible to set the attributedText outside this class.
    /// The only possiblity to change the attributedText is to use the **setAttributedText(_: NSAttributedString?, for: ControlState, on: UIControl)** function.
    override public var attributedText: NSAttributedString? {
        get {
            return super.attributedText
        }
        set {
            // Set the attributedText only if the current come from setAttributedText
            if newValue == self.storedAttributedText {
                super.attributedText = newValue
            }
        }
    }

    override public var font: UIFont! {
        get {
            return super.font
        }
        set {
            // We need to store this value to put it back when a new text will be set (and not an attributedText)
            self.storedTextFont = newValue

            // Set the font only if the display text is not an attributedText.
            if !self.isAttributedDisplayed {
                super.font = newValue
            }
        }
    }

    override public var textColor: UIColor! {
        get {
            return super.textColor
        }
        set {
            // We need to store this value to put it back when a new text will be set (and not an attributedText)
            self.storedTextColor = newValue

            // Set the color only if the display text is not an attributedText
            if !self.isAttributedDisplayed {
                super.textColor = newValue
            }
        }
    }

    // MARK: - Setter & Getter

    /// The text for a state.
    /// - parameter state: state of the text
    public func text(for state: ControlState) -> String? {
        return self.textStates.value(for: state)
    }

    /// Set the text for a state.
    /// - parameter text: new text
    /// - parameter state: state of the text
    /// - parameter control: the parent control
    public func setText(
        _ text: String?,
        for state: ControlState,
        on control: UIControl
    ) {
        self.textStates.setValue(text, for: state)
        self.textTypesStates.setValue(
            text != nil ? .text : DisplayedTextType.none,
            for: state
        )
        self.updateContent(from: control)
    }

    /// The attributedText for a state.
    /// - parameter state: state of the attributedText
    public func attributedText(for state: ControlState) -> NSAttributedString? {
        return self.attributedTextStates.value(for: state)
    }

    /// Set the attributedText of the button for a state.
    /// - parameter attributedText: new attributedText of the button
    /// - parameter state: state of the attributedText
    public func setAttributedText(
        _ attributedText: NSAttributedString?,
        for state: ControlState,
        on control: UIControl
    ) {
        self.attributedTextStates.setValue(attributedText, for: state)
        self.textTypesStates.setValue(
            attributedText != nil ? .attributedText : DisplayedTextType.none,
            for: state
        )
        self.updateContent(from: control)
    }

    // MARK: - Update UI

    /// Update the label (text or attributed) for a parent control state.
    /// - parameter control: the parent control
    public func updateContent(from control: UIControl) {
        // Create the status from the control
        let status = ControlStatus(
            isHighlighted: control.isHighlighted,
            isEnabled: control.isEnabled,
            isSelected: control.isSelected
        )

        // Get the current textType from status
        let textType = self.textTypesStates.value(for: status)
        let textTypeContainsText = textType?.containsText ?? false

        // Set the text or the attributedText from textType and states
        if let text = self.textStates.value(for: status),
           textType == .text || !textTypeContainsText {
            self.storedAttributedText = nil
            self.storedText = text

        } else if let attributedText = self.attributedTextStates.value(for: status),
                  textType == .attributedText || !textTypeContainsText {
            self.storedAttributedText = attributedText

        } else { // No text to displayed
            self.storedText = nil
        }
    }

    // MARK: - Helpers

    /// The attributedText is displayed or not.
    private var isAttributedDisplayed: Bool {
        // There is an attributedText ?
        guard let attributedText = self.attributedText, attributedText.length > 0 else {
            return false
        }

        return self.storedAttributedText == attributedText
    }
}
