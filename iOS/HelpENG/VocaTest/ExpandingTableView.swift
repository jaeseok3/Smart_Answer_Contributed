//
//  MyTableView.swift
//  ExpandingTableView
//
//  Created by Wanni on 2020/05/12.
//  Copyright © 2020 Wanni. All rights reserved.
//

import Foundation
import UIKit

protocol ExpandingTableViewUI {
    
}

protocol ExpandingTableViewDataSource {
    var myData: ExpandingTbViewData { get }
}

class ExpandingTableView: UITableView, ExpandingTableViewUI, ExpandingTableViewDataSource {
    
    var myData: ExpandingTbViewData = ExpandingTbViewData()
    
    
    func initUI() {
//        self.backgroundColor = myBackgroundColor
        self.separatorStyle = .none
        self.tableFooterView = UIView()
        self.estimatedRowHeight = 50
        self.rowHeight = UITableView.automaticDimension
        
//        self.isEditing = true
    }
}

//MARK: - numOfRowInSections Function

extension ExpandingTableView {
    
    func numberOfRowsInSection(section: Int) -> Int {
        let isOpened = myData.sectionsData[section].isOpened
        switch isOpened {
        case true:
            return myData.sectionsData[section].rowsNumber + 1
        default:
            return 1
        }
    }
}

//MARK: - get TitleText From myData
extension ExpandingTableView {
    
    func getRowTitle(indexPath: IndexPath) -> String {
        return myData.sectionsData[indexPath.section].rowsTitles[indexPath.row - 1]
    }
    
    func getSectionData(indexPath: IndexPath) -> MyData {
        return myData.sectionsData[indexPath.section]
    }
}


// MARK: - tableView expanding function
extension ExpandingTableView {
    
    /**
     Function to expand the section selected by the user
     
      - Author:
        Wanni
      - Version:
        0.1
     
     - Parameters:
        - selected: user selected section
    */
    
    func expanding(selectedIndexPath indexPath :IndexPath) {
        
        let isOpened = myData.sectionsData[indexPath.section].isOpened
        switch isOpened {
        case true:
            self.deleteRows(selected: indexPath)
        default:
            self.insertRows(selected: indexPath)
        }
    }
    
    private func deleteRows(selected indexPath: IndexPath) {
        myData.sectionsData[indexPath.section].isOpened = false
        var indexesPath = [IndexPath]()
        let sectionNumber = myData.sectionsData[indexPath.section].rowsNumber
        
        for row in 0..<sectionNumber {
            let index = IndexPath(row: row + 1, section: indexPath.section)
            indexesPath.append(index)
        }
        
        self.beginUpdates()
        self.self.deleteRows(at: indexesPath, with: .fade)
        self.endUpdates()
        
    }
    
    private func insertRows(selected indexPath: IndexPath) {
        myData.sectionsData[indexPath.section].isOpened = true
        var indexesPath = [IndexPath]()
        let sectionNumber = myData.sectionsData[indexPath.section].rowsNumber
        
        for row in 0..<sectionNumber {
            let index = IndexPath(row: row + 1, section: indexPath.section)
            indexesPath.append(index)
        }
        
        self.beginUpdates()
        self.self.insertRows(at: indexesPath, with: .fade)
        self.endUpdates()
    }
}
