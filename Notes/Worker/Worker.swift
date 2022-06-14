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
    private var array: [NoteViewModel] = []
    private var image: Data?
    private var photo: UIImage?

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
        session.dataTask(with: url) { [self] (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                // сессия поддерживает сильную ссылку до тех пор, пока запрос не завершится или не завершится ошибкой
                let group = DispatchGroup()
                self.workerNotes = try JSONDecoder().decode([NoteViewModel].self, from: data)
                for var note in self.workerNotes {
                    if note.userShareIcon != nil {
                        guard let urlImg = note.userShareIcon, let data = try? Data(contentsOf: urlImg)
                        else { return }
                        if data == data {
                            note.imgData = data
                            note.img = UIImage(data: note.imgData!)
                        }
                    }
                    array.append(note)
                }
                for note in array {
                    group.notify(queue: DispatchQueue.main, execute: {
                        self.closureNotes?(
                            NoteViewModel(
                                header: note.header,
                                text: note.text,
                                date: note.date,
                                userShareIcon: note.userShareIcon,
                                img: note.img
                            )
                        )
                    }
                    )
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
