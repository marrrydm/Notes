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

// MARK: External vars
    var presenter: ListPresentstionLogic? // ссылка на презентер
}

// MARK: ListBusinessLogic
extension ListInteractor: ListBusinessLogic {
    func fetchNotes(model: CleanNoteViewModel) {
//        let note = CleanNoteViewModel(header: model.header, text: model.text, date: model.date)
        presenter?.present(data: model) /// вызываем данные у презентера когда мы их получили (отдаем в презентер)
    }
}
