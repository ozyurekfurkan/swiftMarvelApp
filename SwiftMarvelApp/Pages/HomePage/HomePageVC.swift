//
//  ViewController.swift
//  SwiftMarvelApp
//
//  Created by Furkan Özyürek on 16.01.2022.
//

import UIKit
import ObjectMapper
import Moya
import Kingfisher

class HomePageVC: UIViewController {
    var data = [CharacterModel]()
    var selectedIndex : Int?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let API_KEY = "4146e4ff167820b99352e0304bcdf067";
    let TIME_STAMP = "1";
    let HASH_KEY = "42097ac93c65c5e7e5a44cb246fd5c8c";
    var CHAR_NAME = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Marvel Characters"
        fetchData()
    }
    
    
    func fetchData() {
        if CHAR_NAME != "" {
            MarvelNetwork.makeRequest(target: .marvelCharByName(apiKey: API_KEY, timeStamp: TIME_STAMP, hashKey: HASH_KEY, name: CHAR_NAME), success: { (JSON) in
                    if let data = Mapper<CharacterModel>().mapArray(JSONObject: JSON["data"]["results"].arrayObject) {
                        self.data = data
                        print(self.data)
                        self.tableView.reloadData()
                    }
                        }, statusCode: { (statusCode, statusMessage, requestForm) in
                            print(statusCode)
                        }, failure: { (moyaError) in
                            print(moyaError)
                })
        }
        else {
            MarvelNetwork.makeRequest(target: .marvelChar(apiKey: API_KEY, timeStamp: TIME_STAMP, hashKey: HASH_KEY), success: { (JSON) in
                    if let data = Mapper<CharacterModel>().mapArray(JSONObject: JSON["data"]["results"].arrayObject) {
                        self.data = data
                        print(self.data)
                        self.tableView.reloadData()
                    }
                        }, statusCode: { (statusCode, statusMessage, requestForm) in
                            print(statusCode)
                        }, failure: { (moyaError) in
                            print(moyaError)
                })
        }
  
    }
}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterTableViewCell;
        cell.lblCharacterName.text = self.data[indexPath.row].characterName
        cell.characterImage.kf.setImage(with: (URL(string: "\(self.data[indexPath.row].characterImage!).\(self.data[indexPath.row].characterImageExtesion!)")))
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor .lightGray
            cell.lblCharacterName.textColor = UIColor .white
        } else {
            cell.backgroundColor = UIColor .white
            cell.lblCharacterName.textColor = UIColor .gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "toDetailsVC", sender:nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        CHAR_NAME = self.searchBar.text ?? "";
        fetchData()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! CharacterDetailVC
            destinationVC.data = self.data[selectedIndex!]
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



