//
//  PresenterNote.swift
//  Notes
//
//  Created by Мария Ганеева on 12.06.2022.
//

import UIKit

protocol PresentstionLogic {
    func present(data: Model.CleanNoteViewModel)
}

final class PresenterNote {
// MARK: External vars
    weak var noteViewController: NoteDisplayLogic?
}

// MARK: ListPresentstionLogic
extension PresenterNote: PresentstionLogic {
    func present(data: Model.CleanNoteViewModel) {
        let dataModel = Model.CleanNoteViewModel(
            header: data.header,
            text: data.text,
            date: data.date,
            id: data.id,
            img: data.img
        )
        noteViewController?.display(data: dataModel)
    }
}
