//
//  ViewController.swift
//  Image Search
//
//  Created by Alex Paul on 2/25/22.
//

import UIKit

class PhotoViewController: UIViewController {
    var photos = [PhotoModel]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "no image small")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.bringSubviewToFront(backgroundImage)
    }

    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupPlaceholderImage(){
        
    }
    
    
    func addButton(){
        guard let textfield = textField.text else {return}
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
        let photoIndex = photos[indexPath.row]
        cell.descrpiptionLabel.text = photoIndex.title ?? ""
        cell.viewsLabel.text = "\(photoIndex.views) Views"
        cell.photoImageView.downloadImage(photoIndex.images?.first?.link ?? "", placeholder: UIImage(named: "no image small")!)
        
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

