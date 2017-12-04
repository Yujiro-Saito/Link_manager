//
//  ViewController.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/11/29.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //Property
    @IBOutlet weak var folder_table: UITableView!
    let realm = try! Realm()
    var folderName: Results<FolderName> {
        
        get {
            return realm.objects(FolderName.self)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate
        self.folder_table.delegate = self
        self.folder_table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //ナビゲーションを透明にする
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }

    
    //Compose Button
    @IBAction func composeDidTap(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "フォルダ名", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
            
        }
        
        
        let action_cancel = UIAlertAction.init(title: "キャンセル", style: .cancel) { (UIAlertAction) -> Void in
            
        }
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "追加", style: .default) { (UIAlertAction) -> Void in
            
            let textField_todo = (alertController.textFields?.first)! as UITextField
            
            
            let folder_name = FolderName()
            folder_name.name = textField_todo.text!
            
            
            try! self.realm.write {
                self.realm.add(folder_name)
                self.folder_table.insertRows(at: [IndexPath.init(row: self.folderName.count-1, section: 0)], with: .automatic)
            }
            
            
        }
        alertController.addAction(action_add)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.folderName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cell
        let cell = self.folder_table.dequeueReusableCell(withIdentifier: "folder_table", for: indexPath) as? FolderTableViewCell
        
        //Cell settings
        cell?.folder_name.text = self.folderName[indexPath.row].name
        cell?.selectionStyle = .none

        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let folder = self.folderName[indexPath.row]
            try! self.realm.write {
                self.realm.delete(folder)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "Detail", sender: nil)
        
    }
    
    
    
    
}

