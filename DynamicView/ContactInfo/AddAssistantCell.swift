//
//
//
//  Created by Mathias Claassen on 30/8/16.
//  Copyright © 2016 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

final class AddAssistantRow: Row<AddAssistantCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<AddAssistantCell>(nibName: "AddAssistant")
    }
}

final class AddAssistantCell: Cell<Assistant>, CellType {
    
    @IBOutlet weak var assistantImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextView: UITextField!
    @IBOutlet weak var middleNameTextView: UITextField!
    @IBOutlet weak var lastNameTextView: UITextField!
    @IBOutlet weak var phoneTextView: UITextField!
    @IBOutlet weak var emailTextView: UITextField!

    
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
        assistantImageView.contentMode = .scaleAspectFill
        assistantImageView.clipsToBounds = true

        // specify the desired height for our cell
        height = { return 208 }
        
        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)

        firstNameTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        middleNameTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        lastNameTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        phoneTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        emailTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)

    }
    
    override func update() {
        super.update()
        
        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil
        
        // get the value from our row
        guard let user = row.value else { return }

        // set the texts to the labels
        //emailLabel.text = user.email
        //nameLabel.text = user.name
        //dateLabel.text = AddAssistantCell.dateFormatter.string(from: user.dateOfBirth)
    }
    @objc
    open  func textFieldDidChange(_ textField: UITextField) {
        if self.row.value == nil{
            self.row.value = Assistant(firstName: "", middleName: "", lastName: "", phone: "", email: "")
        }
        switch (textField.tag) {
        case 10:
            self.row.value!.firstName = textField.text!
        case 11:
            self.row.value!.middleName = textField.text!
        case 12:
            self.row.value!.lastName = textField.text!
        case 13:
            self.row.value!.phone = textField.text!
        case 14:
            self.row.value!.email = textField.text!
        default:
            print("Default")
        }
    }
}

/*struct Assistant: Equatable {
    var firstName: String
    var middleName: String
    var lastName: String
    var phone: String
    var email: String
    
}

func ==(lhs: Assistant, rhs: Assistant) -> Bool {
    return lhs.email == rhs.email
}*/

