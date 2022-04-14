//
//  ViewModel.swift
//  Notes
//
//  Created by Мария Ганеева on 11.04.2022.
//

import Foundation
import UIKit

class NoteViewCell: UIView {
    private var newView = UIView()
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    private var dateLabel = UILabel()

    struct Model {
        let title: String
        let content: String
        let date: Date
    }

    public func setModel(model: NoteViewCell.Model) {
        titleLabel.text = model.title
        contentLabel.text = model.content
        dateLabel.text = model.date.formatted()
    }

    convenience init(note: NoteViewCell.Model) {
        self.init()
        setModel(model: note)
        print(note)
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 15, y: 10, width: 358, height: 90))
        self.backgroundColor = .red
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.white.cgColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(dateLabel)
        setupLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabels() {
            constraintsTitleLabel()
            constraintsContentLabel()
            constraintsDateLabel()
        }

    private func constraintsTitleLabel() {
            let topConstraint = titleLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 10
            )
            let trailingConstraint = titleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            )
            let leadingConstraint = titleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            )
            let heightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 18)
            let widthConstraint = titleLabel.widthAnchor.constraint(equalToConstant: 300)
            NSLayoutConstraint.activate([topConstraint,
                                         trailingConstraint,
                                         leadingConstraint,
                                         heightConstraint,
                                         widthConstraint])
        }

    private func constraintsContentLabel() {
            let topConstraint = contentLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 4
            )
            let trailingConstraint = contentLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            )
            let leadingConstraint = contentLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            )
            let heightConstraint = contentLabel.heightAnchor.constraint(equalToConstant: 14)
            let widthConstraint = contentLabel.widthAnchor.constraint(equalToConstant: 326)
            NSLayoutConstraint.activate([topConstraint,
                                         trailingConstraint,
                                         leadingConstraint,
                                         heightConstraint,
                                         widthConstraint])
        }

    private func constraintsDateLabel() {
            let topConstraint = dateLabel.topAnchor.constraint(
                equalTo: contentLabel.topAnchor,
                constant: 24
            )
            let trailingConstraint = dateLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            )
            let leadingConstraint = dateLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            )
            let bottomConstraint = dateLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -10
            )
            let heightConstraint = dateLabel.heightAnchor.constraint(equalToConstant: 10)
            let widthConstraint = dateLabel.widthAnchor.constraint(equalToConstant: 68)
            NSLayoutConstraint.activate([topConstraint,
                                         trailingConstraint,
                                         leadingConstraint,
                                         bottomConstraint,
                                         heightConstraint,
                                         widthConstraint])
        }
}
