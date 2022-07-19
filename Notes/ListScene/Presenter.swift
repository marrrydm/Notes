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
        let modelData = Model.CleanNoteViewModel(
            header: data.header,
            text: data.text,
            date: data.date,
            id: data.id,
            img: data.img
        )
        listViewController?.display(data: modelData)
    }
}
