//
//  AlertView.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
enum ButtonType {
    case cancel
    case other
}

struct AlertColor {
    static let header = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1.0)
    static let message = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
    static let primary = UIColor.blue
    static let secondary = UIColor.black

}


class AlertView: UIView, AlertViewModel {
    
    func cancelButtonClick() {
    }
    // MARK: - Properties
    var okButtonTitle: String = ""
    var cancelButtonTitle: String = ""
    weak var delegate: AlertViewDelegate?
    var completionHandler: ((String, ButtonType) -> Void)?
    var animationOption: AnimationOption = .zoomInOut

        
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
        view.dropShadows(color: .gray, opacity: 1, offSet: CGSize(width: 1.5, height: 0.8), radius: 1, scale: true)
        view.clipsToBounds = true
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = AlertColor.header
        return label
    }()
    private lazy var seperatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1.0)
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
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = AlertColor.message
        return label
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        button.layer.borderColor = AlertColor.primary.cgColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(AlertColor.primary, for: .normal)
        button.layer.cornerRadius = 8.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return button
    }()
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AlertColor.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(title: String, message: String, okButtonText: String, cancelButtonText: String) {
        self.init(frame: UIScreen.main.bounds)
        setupUIView(title: title, message: message, okButtonText: okButtonText, cancelButtonText: cancelButtonText)
    }
    convenience init(title: String, message: String, okButtonText: String, cancelButtonText: String, target: AlertViewDelegate) {
        self.init(frame: UIScreen.main.bounds)
        self.delegate = target
        setupUIView(title: title, message: message, okButtonText: okButtonText, cancelButtonText: cancelButtonText)
    }

    convenience init(title: String, message: String, okButtonText: String, cancelButtonText: String, actionCompletionHandler: @escaping (String, ButtonType) -> Void) {
        self.init(frame: UIScreen.main.bounds)
        self.completionHandler = actionCompletionHandler
        setupUIView(title: title, message: message, okButtonText: okButtonText, cancelButtonText: cancelButtonText)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    private func setupUIView(title: String, message: String, okButtonText: String, cancelButtonText: String) {
        okButtonTitle = okButtonText
        cancelButtonTitle = cancelButtonText
        setupBackgroundView()
        setupContainerView()
        setupTitleLabel()
        setupSeperatorLabel()
        setupMessageLabel()
        setupButtons()
        messageLabel.text = message
        titleLabel.text = title
        cancelButton.setTitle(cancelButtonText, for: .normal)
        okButton.setTitle(okButtonText, for: .normal)
    }
    private func setupBackgroundView() {
        addSubview(backgroundView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.numberOfTapsRequired = 1
       // backgroundView.addGestureRecognizer(tapGesture)
    }
    private func setupContainerView() {
        backgroundView.addSubview(containerView)
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.78).isActive = true
    }
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    private func setupSeperatorLabel() {
        containerView.addSubview(seperatorLabel)
        seperatorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperatorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1.0).isActive = true
        seperatorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperatorLabel.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
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
        if self.delegate != nil {
            self.delegate?.alertView!(alertView: self, clickedButtonAtIndex: 0)
        } else if completionHandler != nil {
            self.completionHandler!("cancel", .cancel)
         }
    }
    @objc func okButtonClicked() {
        dismiss(animated: true)
        if self.delegate != nil {
            if cancelButtonTitle.count != 0 && okButtonTitle.count != 0 {
                self.delegate?.alertView!(alertView: self, clickedButtonAtIndex: 1)
            } else {
                self.delegate?.alertView!(alertView: self, clickedButtonAtIndex: 0)
            }
        } else if completionHandler != nil {
            self.completionHandler!("Ok", .other)
        }
    }
}
private extension UIView {
     func dropShadows(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offSet  //Here you control x and y
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius //Here your control your blur
        layer.masksToBounds =  false
    }
}
