//
//  ListViewController.swift
//  Notes
//
//  Created by Мария Ганеева on 10.04.2022.
//

import UIKit

protocol NotesDelegate: AnyObject {
    func updateNotes(note: Note)
}

class ListViewController: UIViewController, NotesDelegate {
    private var rightBarButton = UIBarButtonItem()
    private var buttonPlus = UIButton(type: .custom)
    private var scrollView = UIScrollView()
    private let stackView = UIStackView()
    var list = NoteViewCell()

    enum Constants {
        static let titleNB = "Заметки"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        setupUI()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(plusTap))
        list.addGestureRecognizer(gesture)
        }

    func updateNotes(note: Note) {
        list = NoteViewCell(note: note)
        print(list)
        scrollView.addSubview(list)
        list.title = note.title!
        print(list.title)
        list.content = note.content
        print(list.content)
        list.date = note.date!
        print(list.date)
        print("Данные переданы")
        stackView.addArrangedSubview(list)
    }

    private func setupUI() {
        setupPlus()
        setupHeader()
        setupNavItem()
    }

    @objc private func plusTap() {
        let root = NoteViewController()
        navigationController?.pushViewController(root, animated: true)
    }

    private func setupNavItem() {
        navigationItem.title = Constants.titleNB
    }

    private func setupPlus() {
        buttonPlus.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        buttonPlus.translatesAutoresizingMaskIntoConstraints = false
        buttonPlus.setTitle("+", for: .normal)
        buttonPlus.titleLabel?.font = .systemFont(ofSize: 40)
        buttonPlus.layer.cornerRadius = 0.5 * 70
        buttonPlus.clipsToBounds = true
        buttonPlus.addTarget(self, action: #selector(plusTap), for: .touchUpInside)
        buttonPlus.contentVerticalAlignment = .center
        scrollView.addSubview(buttonPlus)
        constraintsButtonPlus()
    }

    private func setupHeader() {
        scrollView.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        constraintsScrollView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        stackView.spacing = 5
        scrollView.addSubview(stackView)
//        stackView.addArrangedSubview(list)
        constraintsStackView()
    }

    private func constraintsButtonPlus() {
    let topConstraint = buttonPlus.topAnchor.constraint(
        equalTo: scrollView.safeAreaLayoutGuide.topAnchor,
        constant: 621
    )
    let trailingConstraint = buttonPlus.leadingAnchor.constraint(
        equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
        constant: 310
    )
    let leadingConstraint = buttonPlus.trailingAnchor.constraint(
        equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor,
        constant: -20
    )
    let heightConstraint = buttonPlus.heightAnchor.constraint(equalToConstant: 70)
    let widthConstraint = buttonPlus.widthAnchor.constraint(equalTo: buttonPlus.widthAnchor)
    NSLayoutConstraint.activate([topConstraint,
                                 trailingConstraint,
                                 leadingConstraint,
                                 heightConstraint,
                                 widthConstraint])
    }

    private func constraintsScrollView() {
        let topConstraint = scrollView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20
        )
        let trailingConstraint = scrollView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = scrollView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        )
        let heightConstraint = scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        let widthConstraint = scrollView.heightAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([topConstraint,
                                     trailingConstraint,
                                     leadingConstraint,
                                     heightConstraint,
                                     widthConstraint])
    }

    private func constraintsStackView() {
        let topConstraints = stackView.topAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.topAnchor,
            constant: 20
        )
        let trailingConstraints = stackView.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        )
        let leadingConstraints = stackView.trailingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        )
        let heightConstraints = stackView.heightAnchor.constraint(equalToConstant: 600)
        let widthConstraints = stackView.widthAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([topConstraints,
                                     trailingConstraints,
                                     leadingConstraints,
                                     heightConstraints,
                                     widthConstraints])
    }
}
