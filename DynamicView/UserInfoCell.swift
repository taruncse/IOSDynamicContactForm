//
//  UserInfoCell.swift
//
//  Created by Mathias Claassen on 30/8/16.
//  Copyright © 2016 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

final class UserInfoRow: Row<UserInfoCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<UserInfoCell>(nibName: "UserInfoCell")
    }
}

final class UserInfoCell: Cell<User>, CellType {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setup() {
        super.setup()
        // we do not want our cell to be selected in this case. If you use such a cell in a list then you might want to change this.
        selectionStyle = .none

        // configure our profile picture imageView
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true

        // define fonts for our labels

        nameLabel.font = .systemFont(ofSize: 18)
        emailLabel.font = .systemFont(ofSize: 13.3)
        dateLabel.font = .systemFont(ofSize: 13.3)

        // set the textColor for our labels
        for label in [emailLabel, dateLabel, nameLabel] {
            label?.textColor = .gray
        }

        // specify the desired height for our cell
        height = { return 94 }

        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)
    }

    override func update() {
        super.update()

        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil

        // get the value from our row
        guard let user = row.value else { return }

        // set the image to the userImageView. You might want to do this with AlamofireImage or another similar framework in a real project
        if let url = user.pictureUrl, let data = try? Data(contentsOf: url) {
            userImageView.image = UIImage(data: data)
        } else {
            userImageView.image = UIImage(named: "placeholder")
        }

        // set the texts to the labels
        emailLabel.text = user.email
        nameLabel.text = user.name
        dateLabel.text = UserInfoCell.dateFormatter.string(from: user.dateOfBirth)
    }
}

struct User: Equatable {
    var name: String
    var email: String
    var dateOfBirth: Date
    var pictureUrl: URL?
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.email == rhs.email
}
