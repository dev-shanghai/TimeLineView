///**

/**
HistoryDataContainer
Created by: Ahmed Alqubaisi on 19/05/2020

HistoryPostCollectionViewCell



Copyright (c) 2020

+-----------------------------------------------------+
|                                                     |
|                                                     |
|                                                     |
|                                                     |
+-----------------------------------------------------+

*/

import UIKit

class HistoryPostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var container_view: UIView!
    @IBOutlet weak var post_imagevVew: UIImageView!
    @IBOutlet weak var postTitle_label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configure(with image: UIImage, title: String) {
        post_imagevVew.image = image
        postTitle_label.text = title
    }

}
