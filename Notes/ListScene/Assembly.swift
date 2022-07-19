//
//  Assembly.swift
//  Notes
//
//  Created by Мария Ганеева on 15.06.2022.
//

import UIKit

enum Assembly {
    static func build() -> CleanListViewController {
        let viewController = CleanListViewController()
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.listViewController = viewController
        router.dataStore = interactor
        router.noteController = viewController

        return viewController
    }
}
