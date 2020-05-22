//
//  HistoryTableViewController.swift
//  HistoryDataContainer
//
//  Created by Ahmed Alqubaisi on 16/05/2020.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var years_array = ["2020","2019", "2018", "2017", "2016", "2014", "2013", "2012", "2011", "2010", "2009", "2008" ]
    var months_array = ["December", "November", "October", "September", "August", "July", "June", "May", "April", "March", "Febuary", "January"]
    
    var history_posts_items = [
        ["Mangoe","Banana", "Apple", "Pine Apple"],
        ["Computer","Mobile", "Laptop"],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "Karachi", "London", "New Dehli", "San Frasico"],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "Karachi", "London", "New Dehli", "San Frasico"],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "Karachi", "London", "New Dehli", "San Frasico","Lahore", "Abu Dhabi",],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "New Dehli", "San Frasico"],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "Karachi", "London", "New Dehli", "San Frasico"],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "Karachi", "London", "New Dehli", "San Frasico","Karachi", "London",],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "Karachi", "London", "New Dehli", "San Frasico"],
        ["Abbottabad", "Lahore", "Abu Dhabi", "Dubai", "Karachi", "London", "New Dehli", "San Frasico","Karachi", "London",],
        ["Mangoe","Banana", "Apple", "Pine Apple"],
        ["Computer","Mobile", "Laptop","Laptop"],
    ]
    
    var historyDataArray = [HistoryDataModel]()
    var cellHeights : [IndexPath: CGFloat] = [IndexPath: CGFloat]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //self.tableView.register(UINib(nibName: "HistoryYearTableViewCell", bundle: nil), forCellReuseIdentifier: "history_year_table_view_cell")
        
        self.fillPostParams()
        
        self.tableView.register(UINib(nibName: "HistoryTableViewCollectionCell", bundle: nil), forCellReuseIdentifier: "history_collection_table_view_cell")
        
        let headerNib = UINib.init(nibName: "HistoryTableHeaderView", bundle: Bundle.main)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "history_table_view_header")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorColor = UIColor.clear
        self.tableView.isUserInteractionEnabled  = true
        self.tableView.allowsSelection = false
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.historyDataArray.count

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (self.historyDataArray[section].isExpanded == false) {
            return 0
        }
        return historyDataArray[section].childItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //return UITableViewCell()
        
        if tableView != self.tableView {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "history_month_table_view_cell", for: indexPath) as? HistoryMonthTableViewCell else {
                return UITableViewCell()
            }
            cell.monthsLabel.text = self.months_array[indexPath.row]
            
            cell.layoutIfNeeded()
            return cell
            
            
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "history_collection_table_view_cell", for: indexPath) as? HistoryTableViewCollectionCell {
            
            /// adding a new item into the array for cell height
            if (cellHeights[indexPath] == nil) {
                cellHeights[indexPath] = 0.0
            }
            
            
            
            /*
            toggleButtonAction = { [unowned self] in
                 
                if let expanded = self.historyDataArray[indexPath.section].childItems?[indexPath.row].isExpanded {
                    self.historyDataArray[indexPath.section].childItems?[indexPath.row].isExpanded = !expanded
                    self.showHideRows(indexPath: indexPath, collapsed: expanded)
                }
            }
            */
            if let value = self.historyDataArray[indexPath.section].childItems?[indexPath.row].isExpanded {
                cell.headerTitle_lbl.text = self.historyDataArray[indexPath.section].childItems?[indexPath.row].titleValue ?? ""
                cell.indexPath = indexPath
                cell.expanded = value
                cell.delegate = self
                
                if (value == true) {
                    
                    /// expand the child collection view
                    cell.layoutIfNeeded()
                    
                    cell.history_collection.isUserInteractionEnabled = true
                    if let posts =  self.historyDataArray[indexPath.section].childItems?[indexPath.row].histroyPosts {
                        cell.posts = posts
                    }
                    
                    
                    //cell.setupCollectionView()
                    
                    // load actual content of embedded CollectionView
                    cell.history_collection.reloadData()
                    
                    
                    // Compute actual height
                    cell.layoutIfNeeded()
                    let height: CGFloat = cell.history_collection.collectionViewLayout.collectionViewContentSize.height
                    cell.collectionViewHeight_constraint.constant = height
                    /*
                     cell.gesture_btn.tag =
                     cell.gesture_btn.addTarget(self, action: #selector(self.hideShowCell(sender:)),for: .touchUpInside)
                     */
                } else {
                    /// collection view must be colsed
                    cell.layoutIfNeeded()
                    // load actual content of embedded CollectionView
                    cell.history_collection.reloadData()
                    // Compute actual height
                    cell.layoutIfNeeded()
                    cell.collectionViewHeight_constraint.constant = 0.0
                    
                }
            }
            
           
            
            
            return cell
            
        }
        
        else if let cell = tableView.dequeueReusableCell(withIdentifier: "history_year_table_view_cell", for: indexPath) as? HistoryYearTableViewCell {
            
            cell.title_lbl.text = self.years_array[indexPath.row]
            cell.setupTableView()
            cell.months_tb.delegate = self
            cell.months_tb.dataSource  = self
            
            
            cell.layoutIfNeeded()
            return cell
        } else {
            return UITableViewCell()
        }

        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView != self.tableView {
            return UIView()
        }
    
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "history_table_view_header") as? HistoryTableHeaderView {
            headerView.headerLabel.text = self.historyDataArray[section].titleValue
            headerView.gesture_btn.tag = section
            headerView.gesture_btn.isHidden  = true
            headerView.section = section
            headerView.collapsed = !(self.historyDataArray[section].isExpanded ?? false)
            headerView.delegate = self
            return headerView
        }
        
        return UIView()
       
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*
        if (self.historyDataArray[indexPath.section].isExpanded == false) {
            cellHeights[indexPath] = 0.0
        }
        */
        
        //else
        if let historyCollectionCell = cell as? HistoryTableViewCollectionCell {
            cellHeights[indexPath] = historyCollectionCell.history_collection.collectionViewLayout.collectionViewContentSize.height
        } else {
            cellHeights[indexPath] = cell.frame.size.height
        }
        
        self.viewWillLayoutSubviews()
    }
    
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.historyDataArray[indexPath.row].isExpanded == false) {
            return 0.0
        }
        return cellHeights[indexPath] ?? 70.0
    }
    */

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        /*
         if (self.historyDataArray[indexPath.row].isExpanded == false) {
         return 0.0
         }
         */
        return cellHeights[indexPath] ?? 70.0
    }
    
    /*
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          
        if tableView != self.tableView {
            return 0.0
        }
        
        return 100
    }
    
    
}

extension HistoryTableViewController : HeaderViewDelegate {
    func toggleSection(header: HistoryTableHeaderView, collapsed: Bool, section : Int) {
          self.historyDataArray[section].isExpanded = !(self.historyDataArray[section].isExpanded ?? false)
        
        if (collapsed) {
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexPathsForSection(section: section), with: UITableView.RowAnimation.fade)
            self.tableView!.endUpdates()
        } else {
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexPathsForSection(section: section), with: UITableView.RowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    func indexPathsForSection(section : Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for row in 0..<self.historyDataArray.count {
            indexPaths.append(IndexPath(row: row,
                                        section: section))
        }
        
        return indexPaths
    }
    
}

extension HistoryTableViewController : HistoryTableRowDelegate {
    func toggleRow(cell: HistoryTableViewCollectionCell, expanded: Bool, indexPath: IndexPath) {
        self.historyDataArray[indexPath.section].childItems?[indexPath.row].isExpanded = !(self.historyDataArray[indexPath.section].childItems?[indexPath.row].isExpanded ?? false)
        //self.tableView.reloadData()

        self.tableView!.beginUpdates()
        self.tableView!.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        self.tableView!.endUpdates()
    }
    
    
    /*
     @objc
     private func hideShowCell(sender: UIButton) {
     // Create section let
     // Add indexPathsForSection method
     // Logic to add/remove sections to/from hiddenSections, and delete and insert functionality for tableView
     
     let section = sender.tag
     self.historyDataArray[section].isExpanded = !(self.historyDataArray[section].isExpanded ?? false)
     self.tableView.insertRows(at: indexPathsForSection(section: section),with: .fade)
     }
     */
    
    /*
    func showHideRows(indexPath : IndexPath) {
        self.tableView!.beginUpdates()
        self.tableView!.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        self.tableView!.endUpdates()
    }
    */
    
    
    
}


extension HistoryTableViewController {
    
    func fillPostParams() {
        
        // years
        for year in self.years_array {
            
            let postModel = HistoryDataModel(title: year)
            if self.years_array.firstIndex(of: year) == 0 {
                postModel.isExpanded = true
            } else {
                postModel.isExpanded = false
            }
            
            self.historyDataArray.append(postModel)
        }
        
        // months
        for history in self.historyDataArray {
            
            if self.historyDataArray.firstIndex(where: { (model) in
                return model.titleValue == history.titleValue
            }) == 0 {
                history.childItems = getMonthsHistoryDataItem(expand: true)}
            else {
                history.childItems = getMonthsHistoryDataItem(expand: false)
            }
            
        }
        print(self.historyDataArray.count)
        
    }
    
    func getMonthsHistoryDataItem(expand : Bool) -> [HistoryDataModel] {
        var values = [HistoryDataModel]()
        for month in self.months_array {
           let postModel = HistoryDataModel(title: month)
            if expand && self.months_array.firstIndex(of: month) == 0 {
               postModel.isExpanded = true
           } else {
               postModel.isExpanded = false
           }
            
            
            postModel.histroyPosts = getPostModel(count: 10)
            values.append(postModel)
        }
        
        return values
    }
    
    
    func getPostModel(count : Int) -> [PostDataModel] {
        var posts = [PostDataModel]()
        
        for index in 1...count {
         
            let model = PostDataModel(title: "Item : \(index)", image: "https://picsum.photos/id/237/200/300")
            posts.append(model)
        }
        
        return posts
    }
}


