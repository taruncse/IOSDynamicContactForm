//
//  ViewController.swift
//  DynamicView
//
//  Created by Tarun Kumar on 2017-12-06.
//  Copyright © 2017 Tarun Kumar. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

class ViewController: FormViewController {
    func addBackButton() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 100))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Create Contact");
        let cancle = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: nil, action: #selector(backButtonPressed));
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: #selector(createContact));
        navItem.leftBarButtonItem = cancle;
        navItem.rightBarButtonItem = add;
        navBar.setItems([navItem], animated: false);
    }

    @objc func createContact(){
        let valuesDictionary = form.values() as NSDictionary
        print("\(valuesDictionary)")

    }
    @objc func backButtonPressed() {
        
        //let row: AddEmailRow? = form.sectionBy(tag:"tagMultipleEmail")
        //let values = row?.title
      
        // Get the value of all rows which have a Tag assigned
        // The dictionary contains the 'rowTag':value pairs.
        //let valuesDictionary = form.values() as NSDictionary
//        let multipleEmail = valuesDictionary.value(forKey: "tagMultiplePhone")// as! [User]
        //print("\(valuesDictionary)")
         //print("\(form.values())")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackButton()
        // Enables the navigation accessory and stops navigation when a disabled row is encountered
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        // Enables smooth scrolling on navigation to off-screen rows
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 20
        
        form +++ Section("")

        form +++ Section("Name")
            <<< TextRow(){ row in
                //row.title = "Text Row"
                row.tag = "tagNameFirstName"
                row.placeholder = "First Name (Required)"
            }
            <<< TextRow(){ row in
                row.tag = "tagNameMiddleName"
                row.placeholder = "Middle Name"
            }
            <<< TextRow(){ row in
                row.tag = "tagNameLastName"
                row.placeholder = "Last Name (Required)"
            }
        
            +++ Section("Profile Picture")
            <<< ImageRow(){
                $0.tag = "profilePicture"
                $0.title = "Select Image"
            }
             +++ Section("Relations picker")
            <<< PickerInputRow<String>("Picker Input Row"){
                $0.title = "Relations"
                $0.options = ["Family","Business","Friend","Acquaintance"]
                $0.value = $0.options.first
        } +++ Section("Contact")
            <<< TextRow(){ row in
                row.tag = "tagContactPhone"
                row.placeholder = "Cell/Phone"
        }

        +++
        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete]) {

            $0.addButtonProvider = { _ in return ButtonRow {
                $0.title = "Add Phone Number"
            }.cellUpdate { cell, row in
                cell.textLabel?.textAlignment = .left
            }
            }
            $0.tag = "tagMultiplePhone"
            $0.multivaluedRowToInsertAt = { index in

                return AddPhoneRow()
            }
        }


       form +++ Section("Email")
     //+++ Section("Contact")
            <<< TextRow(){ row in
                //row.title = "Text Row"
                row.tag = "tagEmail"
                row.placeholder = "Primary Email (Required)"
        }
        +++
        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete]) {

            $0.addButtonProvider = { _ in return ButtonRow {
                $0.title = "Add Email "
            }.cellUpdate { cell, row in
                cell.textLabel?.textAlignment = .left
            }
            }
            $0.tag = "tagMultipleEmail"
            $0.multivaluedRowToInsertAt = { index in

                return AddEmailRow()
            }
        }



        +++
        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete]) {
            
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add Assistant"
                    }.cellUpdate { cell, row in
                        cell.textLabel?.textAlignment = .left
                }
            }
            $0.tag = "tagAddAssistantRow"
            $0.multivaluedRowToInsertAt = { index in
                
                return AddAssistantRow()
            }

        }



        +++
        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete]) {
            
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add Address"
                    }.cellUpdate { cell, row in
                        cell.textLabel?.textAlignment = .left
                }
            }
            $0.tag = "tagAddAddressRow"
            $0.multivaluedRowToInsertAt = { index in

                 return AddAddressRow()
            }
        }
        
        
        +++
        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete]) {
            
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add Social Media"
                    }.cellUpdate { cell, row in
                        cell.textLabel?.textAlignment = .left
                }
            }
            $0.tag = "tagAddSocialMediaRow"
            $0.multivaluedRowToInsertAt = { index in

                if(index==0){
                   return AddSocialMediaRow()
                }else{
                    return ButtonRow(){
                        $0.title = "You can't add more than one row here."
                        }.cellUpdate { cell, row in
                            cell.textLabel?.textAlignment = .left
                    }
                }
            }
        }
        
        
        +++
        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete]) {
            
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add Family Member"
                    }.cellUpdate { cell, row in
                        cell.textLabel?.textAlignment = .left
                }
            }
            $0.tag = "tagAddFamilyRow"
            $0.multivaluedRowToInsertAt = { index in
                return AddFamilyRow(){  index in
                    print("position \(index.baseCell.baseRow)")
                }
             
            }
        }
    
    
    class EurekaLogoViewNib: UIView {
        
        @IBOutlet weak var imageView: UIImageView!
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    
     class CustomCell: Cell<Bool>, CellType {
        //@IBOutlet weak var switchControl: UISwitch!
        //@IBOutlet weak var label: UILabel!
        
        public override func setup() {
            super.setup()
            //switchControl.addTarget(self, action: #selector(CustomCell.switchValueChanged), for: .valueChanged)
        }
        
        @objc func switchValueChanged(){
            //row.value = switchControl.isOn
            //row.updateCell() // Re-draws the cell which calls 'update' bellow
        }
        
        public override func update() {
            super.update()
            //backgroundColor = (row.value ?? false) ? .white : .black
        }
    }
    
    // The custom Row also has the cell: CustomCell and its correspond value
     final class CustomRow: Row<CustomCell>, RowType {
        required public init(tag: String?) {
            super.init(tag: tag)
            // We set the cellProvider to load the .xib corresponding to our cell
            cellProvider = CellProvider<CustomCell>(nibName: "CustomeUI")
        }
    }
    }
}

//title = "Multivalued Examples"
/*form +++
    MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete]) {
                        //$0.tag = "tagAddPhone"
                        $0.addButtonProvider = { _ in return ButtonRow {
                                $0.title = "Add Tag"
                            }.cellUpdate { cell, row in
                                cell.textLabel?.textAlignment = .left
                            }
                        }

                        $0.tag = "tagMultiplePhone"
                        $0.multivaluedRowToInsertAt = { index in
                            return UserInfoRow {
                                $0.title = "Date"
                            }
                            .onChange { row in
                                if let str = row.cell.emailLabel.text {
                                    print(str)
                                }

                            }

                            //return AddPhoneRow()
                            //return UserInfoRow()
//                                    let row = UserInfoRow(tag: "phninfo2")
//                                    row.value = User(name: "Mathias",
//                                            email: "mathias@xmartlabs.com",
//                                            dateOfBirth: Date(timeIntervalSince1970: 712119600),
//                                            pictureUrl: URL(string: "http://lh4.ggpht.com/VpeucXbRtK2pmVY6At76vU45Q7YWXB6kz25Sm_JKW1tgfmJDP3gSAlDwowjGEORSM-EW=w300"))
//
//                                    return row
}*/