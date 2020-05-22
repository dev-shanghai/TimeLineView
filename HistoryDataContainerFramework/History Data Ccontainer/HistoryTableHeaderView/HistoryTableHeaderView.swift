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
    func toggleSection(header: HistoryTableHeaderView, collapsed: Bool, section : Int)
}

class HistoryTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var gesture_btn: UIButton!
    @IBOutlet weak var arrow_lbl: UILabel!
    
    weak var delegate: HeaderViewDelegate?
    var collapsed: Bool = true
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        self.arrow_lbl.text = "😺"
        setCollapsed(collapsed: collapsed)
    }
    
    
    @objc private func didTapHeader() {
        self.collapsed = !self.collapsed
        delegate?.toggleSection(header: self, collapsed: collapsed, section: section)
        setCollapsed(collapsed: collapsed)
    }

    
    func setCollapsed(collapsed: Bool) {
        arrow_lbl?.rotate(collapsed ? 0.0 : .pi)
    }
}


extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
}
