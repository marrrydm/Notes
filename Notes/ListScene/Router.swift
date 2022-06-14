//
//  Router.swift
//  Notes
//
//  Created by Мария Ганеева on 11.06.2022.
//

import UIKit

protocol ListRouterLogic {
    func navigate(note: CleanNoteViewModel)
    func navigateNew()
}

protocol RouterNoteDataProtocol {
    var dataStore: InteractorNoteStoreProtocol? { get }
}

final class ListRouter: RouterNoteDataProtocol {
    weak var noteController: UIViewController?
    weak var dataStore: InteractorNoteStoreProtocol?
}

extension ListRouter: ListRouterLogic {
    func navigateNew() {
        let controller = NoteViewController()
        noteController?.navigationController?.pushViewController(controller, animated: true)
    }

    func navigate(note: CleanNoteViewModel) {
        let noteViewController = NoteViewController()
        noteController?.navigationController?.pushViewController(noteViewController, animated: true)
        noteViewController.router?.dataStore?.id = note.id
        noteViewController.router?.dataStore?.header = note.header
        noteViewController.router?.dataStore?.text = note.text
        noteViewController.router?.dataStore?.date = note.date
    }
}
