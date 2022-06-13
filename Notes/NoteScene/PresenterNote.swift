//
//  PresenterNote.swift
//  Notes
//
//  Created by Мария Ганеева on 12.06.2022.
//

import UIKit

protocol PresentstionLogic {
    func present(data: CleanNoteViewModel)
}

final class PresenterNote {
// MARK: External vars
    weak var noteViewController: NoteDisplayLogic?
}

// MARK: ListPresentstionLogic
extension PresenterNote: PresentstionLogic {
    func present(data: CleanNoteViewModel) {
        noteViewController?.display(data: data)
    }
}
