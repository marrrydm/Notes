//  ViewController.swift
//  Notes
//  Created by Мария Ганеева on 27.03.2022.

import UIKit

final class NoteViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var titleTextField = UITextField()
    private var textView = UITextView()
    private var dateTextField = UITextField()
    private var dataPicker = UIDatePicker()
    private var toolBar = UIToolbar()
    private var doneToolBar = UIBarButtonItem()
    private let dateFormatter = DateFormatter()

    enum Constants {
        static let navigationItemTitle = "Заметки"
        static let rightBarButtonTitle = "Готово"
        static let titleTextFieldPlaceholder = "Заметка"
        static let titleTextFieldDatePlaceholder = "Дата"
        static let dateFormat = "Дата: dd MMMM yyyy"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        setupTextField()
        setupDateTextField()
        setupDatePicker()
        setupTextView()
        setupRightBarButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }

    private func configureTitle() {
        navigationItem.title = Constants.navigationItemTitle
    }

    @objc func dateChange() {
        var dateText: String {
            dateFormatter.dateFormat = Constants.dateFormat
            return dateFormatter.string(from: dataPicker.date)
        }
        dateTextField.text = dateText
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        rightBarButton.title = Constants.rightBarButtonTitle
        checkForEmpty()
        view.endEditing(true)
    }

    private func showAlert() {
        let alertError = UIAlertController(title: "Ошибка!", message: "Пустое поле заметки!", preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertError, animated: true)
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

    private func setupDateTextField() {
        dateTextField.placeholder = Constants.titleTextFieldDatePlaceholder
        dateTextField.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        dateTextField.textColor = .black
        dateTextField.isEnabled = true
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateTextField)
        constraintsDateTextField()
    }

    private func setupDatePicker() {
        dataPicker.preferredDatePickerStyle = .wheels
        dataPicker.datePickerMode = .date
        dataPicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        dateTextField.inputView = dataPicker
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

    private func constraintsDateTextField() {
        let topConstraint = dateTextField.topAnchor.constraint(
            equalTo: titleTextField.safeAreaLayoutGuide.bottomAnchor,
            constant: 20
        )
        let trailingConstraint = dateTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        )
        let leadingConstraint = dateTextField.trailingAnchor.constraint(
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
            equalTo: dateTextField.safeAreaLayoutGuide.bottomAnchor,
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
        let heightConstraint = textView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([topConstraint,
                                     trailingConstraint,
                                     leadingConstraint,
                                     heightConstraint])
    }
}

// MARK: - CheckForEmptyAlert
extension NoteViewController {
    private func checkForEmpty() {
        let note = Note(content: textView.text)
        if note.isEmpty == "" {
            showAlert()
        }
    }
}
