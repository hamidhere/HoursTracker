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
    
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCVC", for: indexPath) as! CallenderCVC
    //        let dayText = totalSquares[indexPath.item]
    //        let hasShift = (Int(dayText) ?? 0) % 2 == 0
    //        cell.dayOfMonthLbl.text = dayText
    //        if totalSquares.count >= 1 && totalSquares.count <= 30 {
    //            cell.shiftHoursLbl.isHidden = false
    //            cell.shiftHoursLbl.text = hasShift ? "08:30" : nil
    //        }
    //
    //            return cell
    //    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCVC", for: indexPath) as! CallenderCVC
        let day = totalSquares[indexPath.item]
        let dayNumber = CalendarHelper().dayOfMonth(date: day.date)
        let dayText = String(dayNumber)

        // Previous/next month days: pale number, no circle, no hours
        guard day.isInMonth else {
            cell.configure(day: dayText, kind: .outsideMonth, hours: nil, isToday: false, isSelected: false)
            return cell
        }

        let calendar = Calendar.current

        // TEMP mock: even days up to today count as worked. Swap for a Core Data lookup later.
        let hasShift = dayNumber % 2 == 0 && day.date <= Date()

        let isToday = calendar.isDateInToday(day.date)
        let isSelected = selectedDay.map { calendar.isDate($0, inSameDayAs: day.date) } ?? false

        cell.configure(day: dayText,
                       kind: hasShift ? .worked : .off,
                       hours: hasShift ? "8:30" : nil,   // design format: H:mm, no leading zero
                       isToday: isToday,
                       isSelected: isSelected)
        return cell
    }
    
    // Tap a day to select it, tap it again to deselect. Days outside the month ignore taps.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = totalSquares[indexPath.item]
        guard day.isInMonth else { return }

        if let current = selectedDay, Calendar.current.isDate(current, inSameDayAs: day.date) {
            selectedDay = nil
        } else {
            selectedDay = day.date
        }
        collectionView.reloadData()
    }
    
}
