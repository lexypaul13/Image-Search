//
//  PhotoDetailsViewController.swift
//  Image Search
//
//  Created by Alex Paul on 2/26/22.
//

import UIKit
class PhotoDetailsViewController: UIViewController {
    var selectedPhotos : Image?
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = selectedPhotos{
            photoImage.downloadImage(selectedPhotos?.link ?? "", placeholder: UIImage(named: "No Image"))
        }
    }

}
