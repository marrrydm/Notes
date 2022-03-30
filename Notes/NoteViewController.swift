//  ViewController.swift
//  Notes
//  Created by Мария Ганеева on 27.03.2022.

import UIKit

final class NoteViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var titleTextField = UITextField()
    private var textView = UITextView()
    private var conteiner = UIView()

    enum Constants {
        static let navigationItemTitle = "Заметки"
        static let rightBarButtonTitle = "Готово"
        static let titleTextFieldPlaceholder = "Заметка"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        setupTextField()
        setupRightBarButton()
        setupTextView()
    }

    private func configureTitle() {
        navigationItem.title = Constants.navigationItemTitle
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        rightBarButton.title = Constants.rightBarButtonTitle
        view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }

    private func setupTextField() {
        titleTextField.placeholder = Constants.titleTextFieldPlaceholder
        titleTextField.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleTextField.textColor = .black
        titleTextField.isEnabled = true
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        constraintsTextField()
    }

    private func setupRightBarButton() {
        rightBarButton.title = Constants.rightBarButtonTitle
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func setupTextView() {
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        constraintsTextView()
    }

    private func constraintsTextField() {
        let topConstraint = titleTextField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20
        )
        let trailingConstraint = titleTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        )
        let leadingConstraint = titleTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        )
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: 50)
        let widthConstraint = view.heightAnchor.constraint(equalTo: view.widthAnchor)
        NSLayoutConstraint.activate([topConstraint,
                                     trailingConstraint,
                                     leadingConstraint,
                                     heightConstraint,
                                     widthConstraint])
    }

    private func constraintsTextView() {
        textView.isScrollEnabled = true
        let topConstraint = textView.topAnchor.constraint(
            equalTo: titleTextField.safeAreaLayoutGuide.bottomAnchor,
            constant: 20
        )
        let trailingConstraint = textView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        )
        let leadingConstraint = textView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        )
        let heightConstraint = textView.heightAnchor.constraint(equalToConstant: 600)
        NSLayoutConstraint.activate([topConstraint,
                                     trailingConstraint,
                                     leadingConstraint,
                                     heightConstraint])
    }
}
