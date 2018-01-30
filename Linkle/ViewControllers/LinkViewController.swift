//
//  LinkViewController.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/04.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit
import RealmSwift
import Ji
import SafariServices
import NVActivityIndicatorView

class LinkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //Property
    @IBOutlet weak var link_table: UITableView!
    @IBOutlet weak var color_indicator: NVActivityIndicatorView!
    
    var unique_id = String()
    var isLoaded = Bool()
    var link_arr: Results<LinkModel> {
        get {
            //受け取ったUUIDと一致するリンクのみ取り出す
            return realm.objects(LinkModel.self).filter("match_id = '\(self.unique_id)'")
        }
    }
   
    
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
        return self.link_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cell
        let cell = link_table.dequeueReusableCell(withIdentifier: "link_table", for: indexPath) as? LinkTableViewCell
        cell?.selectionStyle = .none
        cell?.link_title.text = self.link_arr[indexPath.row].title
        cell?.link_url.text = self.link_arr[indexPath.row].url
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let safari_vc = SFSafariViewController(url: URL(string: self.link_arr[indexPath.row].url)!)
        present(safari_vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let link = self.link_arr[indexPath.row]
            try! realm.write {
                realm.delete(link)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    
    
    //リンク保存
    @IBAction func linkAddDidTap(_ sender: Any) {
        
        
        let alertController: UIAlertController = UIAlertController(title: "リンク", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
            
        }
        
        
        let action_cancel = UIAlertAction.init(title: "キャンセル", style: .cancel) { (UIAlertAction) -> Void in
            
        }
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) -> Void in
            
            //インディケータ回す
            self.color_indicator.startAnimating()
            
            let textField_link = (alertController.textFields?.first)! as UITextField
            let link = LinkModel()
            self.isLoaded = true
            
            //ページアクセス完了後,タイトルを取得とDBに保存
            waiting_codition( {self.isLoaded == false} ) {
                let encoded_string = textField_link.text!.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                let encoded_url = URL(string: encoded_string!)
                let jiDoc = Ji(htmlURL: encoded_url!)
                let titleNode = jiDoc?.xPath("//head/title")?.first
                let titleString:String = String(describing: titleNode!)
                
                link.title = titleString
                link.url = textField_link.text!
                link.match_id = self.unique_id
                link.link_num = link.link_num+1
                
                try! realm.write {
                    realm.add(link)
                    self.link_table.insertRows(at: [IndexPath.init(row: self.link_arr.count-1, section: 0)], with: .automatic)
                    
                    //インディケータストップ
                    DispatchQueue.main.async {
                        self.isLoaded = false
                        self.color_indicator.stopAnimating()
                    }
                    
                    return
                }
                
            }
            
            
        }
        alertController.addAction(action_add)
        
        present(alertController, animated: true, completion: nil)
        
        
    }

}
