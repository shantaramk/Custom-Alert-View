//
//  AlertView.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class AlertView: UIView {

    // MARK: - Properties

    // MAKR: - Lazy loading view
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 0.5)
        return view
    }()
   private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
   private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
   private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
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
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
   private func setupUIView(title: String, message: String, ok: String, cancel: String) {
        setupBackgroundView()
        setupContainerView()
        setupTitleLabel()
        setupMessageLabel()
        setupCancelButton()
        setupOkButton()
        
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
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
   private func setupMessageLabel() {
        containerView.addSubview(messageLabel)
         messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.0).isActive = true
         messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
    }
   private func setupCancelButton() {
        containerView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5.0).isActive = true
    }
    private func setupOkButton() {
        containerView.addSubview(okButton)
        okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        okButton.topAnchor.constraint(equalTo: cancelButton.topAnchor, constant: 0.0).isActive = true
        okButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor, constant: 0.0).isActive = true
        okButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor, constant: 0.0).isActive = true
        okButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 5.0).isActive = true
    }
  @objc func dismissView() {
        self.removeFromSuperview()
    }
}
