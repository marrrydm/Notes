//
//  InteractorNote.swift
//  Notes
//
//  Created by Мария Ганеева on 12.06.2022.
//

import UIKit

protocol InteractorNoteBusinessLogic {
    func fetchNote()
}

protocol InteractorNoteStoreProtocol: AnyObject {
    var id: UUID { get set }
    var header: String { get set }
    var text: String { get set }
    var date: Date { get set }
    var img: UIImage { get set }
}

class InteractorNote: InteractorNoteStoreProtocol {
    var img: UIImage = .init()
    var header: String = ""
    var text: String = ""
    var date: Date = .now
    var id = UUID()
    var presenter: PresentstionLogic?
}

extension InteractorNote: InteractorNoteBusinessLogic {
    func fetchNote() {
        let note = Model.CleanNoteViewModel(header: header, text: text, date: date, id: id, img: img)
        presenter?.present(data: note)
    }
}
