//
//  TimeLineViewController.swift
//  HistoryDataContainer
//
//  Created by Ahmed Alqubaisi on 16/05/2020.
//

import UIKit

public class TimeLineViewController: UITableViewController {
    
    var timelineDataArray = [HistoryDataModel]()
    
    // MARK: - Private properties
    private var cellHeights : [IndexPath: CGFloat] = [IndexPath: CGFloat]()
    private var timelineTitlesArray: [String] = [String]()
    private var timelineSubTitlesArray: [String] = [String]()
    private var timelineItemsDictionary: [[String:String]] = [[String:String]]()
    private var titleBgColor: UIColor = UIColor()
    private var subTitleBgColor: UIColor = UIColor()
    private var titleTintColor: UIColor = UIColor()
    private var subTitleTintColor: UIColor = UIColor()
    
/*
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
//                let bundle = Bundle(for: TimeLineViewController.self)
                
        //        let historyTVC = TimeLineViewController.init(nibName: "HistoryTableView", bundle: bundle)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
*/
    // MARK: - Public properties
    
    public var timelineTitles:[String]? {
        
        set { timelineTitlesArray = newValue ?? [] }
        get { return timelineTitlesArray }
        
    }
    
    public var timelineSubTitles:[String]? {
        
        set { timelineSubTitlesArray = newValue ?? [] }
        get { return timelineSubTitlesArray }
        
    }
    
    public var timelineItems:[[String:String]]? {
        
        set { timelineItemsDictionary = newValue ?? [[:]] }
        get { return timelineItemsDictionary }
        
    }
    
    
    public var titleBackground:UIColor? {
        
        set { titleBgColor = newValue ?? UIColor.red }
        get { return titleBgColor }
        
    }
    
    public var subTitleBackground:UIColor? {
        
        set { subTitleBgColor = newValue ?? UIColor.white }
        get { return subTitleBgColor }
        
    }
    
    public var titleTint:UIColor? {
        
        set { titleTintColor = newValue ?? UIColor.red }
        get { return titleTintColor }
        
    }
    
    public var subTitleTint:UIColor? {
        
        set { subTitleTintColor = newValue ?? UIColor.white }
        get { return subTitleTintColor }
        
    }
    
        
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.fillPostParams()

        self.tableView.register(UINib(nibName: "TimeLineItemCollectionViewCell", bundle: Bundle(for: TimeLineItemCollectionViewCell.self)), forCellReuseIdentifier: "history_collection_table_view_cell")

        let headerNib = UINib.init(nibName: "HistoryTableHeaderView",  bundle: Bundle(for: HistoryTableHeaderView.self))
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "history_table_view_header")

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorColor = UIColor.clear
        self.tableView.isUserInteractionEnabled  = true
        self.tableView.allowsSelection = false
        
        
        
    }

    // MARK: - Table view data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.timelineDataArray.count

    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (self.timelineDataArray[section].isExpanded == false) {
            return 0
        }
        return timelineDataArray[section].childItems?.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        //return UITableViewCell()
        
        if tableView != self.tableView {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "history_month_table_view_cell", for: indexPath) as? HistoryMonthTableViewCell else {
                return UITableViewCell()
            }
            cell.monthsLabel.text = self.timelineDataArray[indexPath.row].titleValue
            
            cell.layoutIfNeeded()
            return cell
            
            
        }
        */
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "history_collection_table_view_cell", for: indexPath) as? TimeLineItemCollectionViewCell {
            
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
            if let value = self.timelineDataArray[indexPath.section].childItems?[indexPath.row].isExpanded {
                cell.headerTitle_lbl.text = self.timelineDataArray[indexPath.section].childItems?[indexPath.row].titleValue ?? ""
                cell.indexPath = indexPath
                cell.expanded = value
                cell.delegate = self
                
                cell.headerTitle_lbl.tintColor = self.subTitleTintColor
                cell.headerBackground_view.backgroundColor = self.subTitleBgColor
                cell.headerBackground_view.tintColor = self.subTitleTintColor
                
                if (value == true) {
                    
                    /// expand the child collection view
                    cell.layoutIfNeeded()
                    
                    cell.history_collection.isUserInteractionEnabled = true
                    if let posts =  self.timelineDataArray[indexPath.section].childItems?[indexPath.row].histroyPosts {
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
        
        /*
        else if let cell = tableView.dequeueReusableCell(withIdentifier: "history_year_table_view_cell", for: indexPath) as? HistoryYearTableViewCell {
            
            cell.title_lbl.text = self.years_array[indexPath.row]
            cell.setupTableView()
            cell.months_tb.delegate = self
            cell.months_tb.dataSource  = self
            
            
            cell.layoutIfNeeded()
            return cell
        }
        */
        
        else {
            return UITableViewCell()
        }

        
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView != self.tableView {
            return UIView()
        }
    
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "history_table_view_header") as? HistoryTableHeaderView {
            headerView.headerLabel.text = self.timelineDataArray[section].titleValue
            headerView.gesture_btn.tag = section
            headerView.gesture_btn.isHidden  = true
            headerView.section = section
            headerView.expanded = (self.timelineDataArray[section].isExpanded ?? false)
            headerView.delegate = self
            headerView.background_view.backgroundColor = self.titleBgColor
            headerView.tintColor = self.titleTintColor
            headerView.headerLabel.tintColor = self.titleTintColor
            headerView.accessory_image.tintColor = self.titleTintColor
            headerView.accessory_image.isHidden = true
            return headerView
        }
        
        return UIView()
       
    }
    
    public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*
        if (self.historyDataArray[indexPath.section].isExpanded == false) {
            cellHeights[indexPath] = 0.0
        }
        */
        
        //else
        if let historyCollectionCell = cell as? TimeLineItemCollectionViewCell {
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

    public override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
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
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          
        if tableView != self.tableView {
            return 0.0
        }
        
        return 100
    }
    
    
}

extension TimeLineViewController : HeaderViewDelegate {
    func toggleSection(header: HistoryTableHeaderView, expanded: Bool, section : Int) {
          self.timelineDataArray[section].isExpanded = !(self.timelineDataArray[section].isExpanded ?? false)
        
        if (expanded == false) {
            /// we are collapsing rows now 
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
        
        for row in 0..<self.timelineDataArray.count {
            indexPaths.append(IndexPath(row: row,
                                        section: section))
        }
        
        return indexPaths
    }
    
}

extension TimeLineViewController : HistoryTableRowDelegate {
    func toggleRow(cell: TimeLineItemCollectionViewCell, expanded: Bool, indexPath: IndexPath) {
        self.timelineDataArray[indexPath.section].childItems?[indexPath.row].isExpanded = !(self.timelineDataArray[indexPath.section].childItems?[indexPath.row].isExpanded ?? false)
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


extension TimeLineViewController {
    
    func fillPostParams() {
        
        // titles
        for year in self.timelineTitlesArray {
            
            let postModel = HistoryDataModel(title: year)
            if self.timelineTitlesArray.firstIndex(of: year) == 0 {
                postModel.isExpanded = true
            } else {
                postModel.isExpanded = false
            }
            
            self.timelineDataArray.append(postModel)
        }
        
        // sub-titles
        for history in self.timelineDataArray {
            
            if self.timelineDataArray.firstIndex(where: { (model) in
                return model.titleValue == history.titleValue
            }) == 0 {
                history.childItems = getMonthsHistoryDataItem(expand: true)}
            else {
                history.childItems = getMonthsHistoryDataItem(expand: false)
            }
            
        }
    }
    
    func getMonthsHistoryDataItem(expand : Bool) -> [HistoryDataModel] {
        var values = [HistoryDataModel]()
        for month in self.timelineSubTitlesArray {
           let postModel = HistoryDataModel(title: month)
            if expand && self.timelineSubTitlesArray.firstIndex(of: month) == 0 {
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
        
        for post in self.timelineItemsDictionary {
            
            if let title = post["name"],let imageUrl = post["image_url"] {
                let model = PostDataModel(title: title, image: imageUrl)
                posts.append(model)
            }
        }
        
        return posts
    }
}


