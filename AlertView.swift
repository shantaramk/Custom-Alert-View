//
//  AlertView.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class AlertView: UIView, AlertViewModel {
    func cancelButtonClick() {
        
    }
    
    
    
    
    // MARK: - Properties
    var okButtonTitle: String = ""
    var cancelButtonTitle: String = ""
    let cancelAction: ()->(String) = { return ""}
    var delegate: AlertViewDelegate?

    // MAKR: - Lazy loading view
    internal lazy var backgroundView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        return view
    }()
    internal lazy var containerView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 13.0
        view.clipsToBounds = true
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    private lazy var seperatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 8.0
        return button
    }()
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(title: String, message: String, ok: String, cancel: String) {
        self.init(frame: UIScreen.main.bounds)
        setupUIView(title: title, message: message, ok: ok, cancel: cancel)
    }
    convenience init(title: String, message: String, ok: String, cancel: String,target: AlertViewDelegate) {
        self.init(frame: UIScreen.main.bounds)
        self.delegate = target
        setupUIView(title: title, message: message, ok: ok, cancel: cancel)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    private func setupUIView(title: String, message: String, ok: String, cancel: String) {
        okButtonTitle = ok
        cancelButtonTitle = cancel
        
        setupBackgroundView()
        setupContainerView()
        setupTitleLabel()
        setupSeperatorLabel()
        setupMessageLabel()
        setupButtons()
        
        messageLabel.text = message
        titleLabel.text = title
        cancelButton.setTitle(cancel, for: .normal)
        okButton.setTitle(ok, for: .normal)
      
    }
    
    private func setupBackgroundView() {
        addSubview(backgroundView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.numberOfTapsRequired = 1
        backgroundView.addGestureRecognizer(tapGesture)
    }
    private func setupContainerView() {
        backgroundView.addSubview(containerView)
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.78).isActive = true
    }
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    private func setupSeperatorLabel() {
        containerView.addSubview(seperatorLabel)
        seperatorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperatorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1.0).isActive = true
        seperatorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperatorLabel.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
    }
    private func setupMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23.0).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
    }
    private func setupCancelButton() {
        containerView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15.0).isActive = true
        cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 23.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
    }
    private func setupOkButton() {
        containerView.addSubview(okButton)
        okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15.0).isActive = true
        okButton.topAnchor.constraint(equalTo: cancelButton.topAnchor, constant: 0.0).isActive = true
        okButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor, constant: 0.0).isActive = true
        okButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor, constant: 0.0).isActive = true
        okButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 15.0).isActive = true
    }
    private func setupOkButtonWithRespectToSuperview() {
        containerView.addSubview(okButton)
        okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 23.0).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
        okButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true
        okButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

    }
    func setupButtons() {
        if cancelButtonTitle.count != 0 && okButtonTitle.count != 0 {
            setupCancelButton()
            setupOkButton()
        } else {
                setupOkButtonWithRespectToSuperview()
        }
    }
    @objc func dismissView() {
        dismiss(animated: true)
    }
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
        self.delegate?.alertView(alertView: self, clickedButtonAtIndex: 0)
    }
    @objc func okButtonClicked() {
        dismiss(animated: true)
        self.delegate?.alertView(alertView: self, clickedButtonAtIndex: 1)
    }
}
