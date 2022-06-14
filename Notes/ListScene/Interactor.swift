//
//  Interactor.swift
//  Notes
//
//  Created by Мария Ганеева on 11.06.2022.
//

import UIKit

protocol ListBusinessLogic {
    func fetchNotes(model: CleanNoteViewModel)
}

final class ListInteractor: InteractorNoteStoreProtocol {
    var header: String = ""
    var text: String = ""
    var date: Date = .now
    var id = UUID()
    var img: UIImage?

// MARK: External vars
    var presenter: ListPresentstionLogic?
}

// MARK: ListBusinessLogic
extension ListInteractor: ListBusinessLogic {
    func fetchNotes(model: CleanNoteViewModel) {
        presenter?.present(data: model)
    }
}
