import Foundation
import UIKit


class InvitedCustomerCollectionViewCell: UICollectionViewCell {

    /// cell content view
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// image view for icon
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    /// label for customer name
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.appFontBold, size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// label for user id
    let userIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.appFontDemiBold, size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addSubviews() {
        contentView.addSubview(cellView)
        cellView.addSubview(iconImageView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(userIdLabel)

        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            iconImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 45),

            nameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: -14),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -14),

            userIdLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            userIdLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 14),
            userIdLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -14),
        ])
    }
}


