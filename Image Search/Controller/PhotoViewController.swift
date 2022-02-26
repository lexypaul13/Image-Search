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
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func addButton(){
        guard let textfield =  textField.text else {return}
        
        NetworkService.shared.getJSON(searchName: textfield) {  [weak self]  (photos) in
            guard let self = self else { return}
            guard let photos = photos else{ return }
            self.photos = photos
            self.tableView.reloadData()
        }}
    
    
    @IBAction func searchButton(_ sender: Any) {
        addButton()
    }
    
}


extension PhotoViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let dataObj = photos[indexPath.row]
        cell.photoImageView.image = UIImage()
        cell.descrpiptionLabel.text = dataObj.title ?? "No Description"
        cell.photoImageView.downloadImage(from: photos[indexPath.row].images?.first?.link ?? "")
//        if let images = dataObj.images, images.count > 0 {
//            cell.photoImageView.downloadImage(from: images[0].link ?? "No Image")
//        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PhotoDetailsViewController
                destinationController.selectedPhotos = photos[indexPath.row].images?.first
                
            }
            
        }
        
    }

    
}
    
