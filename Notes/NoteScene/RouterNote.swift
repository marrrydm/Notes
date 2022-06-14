//
//  RouterNote.swift
//  Notes
//
//  Created by Мария Ганеева on 12.06.2022.
//

import UIKit

protocol RouterNoteLogic {
    func navigateToNote(model: CleanNoteViewModel)
}

protocol RouterNoteDataPassingProtocol {
    var dataStore: InteractorNoteStoreProtocol? { get }
}

class RouterNote: RouterNoteDataPassingProtocol {
    var dataStore: InteractorNoteStoreProtocol?
    var router: RouterNoteLogic?
}

extension RouterNote: RouterNoteLogic {
    func navigateToNote(model: CleanNoteViewModel) {
        listViewController?.display(data: model)
    }
}
