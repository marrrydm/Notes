//  ViewController.swift
//  Notes
//  Created by Мария Ганеева on 27.03.2022.

import UIKit

protocol NoteDisplayLogic: AnyObject {
    func display(data: Model.CleanNoteViewModel)
}

final class NoteViewController: UIViewController {
    // MARK: External vars
    private (set) var router: (RouterNoteLogic & RouterNoteDataPassingProtocol)?
    // MARK: Internal vars
    private var interactor: (InteractorNoteBusinessLogic & InteractorNoteStoreProtocol)?

// MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = InteractorNote()
        let router = RouterNote()
        let presenter = PresenterNote()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.noteViewController = viewController
        router.dataStore = interactor
    }

// MARK: - Private Properties
    private var rightBarButton = UIBarButtonItem()
    private var titleTextField = UITextField()
    private var textLabel = UILabel()
    private var textView = UITextView()
    private var dateTextField = UITextField()
    private var dataPicker = UIDatePicker()
    private var dateFormatter = DateFormatter()
    private var locale = Locale(identifier: "rus")
    private var notes = Model.CleanNoteViewModel(header: "", text: "", date: .now)
    private var url: URL?
    private var image: UIImage?
    private var id: UUID?

// MARK: - UI
    private func configureUI() {
        setupDateTextField()
        setupTextField()
        setupTextView()
        setupRightBarButton()
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
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
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
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
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
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint
        ])
    }

// MARK: - Inheritance
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        configureUI()
        keyboardUp()
        interactor?.fetchNote()
    }

    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dateFormatter.dateFormat = Constants.outputDate
        notes = Model.CleanNoteViewModel(
            header: titleTextField.text ?? Constants.titleUpdate,
            text: textView.text,
            date: dataPicker.date,
            id: id!,
            userShareIcon: url,
            img: image
        )
        router?.navigateToNote(model: notes)
    }

// MARK: - Private Methods
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

    @objc private func keyboardWillShow(notification: NSNotification) {
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

    @objc private func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let contentInset: UIEdgeInsets = UIEdgeInsets()
            textView.contentInset = contentInset

            rightBarButton.title = Constants.titleUpdate
        }
    }

    private func dateFormatterConfigure() {
        dateFormatter.dateFormat = Constants.dateFormat
        dateFormatter.locale = locale
    }

    @objc private func dateChange() {
        dateFormatterConfigure()
        dateTextField.text = dateFormatter.string(from: dataPicker.date)
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        rightBarButton.title = Constants.rightBarButtonTitle
        checkForEmpty()
        view.endEditing(true)
    }

    private func showAlert() {
        let alertError = UIAlertController(title: "Ошибка!", message: "Пустое поле заметки!", preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alertError, animated: true)
    }

// MARK: - Constants
    private enum Constants {
        static let rightBarButtonTitle = "Готово"
        static let titleTextFieldPlaceholder = "Введите название"
        static let dateFormat = "dd.MM.yyyy EEEE HH:mm"
        static let titleUpdate = ""
        static let outputDate = "dd.MM.yyyy"
    }
}

// MARK: - NoteDisplayLogic
extension NoteViewController: NoteDisplayLogic {
    func display(data: Model.CleanNoteViewModel) {
        titleTextField.text = data.header
        textView.text = data.text
        dateTextField.text = data.date.formatted()
        dateFormatter.dateFormat = Constants.dateFormat
        dateTextField.text = dateFormatter.string(from: dataPicker.date)
        url = data.userShareIcon
        image = data.img
        id = data.id
    }
}

// MARK: - CheckForEmptyAlert
extension NoteViewController {
    private func checkForEmpty() {
        let note = Model.CheckIsEmpty(text: textView.text)
        if note.isEmpty {
            showAlert()
        }
    }
}
