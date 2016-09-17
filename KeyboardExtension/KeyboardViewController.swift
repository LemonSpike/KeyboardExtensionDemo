//
//  KeyboardViewController.swift
//  KeyboardExtension
//
//  Created by Pranav Kasetti on 08/09/2016.
//  Copyright © 2016 Pranav Kasetti. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    var capsLockOn = false
    var allRowsStackView = UIStackView()
    var cases=0
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextKeyboardButton = UIButton(type: .System) as UIButton
        
        view.backgroundColor = .grayColor()
        
        createKeyboard()
    }
    
    func createKeyboard() {
        if cases==0 {
            allRowsStackView.removeFromSuperview()
            
            let firstRowStackView = createButtonsRowStackView(["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"])
            let secondRowStackView = createButtonsRowStackView(["-", "/", ":", ";", "(", ")", "£", "&", "@", "\""])
            let thirdRowStacKView = createButtonsRowStackView([".", ",", "-", "_", "+"])
            let fourthRowStackView = createButtonsRowStackView(["🌐", "↑", "⇔", "Space", "←", "↵"])
            
            allRowsStackView = UIStackView(arrangedSubviews: [firstRowStackView, secondRowStackView, thirdRowStacKView, fourthRowStackView])
            allRowsStackView.axis = .Vertical
            allRowsStackView.alignment = .Center
            allRowsStackView.spacing = 1
            view.addSubview(allRowsStackView)
            
            allRowsStackView.translatesAutoresizingMaskIntoConstraints = false
            allRowsStackView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
            allRowsStackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -1).active = true
            cases=1
        } else if cases==1 {
            allRowsStackView.removeFromSuperview()
            
            let firstRowStackView = createButtonsRowStackView(["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"])
            let secondRowStackView = createButtonsRowStackView(["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"])
            let thirdRowStacKView = createButtonsRowStackView(["A", "S", "D", "F", "G", "H", "J", "K", "L"])
            let fourthRowStackView = createButtonsRowStackView(["Z", "X", "C", "V", "B", "N", "M"])
            let fifthRowStackView = createButtonsRowStackView(["🌐", "↑", "⇔", "Space", "←", "↵"])
            
            allRowsStackView = UIStackView(arrangedSubviews: [firstRowStackView, secondRowStackView, thirdRowStacKView, fourthRowStackView, fifthRowStackView])
            allRowsStackView.axis = .Vertical
            allRowsStackView.alignment = .Center
            allRowsStackView.spacing = 1
            view.addSubview(allRowsStackView)
            
            allRowsStackView.translatesAutoresizingMaskIntoConstraints = false
            allRowsStackView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
            allRowsStackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -1).active = true
            cases=0
        }
    }
    
    func createButtonsRowStackView(titles: [String]) -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .EqualSpacing
        stackView.alignment = .Center
        stackView.spacing = 1
        
        for title in titles {
            let button = UIButton(type: .Custom)
            button.setTitle(title, forState: .Normal)
            button.setTitleColor(.whiteColor(), forState: .Normal)
            button.backgroundColor = .lightGrayColor()
            button.heightAnchor.constraintEqualToConstant(42).active = true
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 9)
            button.layer.cornerRadius = 3
            button.addTarget(self, action: #selector(KeyboardViewController.tappedButton(_:)), forControlEvents: .TouchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    func tappedButton(button: UIButton) {
        let keyTitle = button.titleLabel!.text
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        switch keyTitle! {
        case "🌐":
            createKeyboard()
        case "↑":
            if capsLockOn {
                button.backgroundColor = .lightGrayColor()
                capsLockOn = false
            } else {
                button.backgroundColor = UIColor(red: 0.5922, green: 0.5922, blue: 0.5922, alpha: 1.0)
                capsLockOn = true
            }
        case "⇔":
            advanceToNextInputMode()
        case "Space":
            proxy.insertText(" ")
        case "←":
            proxy.deleteBackward()
        case "↵":
            proxy.insertText("\n")
        default:
            let textToInset: String
            
            if capsLockOn {
                textToInset = keyTitle!.uppercaseString
            } else {
                textToInset = keyTitle!.lowercaseString
            }
            
            proxy.insertText(textToInset)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
    
}
