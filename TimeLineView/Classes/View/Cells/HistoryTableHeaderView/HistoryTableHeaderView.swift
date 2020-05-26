///**

/**
 HistoryDataContainer
 Created by: Ahmed Alqubaisi on 17/05/2020
 
 HistoryTableHeaderView
 
 
 
 Copyright (c) 2020
 
 +-----------------------------------------------------+
 |                                                     |
 |                                                     |
 |                                                     |
 |                                                     |
 +-----------------------------------------------------+
 
 */

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(header: HistoryTableHeaderView, expanded: Bool, section : Int)
}

class HistoryTableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var gesture_btn: UIButton!
    @IBOutlet weak var accessory_image: UIImageView!
    @IBOutlet weak var background_view: UIView!
    
    
    
    weak var delegate: HeaderViewDelegate?
    var expanded: Bool = true
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        setExpanded(expanded: expanded)
        
    }
    
    
    @objc private func didTapHeader() {
        self.expanded = !self.expanded
        delegate?.toggleSection(header: self, expanded: expanded, section: section)
        setExpanded(expanded: expanded)
    }
    
    
    func setExpanded(expanded: Bool) {
        let zKeyPath = "layer.presentationLayer.transform.rotation.z"
        let imageRotation = (self.accessory_image.value(forKeyPath: zKeyPath) as? NSNumber)?.floatValue ?? 0.0
        
        if (imageRotation == 0.0 && expanded) {
            self.accessory_image?.rotate(.pi)
        } else if(imageRotation == .pi && !expanded) {
            self.accessory_image?.rotate(0.0)
        }
        
        
    }
}
