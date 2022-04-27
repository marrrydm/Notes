//  ViewController.swift
//  Notes
//  Created by Мария Ганеева on 27.03.2022.

import UIKit

final class NoteViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var titleTextField = UITextField()
    private var textLabel = UILabel()
    private var textView = UITextView()
    private var dateTextField = UITextField()
    private var dataPicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    private let locale = Locale(identifier: "rus")
    weak var delegate: NotesDelegate?
    var closure: ((NoteViewCell.Model) -> Void)?
    var notes: NoteViewCell.Model?

    private enum Constants {
        static let rightBarButtonTitle = "Готово"
        static let titleTextFieldPlaceholder = "Введите название"
        static let dateFormat = "dd.MM.yyyy EEEE HH:mm"
        static let titleUpdate = ""
        static let outputDate = "dd.MM.yyyy"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        configureUI()
        keyboardUp()
    }

    func updateNotePage(note: NoteViewCell.Model) {
        titleTextField.text = note.title
        textView.text = note.content
        dateTextField.text = note.date
        dateFormatter.dateFormat = Constants.dateFormat
        dateTextField.text = dateFormatter.string(from: dataPicker.date)
    }

    func changeDateInList() {
        dateFormatter.dateFormat = Constants.outputDate
        closure?(
            NoteViewCell.Model(
                title: titleTextField.text ?? Constants.titleUpdate,
                content: textView.text,
                date: dateFormatter.string(from: dataPicker.date)
            )
        )
    }

    private func keyboardUp() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let userInfo = notification.userInfo!
            var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue
            keyboardFrame = view.convert(keyboardFrame, from: nil)

            var contentInset: UIEdgeInsets = textView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            textView.contentInset = contentInset

            rightBarButton.title = Constants.rightBarButtonTitle
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let contentInset: UIEdgeInsets = UIEdgeInsets()
            textView.contentInset = contentInset

            rightBarButton.title = Constants.titleUpdate
        }
    }

    private func configureUI() {
        setupDateTextField()
        setupTextField()
        setupTextView()
        setupRightBarButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }

    private func dateFormatterConfigure() {
        dateFormatter.dateFormat = Constants.dateFormat
        dateFormatter.locale = locale
    }

    @objc func dateChange() {
        dateFormatterConfigure()
        dateTextField.text = dateFormatter.string(from: dataPicker.date)
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        rightBarButton.title = Constants.rightBarButtonTitle
        checkForEmpty()
        changeDateInList()
        view.endEditing(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dateFormatter.dateFormat = Constants.outputDate
        notes = NoteViewCell.Model(
            title: titleTextField.text!,
            content: textView.text,
            date: dateFormatter.string(from: dataPicker.date)
        )
        changeDateInList()
        self.delegate?.updateNotes(note: notes!)
    }

    private func showAlert() {
        let alertError = UIAlertController(title: "Ошибка!", message: "Пустое поле заметки!", preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertError, animated: true)
    }

    private func setupTextField() {
        titleTextField.placeholder = Constants.titleTextFieldPlaceholder
        titleTextField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleTextField.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        titleTextField.textColor = .black
        titleTextField.isEnabled = true
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        constraintsTextField()
    }

    private func setupDateTextField() {
        dateFormatterConfigure()
        dateTextField.placeholder = dateFormatter.string(from: dataPicker.date)
        dateTextField.font = .systemFont(ofSize: 14, weight: .bold)
        dateTextField.textColor = UIColor(red: 0.172, green: 0.172, blue: 0.172, alpha: 1)
        dateTextField.isEnabled = true
        dateTextField.textAlignment = .center
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateTextField)
        constraintsDateTextField()
    }

    private func setupRightBarButton() {
        rightBarButton.title = Constants.rightBarButtonTitle
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func setupTextView() {
        textView.isUserInteractionEnabled = true
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        constraintsTextView()
    }

    private func constraintsTextField() {
        let topConstraint = titleTextField.topAnchor.constraint(
            equalTo: dateTextField.safeAreaLayoutGuide.topAnchor,
            constant: 28
        )
        let trailingConstraint = titleTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        )
        let leadingConstraint = titleTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        )
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: 24)
        let widthConstraint = view.heightAnchor.constraint(equalTo: view.widthAnchor)
        NSLayoutConstraint.activate([topConstraint,
                                     trailingConstraint,
                                     leadingConstraint,
                                     heightConstraint,
                                     widthConstraint])
    }

    private func constraintsDateTextField() {
        let topConstraint = dateTextField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 12
        )
        let trailingConstraint = dateTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        )
        let leadingConstraint = dateTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        )
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: 40)
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
            constant: 28
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

// MARK: - CheckForEmptyAlert
extension NoteViewController {
    private func checkForEmpty() {
        let note = Note(content: textView.text)
        if note.isEmpty {
            showAlert()
        }
    }
}
