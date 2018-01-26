//
//
//
//  Created by Mathias Claassen on 30/8/16.
//  Copyright © 2016 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka
import DropDown

final class AddEmailRow: Row<AddEmailCell> , RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<AddEmailCell>(nibName: "AddEmail")
    }
}

final class AddEmailCell: Cell<Email>, CellType{
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBAction func selectBtn(_ sender: Any) {
        
        let dropDown = DropDown()
        
        // The view to which the drop down will appear on
        dropDown.anchorView = relationLabel // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Office","Personal","Other"]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.relationLabel.text = item

            self.row.value = Email(emailType: self.relationLabel.text!, email: self.emailTextField.text!)
        }
        dropDown.show()
        
    }

    @IBOutlet weak var relationLabel: UILabel!
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
        
        // specify the desired height for our cell
        height = { return 51 }
        
        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)
        emailTextField.addTarget(self, action: #selector(AddEmailCell.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func update() {
        super.update()
        
        // get the value from our row
        //guard let user = row.value else { return }
        //emailTextField.text = user.email
        //relationLabel.text = user.emailType
    }

    @objc
    open  func textFieldDidChange(_ textField: UITextField) {
        row.value = Email(emailType: relationLabel.text!, email: textField.text!)
    }

}

struct Email: Equatable {
    var emailType: String
    var email: String
}

func ==(lhs: Email, rhs: Email) -> Bool {
    return lhs.email == rhs.email
}

