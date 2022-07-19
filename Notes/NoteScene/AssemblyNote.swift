//
//  AssemblyNote.swift
//  Notes
//
//  Created by Мария Ганеева on 17.06.2022.
//

import UIKit

enum AssemblyNote {
    static func buildNote() -> NoteViewController {
        let presenter = PresenterNote()
        let router = RouterNote()
        let interactor = InteractorNote()
        let viewController = NoteViewController()

        router.viewController = viewController
        interactor.presenter = presenter
        presenter.noteViewController = viewController
        router.dataStore = interactor
//        viewController.router = router
        return viewController
    }
}
