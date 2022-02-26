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
            photoImage.downloadImage(from: selectedPhotos?.link ?? "")
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}