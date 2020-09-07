//
//  ViewController.swift
//  MultipleTable
//
//  Created by Catalina on 6.09.2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit
import TinyConstraints

class HomeVC: UIViewController {

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let num1Label: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 100, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let xLabel: UILabel = {
        let label = UILabel()
        label.text = "x"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 100, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let num2Label: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 100, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let resultField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.placeholder = "Type your result"
        return field
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let resultButton: UIButton = {
        let button = UIButton()
        button.setTitle("Result", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var result = 0
    let numbersArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Multiple Table"
        setupLayout()
        
        resultField.delegate = self
        shuffleNumbers()
        
        resultButton.addTarget(self, action: #selector(resultButtonDidTapped), for: .touchUpInside)
        addGestureRecognizer()
    }
    
    private func shuffleNumbers() {
        num1Label.text = numbersArray.randomElement()
        num2Label.text = numbersArray.randomElement()
    }
    
    @objc private func resultButtonDidTapped() {
        guard let userResult = resultField.text, !userResult.isEmpty,
        let num1 = num1Label.text, let num2 = num2Label.text
        else { return }
        
        guard let num1Int = Int(num1) else { return }
        guard let num2Int = Int(num2) else { return }
        
        result = num1Int * num2Int
        
        if result == Int(userResult) {
            resultLabel.text = "Correct."
            resultLabel.textColor = .green
        } else {
            resultLabel.text = "Wrong answer! It is: \(result)"
            resultLabel.textColor = .black
        }
        
        resultField.text = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.num1Label.text = self.numbersArray.randomElement()
            self.num2Label.text = self.numbersArray.randomElement()
        }
    }
    
    private func addGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
   
    @objc private func dismissKeyboard() {
        resultField.endEditing(true)
    }
    
    private func setupLayout() {
        view.addSubview(backgroundImage)
        backgroundImage.edgesToSuperview()
        
        view.addSubview(stackView)
        stackView.topToSuperview().constant = 150
        stackView.leadingToSuperview().constant = 50
        stackView.trailingToSuperview().constant = -50
        stackView.height(150)
        stackView.addArrangedSubview(num1Label)
        stackView.addArrangedSubview(xLabel)
        stackView.addArrangedSubview(num2Label)
        
        view.addSubview(resultField)
        resultField.topToBottom(of: stackView).constant = 70
        resultField.centerXToSuperview()
        resultField.width(150)
        resultField.height(40)
        
        view.addSubview(resultLabel)
        resultLabel.topToBottom(of: resultField).constant = 35
        resultLabel.centerXToSuperview()
        resultLabel.width(300)
        resultLabel.height(50)
        
        view.addSubview(resultButton)
        resultButton.topToBottom(of: resultLabel).constant = 35
        resultButton.centerXToSuperview()
        resultButton.width(150)
        resultButton.height(40)
    }
}

//MARK: - UITextField Delegate Methods

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
