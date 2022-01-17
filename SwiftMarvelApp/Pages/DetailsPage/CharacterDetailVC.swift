//
//  CharacterDetailViewController.swift
//  SwiftMarvelApp
//
//  Created by Furkan Özyürek on 16.01.2022.
//

import UIKit
import ObjectMapper
import Moya
import Kingfisher
import MapKit

class CharacterDetailVC: UIViewController {
    
    var COMIC_ID : String?
    var selectedIndex : Int?
    let API_KEY = "4146e4ff167820b99352e0304bcdf067";
    let TIME_STAMP = "1";
    let HASH_KEY = "42097ac93c65c5e7e5a44cb246fd5c8c";
    
    @IBOutlet weak var lblCharacterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var lblCharacterDescription: UILabel!
    @IBOutlet weak var lblComicsTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var data : CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblComicsTitle.text = "Comics"
        self.lblCharacterName.text = data?.characterName;
        self.lblCharacterDescription.text = data?.characterDescription
        self.characterImage.kf.setImage(with: (URL(string: "\(self.data?.characterImage! ?? "").\(self.data?.characterImageExtesion! ?? "")")))
    }
}

extension CharacterDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.comicList?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicsCell") as! ComicsTableViewCell
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor .lightGray
            cell.lblComicName.textColor = UIColor .white
        } else {
            cell.backgroundColor = UIColor .white
            cell.lblComicName.textColor = UIColor .gray
        }
        cell.lblComicName.text = self.data?.comicList?[indexPath.row].name
        return cell
    }
}
