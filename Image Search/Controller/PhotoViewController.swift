//
//  ViewController.swift
//  Image Search
//
//  Created by Alex Paul on 2/25/22.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photos = [PhotoModel]()
    var images = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        searchPhoto(name: "dog")
    }
    
    func searchPhoto(name:String){
          NetworkService.shared.getJSON(searchName: name) {  [weak self]  (photos) in
              guard let self = self else { return}
              guard let photos = photos else{ return }
              for photo in photos {
                 let image = photo.images?.first?.link
                  self.images.append(image ?? "No Image")
              }
              self.photos = photos
              self.tableView.reloadData()
          }
      }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension PhotoViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
           cell.descrpiptionLabel.text = photos[indexPath.row].title ?? "No Description"
           cell.photoImageView.downloadImage(from: images[indexPath.row])
           return cell
       }
    
}
