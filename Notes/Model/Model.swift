//
//  Model.swift
//  Notes
//
//  Created by Мария Ганеева on 02.04.2022.
//
//

import Foundation

struct Note {
    var date: Date?
    var header: String?
    var text: String
    var isEmpty: Bool {
        return text.isEmpty ? true : false
    }
}

final class Worker {
// MARK: - Properties
    var closureNotes: ((NoteViewModel) -> Void)?

// MARK: - Private Properties
    private let session = URLSession(configuration: .default)
    private var workerNotes: [NoteViewModel] = []

// MARK: - Methods
    func getJSON() {
        guard let url = URL(
            string: "https://firebasestorage.googleapis.com/v0/b/ios-test-ce687.appspot.com/o/Empty.json?alt=media&token=d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18"
        ) else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                self.workerNotes = try JSONDecoder().decode([NoteViewModel].self, from: data)
                for workerNote in self.workerNotes {
                    self.closureNotes?(
                        NoteViewModel(
                            header: workerNote.header,
                            text: workerNote.text ,
                            date: workerNote.date
                        )
                    )
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
