//
//  AddressInfoCell.swift
//
//  Created by Mathias Claassen on 30/8/16.
//  Copyright © 2016 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

final class AddAddressRow: Row<AddAddressCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<AddAddressCell>(nibName: "AddAddress")
    }
}

final class AddAddressCell: Cell<Address>, CellType {
    
    @IBOutlet weak var homeImageView: UIImageView!
    
    @IBOutlet weak var streetTextView: UITextField!
    
    @IBOutlet weak var stateTextView: UITextField!
    @IBOutlet weak var postalTextView: UITextField!
    @IBOutlet weak var countryTextView: UITextField!
    @IBOutlet weak var cityTextView: UITextField!
    @IBOutlet weak var unitTextView: UITextField!
   
    
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
        
        // configure our profile picture imageView
        homeImageView.contentMode = .scaleAspectFill
        homeImageView.clipsToBounds = true

        // specify the desired height for our cell
        height = { return 255 }
        
        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)

        streetTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        unitTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        cityTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        countryTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        postalTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)
        stateTextView.addTarget(self, action: #selector(AddPhoneCell.textFieldDidChange(_:)), for: .editingChanged)

    }
    
    override func update() {
        super.update()
        
        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil

    }

    @objc
    open  func textFieldDidChange(_ textField: UITextField) {
        if self.row.value == nil{
            self.row.value = Address(street: "", stateProvince: "", zip: "", country: "", city: "", unit: "")
        }
        switch (textField.tag) {
        case 10:
            self.row.value!.street = textField.text!
        case 11:
            self.row.value!.unit = textField.text!
        case 12:
            self.row.value!.city = textField.text!
        case 13:
            self.row.value!.country = textField.text!
        case 14:
            self.row.value!.zip = textField.text!
        case 15:
            self.row.value!.stateProvince = textField.text!
        default:
            print("Default")
        }
    }
    
}

/*struct Address: Equatable {
    var street: String
    var stateProvince: String
    var zip: String
    var country: String
    var city: String
    var unit: String
}

func ==(lhs: Address, rhs: Address) -> Bool {
    return lhs.street == rhs.street
}*/

