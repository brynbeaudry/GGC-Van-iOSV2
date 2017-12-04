//
//  EventTableViewCell.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-12-03.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    var title : String?
    var imageUrl : String?
    let dgHaveDownloadedImage = DispatchGroup()
    @IBOutlet weak var uiTitle: UILabel!
    @IBOutlet weak var uiImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
