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
    var title = ""
    var content = ""
    var date = Date()

    convenience init(note: Note?) {
        self.init()
        titleLabel.text = note?.title
        print(titleLabel.text)
        contentLabel.text = note?.content
        dateLabel.text = note?.date?.formatted()
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 15, y: 10, width: 100, height: 100))
        self.backgroundColor = .blue
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
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 10
            )
            let trailingConstraint = titleLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            )
            let leadingConstraint = titleLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
            let bottomConstraint = titleLabel.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -62
            )
            let heightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 18)
            let widthConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 68)
            NSLayoutConstraint.activate([topConstraint,
                                         trailingConstraint,
                                         leadingConstraint,
                                         bottomConstraint,
                                         heightConstraint,
                                         widthConstraint])
        }

    private func constraintsContentLabel() {
            let topConstraint = contentLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 32
            )
            let trailingConstraint = contentLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            )
            let leadingConstraint = contentLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
            let bottomConstraint = contentLabel.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -44
            )
            let heightConstraint = contentLabel.heightAnchor.constraint(equalToConstant: 14)
            let widthConstraint = contentLabel.heightAnchor.constraint(equalToConstant: 68)
            NSLayoutConstraint.activate([topConstraint,
                                         trailingConstraint,
                                         leadingConstraint,
                                         bottomConstraint,
                                         heightConstraint,
                                         widthConstraint])
        }

    private func constraintsDateLabel() {
            let topConstraint = dateLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 70
            )
            let trailingConstraint = dateLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            )
            let leadingConstraint = dateLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
            let bottomConstraint = dateLabel.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -5
            )
            let heightConstraint = dateLabel.heightAnchor.constraint(equalToConstant: 25)
            let widthConstraint = dateLabel.heightAnchor.constraint(equalToConstant: 68)
            NSLayoutConstraint.activate([topConstraint,
                                         trailingConstraint,
                                         leadingConstraint,
                                         bottomConstraint,
                                         heightConstraint,
                                         widthConstraint])
        }
}
