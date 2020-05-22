//
//  HistoryTableViewCell.swift
//  HistoryDataContainer
//
//  Created by Ahmed Alqubaisi on 16/05/2020.
//

import UIKit

class HistoryYearTableViewCell: UITableViewCell {

    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var months_tb: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTableView() {
        //self.months_tb.register(UITableViewCell.self, forCellReuseIdentifier: "history_month_table_view_cell")
        self.months_tb.register(UINib(nibName: "HistoryMonthTableViewCell", bundle: nil), forCellReuseIdentifier: "history_month_table_view_cell")
     }
    
}
