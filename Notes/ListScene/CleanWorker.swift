//
//  Worker.swift
//  Notes
//
//  Created by Мария Ганеева on 11.06.2022.
//

import UIKit

final class CleanWorker {
    // MARK: - Properties
    var closureNotes: ((Model.CleanNoteViewModel) -> Void)?

    // MARK: - Private Properties
        private let session = URLSession(configuration: .default)
        private var workerNotes: [Model.CleanNoteViewModel] = []
        private var array: [Model.CleanNoteViewModel] = []
        private var image: Data?
        private var photo: UIImage?

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
                    let group = DispatchGroup()
                    self.workerNotes = try JSONDecoder().decode([Model.CleanNoteViewModel].self, from: data)
                    group.enter()
                    for var note in self.workerNotes {
                        if note.userShareIcon != nil {
                            group.enter()
                            guard let urlImg = note.userShareIcon, let data = try? Data(contentsOf: urlImg)
                            else { return }
                            if !data.isEmpty {
                                note.imgData = data
                                note.img = UIImage(data: note.imgData!)
                            }
                            group.leave()
                        }
                        array.append(note)
                    }
                    group.leave()
                    for note in array {
                        group.notify(queue: DispatchQueue.main, execute: {
                            self.closureNotes?(
                                Model.CleanNoteViewModel(
                                    header: note.header,
                                    text: note.text,
                                    date: note.date,
                                    id: note.id,
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
