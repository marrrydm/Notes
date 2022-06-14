//
//  Presenter.swift
//  Notes
//
//  Created by Мария Ганеева on 11.06.2022.
//

import UIKit

protocol ListPresentstionLogic {
    func present(data: Model.CleanNoteViewModel)
}

final class ListPresenter {
// MARK: External vars
    weak var listViewController: ListDisplayLogic?
}

// MARK: ListPresentstionLogic
extension ListPresenter: ListPresentstionLogic {
    func present(data: Model.CleanNoteViewModel) {
        listViewController?.display(data: data)
    }
}
