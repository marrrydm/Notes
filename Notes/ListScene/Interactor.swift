//
//  Interactor.swift
//  Notes
//
//  Created by Мария Ганеева on 11.06.2022.
//

import UIKit

protocol ListBusinessLogic {
    func fetchNotes(model: Model.CleanNoteViewModel)
    func loadNotes()
}

final class ListInteractor: InteractorNoteStoreProtocol {
    var img: UIImage = .init()
    var header: String = ""
    var text: String = ""
    var date: Date = .now
    var id = UUID()

// MARK: External vars
    var presenter: ListPresentstionLogic?
    var worker: CleanWorker?
}

// MARK: ListBusinessLogic
extension ListInteractor: ListBusinessLogic {
    func loadNotes() {
        worker = CleanWorker()
        worker?.getJSON()
        worker?.closureNotes = { [weak self] name in
            self?.presenter?.present(data: name)
        }
    }

    func fetchNotes(model: Model.CleanNoteViewModel) {
        presenter?.present(data: model)
    }
}
