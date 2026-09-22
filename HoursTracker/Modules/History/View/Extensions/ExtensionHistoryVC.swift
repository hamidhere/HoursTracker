//
//  ExtensionHistoryVC.swift
//  HoursTracker
//
//  Created by H A M I . on 20/09/2026.
//

import Foundation
import UIKit

extension HistoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCVC", for: indexPath) as! CallenderCVC
        let dayText = totalSquares[indexPath.item]
        let hasShift = (Int(dayText) ?? 0) % 2 == 0
        cell.dayOfMonthLbl.text = dayText
        if totalSquares.count >= 1 && totalSquares.count <= 30 {
            cell.shiftHoursLbl.isHidden = false
            cell.shiftHoursLbl.text = hasShift ? "08:30" : nil
        }

        
        

            return cell
    }
}
