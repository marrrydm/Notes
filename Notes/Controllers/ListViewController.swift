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

final class ListViewController: UIViewController, NotesDelegate, UITableViewDelegate, UITableViewDataSource {
    private var rightBarButton = UIBarButtonItem()
    private var buttonPlus = UIButton(type: .custom)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var notes: [NoteViewCell.Model] = []
    private var cells: [NoteViewCell] = []
    private var cell: NoteViewCell?

    private enum Constants {
        static let titleNB = "Заметки"
        static let titleBBT = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setupUI()
        tapViews()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteViewCell.self, forCellReuseIdentifier: NoteViewCell.id)
    }

    private func numberOfSections(tableView: UITableView) -> Int {
        return notes.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteViewCell.id) as? NoteViewCell else {
            fatalError("failed to get reusable cell valueCell")
        }
        cell.note = notes[indexPath.row]
        return cell
    }

//    при нажатии
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteViewController = NoteViewController()
        guard let index = tableView.indexPathForSelectedRow?.row as? Int else {
            return
        }
        for (ind, value) in notes.enumerated() where index == ind {
            noteViewController.updateNotePage(note: value)
        }
        noteViewController.closure = { [self] name in
            cells[index].setModel(model: name)
            notes[index] = name
            tableView.reloadData()
        }
        navigationController?.pushViewController(noteViewController, animated: true)
    }

    func updateNotes(note: NoteViewCell.Model) {
        cell = NoteViewCell()
        cell?.setModel(model: note)

        saveNote(note: note)
        tableView.reloadData()
        cells.append(cell!)
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

    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destination = NoteViewController()
        destination.delegate = self
        destination.notes = notes[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }

    func saveNote(note: NoteViewCell.Model) {
        notes.append(note)
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
        buttonPlus.setImage(UIImage(systemName: "plus"), for: .normal)
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        constraintsTableView()
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

    private func constraintsTableView() {
        let topConstraints = tableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20
        )
        let trailingConstraints = tableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        )
        let leadingConstraints = tableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        )
        let heightConstraints = tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let widthConstraints = tableView.widthAnchor.constraint(equalToConstant: 500)
        NSLayoutConstraint.activate([topConstraints,
                                     trailingConstraints,
                                     leadingConstraints,
                                     heightConstraints,
                                     widthConstraints])
    }
}
