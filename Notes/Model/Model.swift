//
//  Model.swift
//  Notes
//
//  Created by Мария Ганеева on 02.04.2022.
//
//

import Foundation

final class Worker {
    let session = URLSession(configuration: .default)
    var workerNotes: [Worker.Note] = []

    struct Note: Decodable {
        var date: Date?
        var header: String?
        var text: String
        var isEmpty: Bool {
            return text.isEmpty ? true : false
        }
    }

    func func2() {
        guard let url = URL(string:
                                "https://firebasestorage.googleapis.com/v0/b/ios-test-ce687.appspot.com/o/Empty.json?alt=media&token=d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18") else {
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else {
                return
            }
            print(data)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                self.workerNotes = try! JSONDecoder().decode([Worker.Note].self, from: data)
                print(self.workerNotes)
                print(self.workerNotes.count)
            } catch {
                print(error)
            }
        }.resume()
    }
}
