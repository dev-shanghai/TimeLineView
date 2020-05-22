///**

/**
HistoryDataContainer
Created by: Ahmed Alqubaisi on 19/05/2020

HistoryTableViewCollectionCell



Copyright (c) 2020 

+-----------------------------------------------------+
|                                                     |
|                                                     |
|                                                     |
|                                                     |
+-----------------------------------------------------+

*/

import UIKit

protocol HistoryTableRowDelegate: class {
    func toggleRow(cell: HistoryTableViewCollectionCell, expanded: Bool, indexPath: IndexPath)
}

class HistoryTableViewCollectionCell: UITableViewCell {

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
        
        
        self.history_collection.register(UINib.init(nibName: "HistoryPostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "history_post_collection_view_cell")
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
    
    func failedToggle() {
        
    }
    
}

extension HistoryTableViewCollectionCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "history_post_collection_view_cell", for: indexPath) as! HistoryPostCollectionViewCell
        
        cell.postTitle_label.text = self.posts[indexPath.row].getTitle
        cell.post_imagevVew.image = UIImage(named: "place_holder")
        /*
        if let url = URL(string: self.posts[indexPath.row].getImageUrl ?? "") {
            do {
                let data = try Data(contentsOf: url)
                cell.post_imagevVew.image = UIImage(data: data)
                return cell
            }
                
            catch {
                
            }
            
        }
        */
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //delegate.productClick(name: productCollectionModel[indexPath.row].name, image: productCollectionModel[indexPath.row].bannerImage, id: productCollectionModel[indexPath.row].Id)
        
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
        //return CGSize(width: collectionView.frame.size.width/2 - 16 , height: collectionView.frame.size.width/2 + 70)
        return CGSize(width: collectionView.frame.size.width/3 - 16 , height: collectionView.frame.size.width/3 + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(3,3,3,3)
    }
    */
    
    
    // UICollectionViewDataSource method
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //return  CGSize (width:  UIScreen.main.bounds.size.width - 30, height: collectionView.frame.size.height)
        
        let numberOfSets = CGFloat(4)
        let width = (collectionView.frame.size.width - (numberOfSets * self.frame.size.width / 15))/numberOfSets
        let height = collectionView.frame.size.height / 2
        return CGSize(width: width, height: height)
    }
    
    // UICollectionViewDelegateFlowLayout method
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let cellWidthPadding = collectionView.frame.size.width / 30
        let cellHeightPadding = collectionView.frame.size.height / 4
        return UIEdgeInsets(top: cellHeightPadding,left: cellWidthPadding, bottom: cellHeightPadding,right: cellWidthPadding)
    }
    
}

/*
extension UICollectionView {
    func setPrototypeCell(size: CGSize, scrollDirection: UICollectionView.ScrollDirection = .horizontal) {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = size
        flow.scrollDirection = scrollDirection
        self.collectionViewLayout = flow
    }
}
*/

