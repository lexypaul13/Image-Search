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
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    
}
