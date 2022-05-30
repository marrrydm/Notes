//
//  ViewModel.swift
//  Notes
//
//  Created by Мария Ганеева on 11.04.2022.
//

import UIKit

struct NoteViewModel: Equatable, Decodable {
    var header: String
    var text: String
    var date: Date
    var id = UUID()
    var userShareIcon: String?
    var isEmpty: Bool {
        return text.isEmpty ? true : false
    }

    enum CodingKeys: CodingKey {
        case header
        case text
        case date
        case userShareIcon
    }
}

final class NoteViewCell: UITableViewCell {
// MARK: - Private Properties

    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    private var dateLabel = UILabel()
    private var userShareIcon = UILabel()
    private var userShareIconImg = UIImageView()
    private let dateFormatter = DateFormatter()

// MARK: - Init

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

// MARK: - Methods

    func updateNotes(note: NoteViewModel) {
        setModel(model: note)
        if note.userShareIcon != nil {
            setImg(model: note)
        }
    }

    func setImg(model: NoteViewModel) {
        let url = URL(string: model.userShareIcon ?? "!!")
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.userShareIconImg.image = UIImage(data: data)
            }
        }
        task.resume()
    }

    func setModel(model: NoteViewModel) {
        dateFormatter.dateFormat = Constants.outputDate
        titleLabel.text = model.header
        contentLabel.text = model.text
        dateLabel.text = dateFormatter.string(from: model.date)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if editing == true {
            setupUpdate()
            setupSelected()
        }
    }

// MARK: - Private Methods

    private func configureUI() {
        frame = CGRect(x: 0, y: 0, width: 358, height: 90)
        layer.backgroundColor = Constants.backgroundColor
        layer.cornerRadius = CGFloat(Constants.cornerRadius)
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .white

        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        addSubview(userShareIcon)
        addSubview(userShareIconImg)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        userShareIcon.translatesAutoresizingMaskIntoConstraints = false
        userShareIconImg.translatesAutoresizingMaskIntoConstraints = false

        setupLabels()
        setupImage()
    }

    private func setupUpdate() {
        contentView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        contentView.layer.borderWidth = 0.2
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .white
        layer.cornerRadius = CGFloat(Constants.cornerRadius)
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .white
    }

    private func setupSelected() {
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        backgroundView.layer.borderWidth = Constants.borderWidth
        backgroundView.layer.borderColor = UIColor.white.cgColor
        backgroundView.backgroundColor = UIColor.white
        selectedBackgroundView = backgroundView
    }

    private func setupImage() {
        userShareIcon.addSubview(userShareIconImg)
        constraintsImage()
        constraintsImageView()
    }

    private func constraintsImageView() {
        let topConstraint = userShareIconImg.topAnchor.constraint(
            equalTo: self.contentView.topAnchor,
            constant: 56
        )
        let trailingConstraint = userShareIconImg.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: 318
        )
        let leadingConstraint = userShareIconImg.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -10
        )
        let heightConstraint = userShareIconImg.heightAnchor.constraint(equalToConstant: 24)
        let widthConstraint = userShareIconImg.widthAnchor.constraint(equalToConstant: 24)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

    private func constraintsImage() {
        let topConstraint = userShareIcon.topAnchor.constraint(
            equalTo: self.contentView.topAnchor,
            constant: 56
        )
        let trailingConstraint = userShareIcon.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: 318
        )
        let leadingConstraint = userShareIcon.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -10
        )
        let heightConstraint = userShareIcon.heightAnchor.constraint(equalToConstant: 24)
        let widthConstraint = userShareIcon.widthAnchor.constraint(equalToConstant: 24)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

    private func setupLabels() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.font = .systemFont(ofSize: 10, weight: .bold)
        contentLabel.textColor = Constants.contentLabelBackgroundColor

        constraintsTitleLabel()
        constraintsContentLabel()
        constraintsDateLabel()
    }

    private func constraintsTitleLabel() {
        let topConstraint = titleLabel.topAnchor.constraint(
            equalTo: self.contentView.topAnchor,
            constant: 10
        )
        let trailingConstraint = titleLabel.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = titleLabel.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -16
        )
        let heightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 18)
        let widthConstraint = titleLabel.widthAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

    private func constraintsContentLabel() {
        let topConstraint = contentLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: 4
        )
        let trailingConstraint = contentLabel.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = contentLabel.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -16
        )
        let heightConstraint = contentLabel.heightAnchor.constraint(equalToConstant: 14)
        let widthConstraint = contentLabel.widthAnchor.constraint(equalToConstant: 326)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

    private func constraintsDateLabel() {
        let topConstraint = dateLabel.topAnchor.constraint(
            equalTo: contentLabel.bottomAnchor,
            constant: 24
        )
        let trailingConstraint = dateLabel.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = dateLabel.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -16
        )
        let bottomConstraint = dateLabel.bottomAnchor.constraint(
            equalTo: self.contentView.bottomAnchor,
            constant: -10
        )
        let heightConstraint = dateLabel.heightAnchor.constraint(equalToConstant: 10)
        let widthConstraint = dateLabel.widthAnchor.constraint(equalToConstant: 68)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            bottomConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

// MARK: - Constants

    enum Constants {
        static let id = "Cell"
        static let titleBBT = ""
        static let backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        static let contentLabelBackgroundColor = UIColor(red: 0.172, green: 0.172, blue: 0.172, alpha: 1)
        static let outputDate = "dd.MM.yyyy"
        static let cornerRadius = 14
        static let borderWidth = 0.2
    }
}

//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in //чтобы проще было делать деинит, если будет какая то ссылка
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
////                    DispatchQueue.main.async {
//                        self?.image = image
////                    }
//                }
//            }
//        }
//    }
//}
