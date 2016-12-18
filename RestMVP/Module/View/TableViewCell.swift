//
//  TableViewCell.swift
//  RestMVP
//
//  Created by Cyberk on 12/12/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var desc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell(model: Article){
        title.text = model.title
        id.text = "ID\(model.id!)"
        desc.text = model.description
        let imageURL = URL(string: model.image!)
        
        images.kf.setImage(with: imageURL, placeholder:  UIImage(named: "thumbnail-default"), options: nil, progressBlock: nil, completionHandler: nil)
}
}
