//
//  Router.swift
//  Notes
//
//  Created by Мария Ганеева on 11.06.2022.
//

import UIKit

protocol ListRouterLogic {
    func navigate(note: Model.CleanNoteViewModel)
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
        let controller = AssemblyNote.buildNote()
        noteController?.navigationController?.pushViewController(controller, animated: true)
    }

    func navigate(note: Model.CleanNoteViewModel) {
        let noteViewController = AssemblyNote.buildNote()
        noteController?.navigationController?.pushViewController(noteViewController, animated: true)
        noteViewController.router?.dataStore?.id = note.id
        noteViewController.router?.dataStore?.header = note.header
        noteViewController.router?.dataStore?.text = note.text
        noteViewController.router?.dataStore?.date = note.date
        if note.img != nil {
        noteViewController.router?.dataStore?.img = note.img!
        }
    }
}
