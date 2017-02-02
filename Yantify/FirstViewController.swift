//
//  FirstViewController.swift
//  Yantify
//
//  Created by iMac on 2/2/17.
//  Copyright © 2017 Ari Fajrianda Alfi. All rights reserved.
//

import UIKit
import Alamofire

struct post {
    let mainImage : UIImage!
    let name : String!
}


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable : UITableView!
    
    var posts = [post]()
    
    var searchURL = "https://api.spotify.com/v1/search?q=sheila+on&type=track"
    
    typealias JSONStandart = [String: AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callAlamo(url: searchURL)
    }
    
    func callAlamo(url: String) {
        Alamofire.request(url).responseJSON { (response) in
            self.parseData(JSONData: response.data!)
        }
    }
    
    func parseData(JSONData : Data) {
        do{
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandart
            if let tracks = readableJSON["tracks"] as? JSONStandart{
                if let items = tracks["items"] as? [JSONStandart] {
                    
                    for i in 0..<items.count {
                        let item = items[i]
                        
                        let name = item["name"] as! String
                        
                        if let album = item["album"] as? JSONStandart {
                            if let images = album["images"] as? [JSONStandart] {
                                let imageData = images[0]
                                let mainImageURL = URL(string: imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageURL!)
                                
                                let mainImage = UIImage(data: mainImageData as! Data)
                                
                                posts.append(post.init(mainImage: mainImage, name: name))
                                
                                self.myTable.reloadData()
                            }
                        }
                    }
                    
                }
            }
        }catch{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        
        mainImageView.image = posts[indexPath.row].mainImage
        
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        
        mainLabel.text = posts[indexPath.row].name
        
        return cell!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.myTable.indexPathForSelectedRow?.row
        
        let vc = segue.destination as! AudioVC
        vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name

    }
    

}

