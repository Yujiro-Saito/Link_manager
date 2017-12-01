//
//  ViewController.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/11/29.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //Property
    @IBOutlet weak var folder_table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate
        self.folder_table.delegate = self
        self.folder_table.dataSource = self
    }
    
    
    //Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cell
        let cell = self.folder_table.dequeueReusableCell(withIdentifier: "folder_table", for: indexPath) as? FolderTableViewCell
        
        cell?.folder_name.text = "Data_Science"
        
        return cell!
    }
    
    
    
}

