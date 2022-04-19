//
//  ListViewController.swift
//  Notes
//
//  Created by Мария Ганеева on 10.04.2022.
//

import UIKit

protocol NotesDelegate: AnyObject {
    func updateNotes(note: NoteViewCell.Model)
}

class ListViewController: UIViewController, NotesDelegate, UIGestureRecognizerDelegate {
    private var rightBarButton = UIBarButtonItem()
    private var buttonPlus = UIButton(type: .custom)
    private var scrollView = UIScrollView()
    private let stackView = UIStackView()
    var notes: [NoteViewCell.Model] = []
    weak var delegate: NotesDelegate?
    var cell: NoteViewCell!
    let noteViewController = NoteViewController()

    enum Constants {
        static let titleNB = "Заметки"
        static let titleBBT = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setupUI()
        tapViews()
    }

    func updateNotes(note: NoteViewCell.Model) {
        cell = NoteViewCell()
        noteViewController.updateNotePage(note: note)
        cell.setModel(model: note)
        stackView.addArrangedSubview(cell)
        saveNote(note: note)

        print(notes)

        let tapStackView = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        cell.addGestureRecognizer(tapStackView)
    }

    private func tapViews() {
        let tapButtonPlus = UITapGestureRecognizer(target: self, action: #selector(plusTap(sender:)))
        self.buttonPlus.addGestureRecognizer(tapButtonPlus)
    }

    @objc private func plusTap(sender: UITapGestureRecognizer) {
        let root = NoteViewController()
        navigationController?.pushViewController(root, animated: true)
        root.delegate = self
    }

    //    func updateNote(note: NoteViewCell.Model) {
    //        var currentIndex = 0
    //        for noteArray in notes {
    //            if (noteArray.title == note.title ) {
    //                notes[currentIndex] = note
    //                print(currentIndex)
    //                break
    //            }
    //            currentIndex += 1
    //            print(currentIndex)
    //        }
    //    }

    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        noteViewController.closure = { [self] name in
            cell.setModel(model: name)
        }
        navigationController?.pushViewController(noteViewController, animated: true)
    }

    func saveNote(note: NoteViewCell.Model) {
        notes.append(note)
        self.stackView.reloadInputViews()
    }

    private func setupUI() {
        setupHeader()
        setupPlus()
        setupNavItem()
    }

    private func setupNavItem() {
        navigationItem.title = Constants.titleNB
        navigationItem.backButtonTitle = Constants.titleBBT
    }

    private func setupPlus() {
        buttonPlus.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        buttonPlus.translatesAutoresizingMaskIntoConstraints = false
        buttonPlus.setTitle("+", for: .normal)
        buttonPlus.titleLabel?.font = .systemFont(ofSize: 35)
        buttonPlus.layer.cornerRadius = 25
        buttonPlus.layer.masksToBounds = true
        buttonPlus.clipsToBounds = true
        buttonPlus.addTarget(self, action: #selector(plusTap), for: .touchUpInside)
        buttonPlus.contentVerticalAlignment = .center
        view.addSubview(buttonPlus)
        constraintsButtonPlus()
    }

    private func setupHeader() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        stackView.spacing = 4
        view.addSubview(stackView)
        constraintsStackView()
    }

    private func constraintsButtonPlus() {
    let topConstraint = buttonPlus.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 641
    )
    let leadingConstraint = buttonPlus.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -19
    )
    let heightConstraint = buttonPlus.heightAnchor.constraint(equalToConstant: 50)
    let widthConstraint = buttonPlus.heightAnchor.constraint(equalTo: buttonPlus.widthAnchor)
    NSLayoutConstraint.activate([topConstraint,
                                 leadingConstraint,
                                 heightConstraint,
                                 widthConstraint])
    }

    private func constraintsStackView() {
        let topConstraints = stackView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20
        )
        let trailingConstraints = stackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        )
        let leadingConstraints = stackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        )
        let heightConstraints = stackView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        let widthConstraints = stackView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        NSLayoutConstraint.activate([topConstraints,
                                     trailingConstraints,
                                     leadingConstraints,
                                     heightConstraints,
                                     widthConstraints])
    }
}