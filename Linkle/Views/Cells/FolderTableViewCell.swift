//
//  FolderTableViewCell.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/02.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {
    
    //Property
    @IBOutlet weak var folder_name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.folder_name.layer.masksToBounds = true
        self.folder_name.layer.cornerRadius = 5.0
        
    }

    

}
