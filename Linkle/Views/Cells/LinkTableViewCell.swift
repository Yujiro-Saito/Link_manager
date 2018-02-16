//
//  LinkTableViewCell.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/04.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    //Prpoerty
    @IBOutlet weak var link_title: UILabel!
    @IBOutlet weak var link_view: UIView!
    @IBOutlet weak var link_url: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.link_view.layer.masksToBounds = true
        self.link_view.layer.cornerRadius = 7.5
        
        self.link_view.layer.shadowColor = UIColor.red.cgColor
        self.link_view.layer.shadowOffset = CGSize(width: 30, height: 30)
        self.link_view.layer.shadowOpacity = 1.0
        self.link_view.layer.shadowRadius = 7.5
        
    }

    

}
