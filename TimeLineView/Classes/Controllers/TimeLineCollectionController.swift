///**

/**
TimeLineCVItemController
Created by: Ahmed Alqubaisi on 23/05/2020

Controller



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
    func toggleRow(cell: TimeLineItemCollectionViewCell, expanded: Bool, indexPath: IndexPath)
}

extension TimeLineItemCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "history_post_collection_view_cell", for: indexPath) as! HistoryPostCollectionViewCell
        
        cell.postTitle_label.textAlignment = NSTextAlignment.center
        cell.post_imagevVew.layer.cornerRadius = 12
        
        cell.postTitle_label.text = self.posts[indexPath.row].getTitle
        cell.post_imagevVew.image = UIImage(named: "place_holder")
        
        DispatchQueue.main.async {
            
            if let url = URL(string: self.posts[indexPath.row].getImageUrl ?? "") {
                do {
                    let data = try Data(contentsOf: url)
                    cell.post_imagevVew.image = UIImage(data: data)
                    
                }
                    
                catch {
                    
                }
                
            }
            
        }
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
