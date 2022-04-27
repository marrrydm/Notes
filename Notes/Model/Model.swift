//
//  Model.swift
//  Notes
//
//  Created by Мария Ганеева on 02.04.2022.
//
//

import Foundation

struct Note {
    var title: String?
    var content: String
    var date: Date?
    var isEmpty: Bool {
        return content.isEmpty ? true : false
    }
}
