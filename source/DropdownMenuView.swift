//
//  DropdownMenuView.swift
//  TestTableView
//
//  Created by forwor on 2016/11/15.
//  Copyright © 2016年 forwor. All rights reserved.
//
@objc protocol DropdownMenuDelegate{
    @objc optional func dropdownMenuDidDismiss(_ menu: DropdownMenuView)
    @objc optional func dropdownMenuDidShow(_ menu: DropdownMenuView)
    @objc optional func selectedAt(_ titles: [String])
}

import UIKit

class DropdownMenuView: UIView {

    var delegate: DropdownMenuDelegate!
    var selectedTitles: [String]!
    var data: [String]!
    var canBeMultiSelecte = false
    
    fileprivate var contentController: UIViewController!
    fileprivate var contentView: UIView!
    fileprivate var containerView: UIView!
    
    fileprivate var currentWindow: UIWindow!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        currentWindow = UIApplication.shared.windows.last!
        
        self.backgroundColor = UIColor(colorLiteralRed: 1/255, green: 1/255, blue: 1/255, alpha: 0.7)
        self.frame = currentWindow.bounds
        
        containerView = UIView()
        containerView.frame = self.frame
        containerView.isUserInteractionEnabled = true
        self.addSubview(containerView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupContentView(){
        let titleMenuVC = TitleMenuViewController()
        titleMenuVC.delegate = self
        titleMenuVC.dropdownMenuView = self
        titleMenuVC.canBeMultiSelecte = self.canBeMultiSelecte
        titleMenuVC.selectedTitles = self.selectedTitles
        titleMenuVC.data = self.data
        //虽然这句没用，但是去掉就不行，不知道怎么搞的
        contentController = titleMenuVC
        contentView = titleMenuVC.view
        contentView.frame = CGRect(x: 0, y: -titleMenuVC.tableViewHeight, width: self.frame.width, height: titleMenuVC.tableViewHeight)
        
        containerView.addSubview(titleMenuVC.view)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.contentView.frame = CGRect(x: 0, y: 20, width: self.frame.width, height: titleMenuVC.tableViewHeight)
            }, completion: nil)
    }
    func show(){
        setupContentView()
        currentWindow.addSubview(self)
        delegate?.dropdownMenuDidShow?(self)
    }
    
    func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame = CGRect(x: 0, y: -self.contentView.frame.height, width: self.frame.width, height: self.contentView.frame.height)
        }) { (finished) in
            self.removeFromSuperview()
            self.delegate?.dropdownMenuDidDismiss?(self)
        }
    }
    
    override internal func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canBeMultiSelecte{
            let tableView = contentView as! UITableView
            var titles = [String]()
            for cell in tableView.visibleCells{
                if cell.accessoryType == .checkmark{
                    titles.append((cell.textLabel!.text!))
                }
            }
            self.delegate?.selectedAt?(titles)
        }
        self.dismiss()
    }
}

extension DropdownMenuView: TitleMenuDelegate{
    func selectedAt(_ titles: [String]) {
        delegate?.selectedAt?(titles)
    }
}
