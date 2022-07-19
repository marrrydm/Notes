//
//  Model.swift
//  Notes
//
//  Created by Мария Ганеева on 14.06.2022.
//

import UIKit

enum Model {
    struct CheckIsEmpty {
        var text: String
        var isEmpty: Bool {
            return text.isEmpty ? true : false
        }
    }
    struct CleanNoteViewModel: Equatable, Decodable {
        var header: String
        var text: String
        var date: Date
        var id = UUID()
        var userShareIcon: URL?
        var imgData: Data?
        var img: UIImage?

        enum CodingKeys: CodingKey {
            case header
            case text
            case date
            case userShareIcon
        }
    }
}
