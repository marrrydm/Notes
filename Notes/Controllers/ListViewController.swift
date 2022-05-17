//
//  ListViewController.swift
//  Notes
//
//  Created by Мария Ганеева on 10.04.2022.
//

import UIKit

// MARK: - NotesDelegate

protocol NotesDelegate: AnyObject {
    func updateNotes(note: NoteViewModel)
}

final class ListViewController: UIViewController {
// MARK: - Private Properties

    private var rightBarButtonSelect = UIBarButtonItem()
    private var rightBarButtonOk = UIBarButtonItem()
    private var buttonPlus = UIButton(type: .custom)
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var notes: [NoteViewModel] = []
    private var cells: [NoteViewCell] = []
    private var cellFirst: NoteViewCell?
    private var indexArr = [NoteViewModel]()
    private var indexPathArray = [IndexPath]()
    var paths: [IndexPath]?

// MARK: - Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        setupUI()
        tapViews()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteViewCell.self, forCellReuseIdentifier: NoteViewCell.Constants.id)
        tableView.setEditing(false, animated: true)
        tableView.allowsMultipleSelectionDuringEditing = true
    }

    override func viewDidAppear(_ animated: Bool) {
        btnAnimateOpen()
    }

// MARK: - Private Methods

    private func tapViews() {
        let tapButtonPlus = UITapGestureRecognizer(target: self, action: #selector(plusTap(sender:)))
        self.buttonPlus.addGestureRecognizer(tapButtonPlus)
    }

    @objc private func plusTap(sender: UITapGestureRecognizer) {
        if !tableView.isEditing {
            btnAnimateGo()
        } else {
            if tableView.indexPathsForSelectedRows == nil {
                showAlert()
            } else {
                tableView.beginUpdates()
                for val in indexArr {
                    for (ind, value) in notes.enumerated() where val == value {
                        notes.remove(at: ind)
                        tableView.deleteRows(at: indexPathArray, with: .left)
                    }
                }
                tableView.endUpdates()
                tableView.reloadData()
                tableView.setEditing(false, animated: true)
                setupRightBarButton()
                buttonPlus.setImage(UIImage(named: "Image"), for: .normal)
            }
        }
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .none
    }

    private func showAlert() {
        let alertError = UIAlertController(
            title: "Ошибка!",
            message: "Вы не выбрали ни одной заметки!",
            preferredStyle: .alert
        )
        alertError.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertError, animated: true)
    }

    private func saveNote(note: NoteViewModel) {
        notes.append(note)
    }

    private func setupUI() {
        setupHeader()
        setupPlus()
        setupNavItem()
        setupRightBarButton()
    }

    private func setupRightBarButton() {
        rightBarButtonSelect.title = Constants.titleSelect
        rightBarButtonSelect.target = self
        rightBarButtonSelect.action = #selector(deleteNotesMode)
        navigationItem.rightBarButtonItem = rightBarButtonSelect
    }

    @objc private func doneDeletingNotes() {
        setupRightBarButton()
        tableView.setEditing(false, animated: true)
        buttonPlus.setImage(UIImage(named: "Image"), for: .normal)
    }

    @objc private func deleteNotesMode(_ sender: UIButton) {
        rightBarButtonOk.title = Constants.titleFinally
        rightBarButtonOk.target = self
        rightBarButtonOk.action = #selector(doneDeletingNotes)
        navigationItem.rightBarButtonItem = rightBarButtonOk
        buttonPlus.setImage(UIImage(named: "Vector"), for: .normal)
        tableView.setEditing(true, animated: true)
        tableView.reloadData()
    }

    private func setupNavItem() {
        navigationItem.title = Constants.titleNB
        navigationItem.backButtonTitle = Constants.titleNull
    }

    private func setupPlus() {
        buttonPlus.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        buttonPlus.translatesAutoresizingMaskIntoConstraints = false
        buttonPlus.setImage(UIImage(named: "Image"), for: .normal)
        buttonPlus.titleLabel?.textAlignment = .center
        buttonPlus.layer.cornerRadius = 25
        buttonPlus.layer.masksToBounds = true
        buttonPlus.clipsToBounds = true
        buttonPlus.addTarget(self, action: #selector(plusTap), for: .touchUpInside)
        view.addSubview(buttonPlus)
        constraintsButtonPlus()
    }

    private func setupHeader() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = Constants.backgroundColor
        tableView.separatorStyle = .none
        tableView.allowsSelectionDuringEditing = true
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
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
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
        let heightConstraints = tableView.heightAnchor.constraint(equalToConstant: 700)
        let widthConstraints = tableView.widthAnchor.constraint(equalToConstant: 500)
        NSLayoutConstraint.activate([
            topConstraints,
            trailingConstraints,
            leadingConstraints,
            heightConstraints,
            widthConstraints
        ])
    }

    // MARK: - Constants

    private enum Constants {
        static let titleNB = "Заметки"
        static let titleSelect = "Выбрать"
        static let titleFinally = "Готово"
        static let titleNull = ""
        static let backgroundColor = UIColor(
            red: 0.898,
            green: 0.898,
            blue: 0.898,
            alpha: 1
        )
    }
}

// MARK: - NotesDelegate

extension ListViewController: NotesDelegate {
    func updateNotes(note: NoteViewModel) {
        cellFirst = NoteViewCell()
        cellFirst?.setModel(model: note)

        saveNote(note: note)
        tableView.reloadData()
        cells.append(cellFirst!)
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteViewCell.Constants.id
        ) as? NoteViewCell else {
            fatalError("failed to get value cell")
        }
        cell.updateNotes(note: notes[indexPath.row])
        cell.layer.cornerRadius = 14
        cell.layer.masksToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        let verticalPadding: CGFloat = 5
        let maskLayer = CALayer()

        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(
            x: cell.bounds.origin.x,
            y: cell.bounds.origin.y,
            width: cell.bounds.width,
            height: cell.bounds.height
        ).insetBy(dx: 0, dy: verticalPadding / 2)
        cell.layer.mask = maskLayer
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteViewController = NoteViewController()
        paths = tableView.indexPathsForSelectedRows
        guard let index = tableView.indexPathForSelectedRow?.row else {
            return
        }
        if !tableView.isEditing {
            for (ind, value) in notes.enumerated() where index == ind {
                noteViewController.updateNotePage(note: value)
            }
            noteViewController.closure = { [self] name in
                cells[index].setModel(model: name)
                notes[index] = name
                tableView.reloadData()
            }
            navigationController?.pushViewController(noteViewController, animated: true)
        } else {
            for path in paths! {
                for (ind, value) in notes.enumerated() where path.row == ind {
                    indexArr.append(value)
                    indexPathArray.append(path)
                }
            }
        }
    }
}

// MARK: - Animations
extension ListViewController {
    private func btnAnimateOpen() {
        buttonPlus.isHidden = false
        UIView.animate(
            withDuration: 0,
            delay: 0,
            animations: {
            },
            completion: {_ in
                UIView.animate(
                    withDuration: 0.01,
                    delay: 0,
                    animations: {
                        self.buttonPlus.layer.position.y += 110
                    },
                    completion: {_ in
                        UIView.animate(
                            withDuration: 1,
                            delay: 0,
                            animations: {
                                self.buttonPlus.layer.position.y -= 110
                            },
                            completion: {_ in
                                self.buttonPlus.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                                UIView.animate(
                                    withDuration: 1,
                                    delay: 0,
                                    usingSpringWithDamping: 0.3,
                                    initialSpringVelocity: 0.3,
                                    options: .curveEaseOut,
                                    animations: { [self] in
                                        self.buttonPlus.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    }
                                )
                            }
                        )
                    }
                )
            }
        )
    }

    private func btnAnimateGo() {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            animations: {
                self.buttonPlus.layer.position.y -= 50
            },
            completion: {_ in
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0.8,
                    options: .curveEaseOut,
                    animations: {
                        self.buttonPlus.layer.position.y += 200
                    },
                    completion: {_ in
                        let root = NoteViewController()
                        self.navigationController?.pushViewController(root, animated: true)
                        root.delegate = self
                        UIView.animate(
                            withDuration: 0.8,
                            delay: 1,
                            animations: {
                                self.buttonPlus.isHidden = true
                                self.buttonPlus.layer.position.y -= 150
                            }
                        )
                    }
                )
            }
        )
    }
}
