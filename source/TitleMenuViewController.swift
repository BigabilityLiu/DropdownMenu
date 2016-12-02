//
//  TitleMenuViewController.swift
//  TestTableView
//
//  Created by forwor on 2016/11/15.
//  Copyright © 2016年 forwor. All rights reserved.
//
@objc protocol TitleMenuDelegate{
    @objc optional func selectedAt(_ titles: [String])
}

import UIKit

class TitleMenuViewController: UITableViewController {

    var delegate: TitleMenuDelegate!
    
    var dropdownMenuView: DropdownMenuView!
    
    var tableViewHeight = CGFloat()
    var cellHeight: CGFloat = 40
    var canBeMultiSelecte = false
    var selectedTitles: [String]!
    var data: [String]!{
        didSet{
            tableViewHeight = CGFloat(data.count) * cellHeight
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = data[indexPath.row]
        
        for title in selectedTitles{
            if data[indexPath.row] == title{
                cell.accessoryType = .checkmark
                break
            }else{
                cell.accessoryType = .none
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !canBeMultiSelecte{
            if dropdownMenuView != nil{
                dropdownMenuView.dismiss()
            }
            delegate?.selectedAt?([data[indexPath.row]])
        }else{
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType == .checkmark{
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
            }
            
//            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
 }
