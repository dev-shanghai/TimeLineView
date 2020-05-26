///**

/**
HistoryDataContainer
Created by: Ahmed Alqubaisi on 19/05/2020

TimeLineItemCollectionViewCell



Copyright (c) 2020 

+-----------------------------------------------------+
|                                                     |
|                                                     |
|                                                     |
|                                                     |
+-----------------------------------------------------+

*/

import UIKit



class TimeLineItemCollectionViewCell: UITableViewCell {

    @IBOutlet weak var collectionContainer_view: UIView!
    @IBOutlet weak var history_collection: UICollectionView!
    
    @IBOutlet weak var headerBackground_view: UIView!
    
    @IBOutlet weak var headerTitle_lbl: UILabel!
    @IBOutlet weak var collectionViewHeight_constraint: NSLayoutConstraint!
    
    @IBOutlet weak var gesture_btn: UIButton!
    
    var posts = [PostDataModel]()
    var indexPath : IndexPath?
    var delegate: HistoryTableRowDelegate?
    var expanded: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewHeight_constraint.constant = 0.0
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        // history_collection_table_view_cell
    }

    func setupCollectionView() {
        self.collectionViewHeight_constraint.constant = 20.0
        
        self.history_collection.register(UINib.init(nibName: "HistoryPostCollectionViewCell", bundle: Bundle(for: HistoryPostCollectionViewCell.self)), forCellWithReuseIdentifier: "history_post_collection_view_cell")
        self.history_collection.delegate = self
        self.history_collection.dataSource = self
        self.history_collection.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let itemSize =  UIScreen.main.bounds.width / 3 - 23
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        
        self.history_collection.collectionViewLayout = layout
        self.history_collection.alwaysBounceVertical = true
        
    }
    @IBAction func didTapGesture_btn(_ sender: Any) {
        expanded = !expanded
        self.delegate?.toggleRow(cell: self, expanded:  true, indexPath: indexPath!)
    }
}

