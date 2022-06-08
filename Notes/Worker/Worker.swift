//
//  Worker.swift
//  Notes
//
//  Created by Мария Ганеева on 26.05.2022.
//

import UIKit

final class Worker {
// MARK: - Properties
    var closureNotes: ((NoteViewModel) -> Void)?

// MARK: - Private Properties
    private let session = URLSession(configuration: .default)
    private var workerNotes: [NoteViewModel] = []

    init() {
        print("Инициализация Worker")
    }

    deinit {
        print("Деинициализация Worker")
    }

// MARK: - Methods
    func getJSON() {
        guard let url = URL(
            string: "https://firebasestorage.googleapis.com/" +
            "v0/b/ios-test-ce687.appspot.com/o/lesson8." +
            "json?alt=media&token=215055df-172d-4b98-95a0-b353caca1424"
        ) else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                // сессия поддерживает сильную ссылку до тех пор, пока запрос не завершится или не завершится ошибкой
                self.workerNotes = try JSONDecoder().decode([NoteViewModel].self, from: data)
                for workerNote in self.workerNotes {
                    self.closureNotes?(
                        NoteViewModel(
                            header: workerNote.header,
                            text: workerNote.text ,
                            date: workerNote.date,
                            userShareIcon: workerNote.userShareIcon
                        )
                    )
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
