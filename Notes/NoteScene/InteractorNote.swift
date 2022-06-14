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
}

class InteractorNote: InteractorNoteStoreProtocol {
    var header: String = ""
    var text: String = ""
    var date: Date = .now
    var id = UUID()
    var img: UIImage?
    var presenter: PresentstionLogic?
}

extension InteractorNote: InteractorNoteBusinessLogic {
    func fetchNote() {
        let note = CleanNoteViewModel(header: header, text: text, date: date, id: id, img: img)
        presenter?.present(data: note)
    }
}
