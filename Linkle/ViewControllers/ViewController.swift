//
//  ViewController.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/11/29.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //Property
    @IBOutlet weak var folder_table: UITableView!
    @IBOutlet weak var background_image: UIImageView!
    var temp_uid = String()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let data = UserDefaults.standard.object(forKey: "bg_image") as? NSData
        
        if data != nil {
            self.background_image.image = UIImage(data: data! as Data)
        } else {
            self.background_image.image = UIImage(named: "bg_two")
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //ナビゲーションを透明にする
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }

    
    //フォルダ作成
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
            
            try! realm.write {
                realm.add(folder_name)
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
            try! realm.write {
                realm.delete(folder)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.temp_uid = self.folderName[indexPath.row].folderID
        performSegue(withIdentifier: "Detail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //選択されたフォルダのUUIDを渡す
        if segue.identifier == "Detail" {
            let link_vc = (segue.destination as? LinkViewController)!
            link_vc.unique_id = self.temp_uid
        }
    }
    
    //カメラボタン押された時
    @IBAction func photoButto_tapped(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: true)
        }
        
    }
    
    //写真が選択された時
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
        
        //写真を保存
        UserDefaults.standard.set(imageData, forKey: "bg_image")
        
        //写真を表示
        let data = UserDefaults.standard.object(forKey: "bg_image") as! NSData
        self.background_image.image = UIImage(data: data as Data)

        self.dismiss(animated: true)
        
    }
    
    
    
    
}

