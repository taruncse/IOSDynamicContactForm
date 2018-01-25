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
        
        // define fonts for our labels
        
        //nameLabel.font = .systemFont(ofSize: 18)
        //emailLabel.font = .systemFont(ofSize: 13.3)
        //dateLabel.font = .systemFont(ofSize: 13.3)
        
        // set the textColor for our labels
        //for label in [emailLabel, dateLabel, nameLabel] {
        //    label?.textColor = .gray
        //}
        
        // specify the desired height for our cell
        height = { return 255 }
        
        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)
    }
    
    override func update() {
        super.update()
        
        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil
        
        // get the value from our row
        //guard let user = row.value else { return }
        
        // set the image to the homeImageView. You might want to do this with AlamofireImage or another similar framework in a real project
        //if let url = user.state, let data = try? Data(contentsOf: url) {
            //homeImageView.image = UIImage(data: data)
        //} else {
            homeImageView.image = UIImage(named: "placeholder")
        //}
        
        // set the texts to the labels
        //emailLabel.text = user.email
        //nameLabel.text = user.name
        //dateLabel.text = AddAddressCell.dateFormatter.string(from: user.dateOfBirth)
    }
    
}

struct Address: Equatable {
    var street: String
    var state: String
    var postal: String
    var country: String
    var city: String
    var unit: String
}

func ==(lhs: Address, rhs: Address) -> Bool {
    return lhs.street == rhs.street
}

