//
//  RouterNote.swift
//  Notes
//
//  Created by Мария Ганеева on 12.06.2022.
//

import UIKit

protocol RouterNoteLogic {
    func navigateToNote(model: Model.CleanNoteViewModel)
}

protocol RouterNoteDataPassingProtocol {
    var dataStore: InteractorNoteStoreProtocol? { get }
}

class RouterNote: RouterNoteDataPassingProtocol {
    var dataStore: InteractorNoteStoreProtocol?
    var router: RouterNoteLogic?
    var presenter: ListPresenter?
    weak var viewController: UIViewController?
}

extension RouterNote: RouterNoteLogic {
    func navigateToNote(model: Model.CleanNoteViewModel) {
        let modelNote = Model.CleanNoteViewModel(
            header: model.header,
            text: model.text,
            date: model.date,
            id: model.id,
            img: model.img
        )
        root.interactor?.fetchNotes(model: modelNote)
    }
}
