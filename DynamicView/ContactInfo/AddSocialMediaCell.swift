//
//
//
//  Created by Mathias Claassen on 30/8/16.
//  Copyright © 2016 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

final class AddSocialMediaRow: Row<AddSocialMediaCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<AddSocialMediaCell>(nibName: "AddSocialMedia")
    }
}

final class AddSocialMediaCell: Cell<SocialMedia>, CellType {
    
    @IBOutlet weak var facebookTextView: UITextField!
    @IBOutlet weak var twitterTextView: UITextField!
    @IBOutlet weak var linkedInTextView: UITextField!
    @IBOutlet weak var websiteTextView: UITextField!

   
    
    //@IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var emailLabel: UILabel!
    //@IBOutlet weak var dateLabel: UILabel!
    
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

        height = { return 170 }
        
        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)

        facebookTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        twitterTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        linkedInTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        websiteTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func update() {
        super.update()
        
        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil
        
        // get the value from our row
        guard let user = row.value else { return }

    }
    @objc
    open  func textFieldDidChange(_ textField: UITextField) {
        if self.row.value == nil{
            self.row.value = SocialMedia(facebook: "", twitter: "", linkedIn: "", website: "")
        }
        switch (textField.tag) {
        case 10:
            self.row.value!.facebook = textField.text!
        case 11:
            self.row.value!.twitter = textField.text!
        case 12:
            self.row.value!.linkedIn = textField.text!
        case 13:
            self.row.value!.website = textField.text!
        default:
            print("Default")
        }
    }
    
}

struct SocialMedia: Equatable {
    var facebook: String
    var twitter: String
    var linkedIn: String
    var website: String
}

func ==(lhs: SocialMedia, rhs: SocialMedia) -> Bool {
    return lhs.facebook == rhs.facebook
}

