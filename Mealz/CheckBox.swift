//
//  CheckBox.swift
//  Mealz
//
//  Created by Seth Heywood on 4/26/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
// Code used from https://www.youtube.com/watch?v=ajlkFFPxW_c

import UIKit

class CheckBox: UIButton {
    
    let checked = UIImage(named: "checked_checkbox.png")
    let unChecked = UIImage(named: "checkbox-unchecked-md.png")
    
    
    var isChecked:Bool = false {
        didSet{
            if (isChecked == true) {
                self.setImage(checked, forState: .Normal)
            }
            else{
                self.setImage(unChecked, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        isChecked = false
    }
    
    func buttonClicked(sender:UIButton){
        if(sender == self){
            if (isChecked == true) {
                isChecked = false
            }
            else {
                isChecked = true
            }
        }
    }
   
    
    
}
