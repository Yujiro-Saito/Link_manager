//
//  LinkViewController.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/04.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //Property
    @IBOutlet weak var link_table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tableview settings
        link_table.delegate = self
        link_table.dataSource = self

    }
    
    
    
    //Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cell
        let cell = link_table.dequeueReusableCell(withIdentifier: "link_table", for: indexPath) as? LinkTableViewCell
        
        cell?.selectionStyle = .none
        cell?.link_title.text = "Vapor: Server-side Swift."
        
        return cell!
        
    }

    

}
