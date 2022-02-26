//
//  PhotoTableViewCell.swift
//  Image Search
//
//  Created by Alex Paul on 2/25/22.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descrpiptionLabel: UILabel!
    private var task: URLSessionDataTask?
    

    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        photoImageView.image = nil
    }

    // Called in cellForRowAt / cellForItemAt
    func configureWith(urlString: String) {
        if task == nil {
            // Ignore calls when reloading
            task = photoImageView.downloadImage(from: urlString)
            
        }
    }
    
}
