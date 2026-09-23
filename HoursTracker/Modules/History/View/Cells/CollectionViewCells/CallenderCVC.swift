//
//  CallenderCVC.swift
//  
//
//  Created by H A M I . on 20/09/2026.
//

import UIKit
import RswiftResources

class CallenderCVC: UICollectionViewCell {

    @IBOutlet weak var dayOfMonthLbl: UILabel!
    @IBOutlet weak var shiftHoursLbl: UILabel!
    
    enum DayKind {
        case outsideMonth  // days from the previous/next month (e.g. 31 Aug): pale number, no circle
        case off           // nothing logged: plain number, no circle
        case worked        // shift logged: soft filled circle, hours underneath
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Size and position come from the storyboard (width 42, aspect 1:1).
        dayOfMonthLbl.textAlignment = .center
        dayOfMonthLbl.clipsToBounds = true
        dayOfMonthLbl.font = R.font.jetBrainsMonoNLLight(size: 15)  // design: 15pt mono, so two-digit dates fill the circle

        shiftHoursLbl.textAlignment = .center
        shiftHoursLbl.font = R.font.jetBrainsMonoNLLight(size: 10)   // design: 10pt mono under the circle
        shiftHoursLbl.textColor = UIColor.actionPrimaryPressed
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dayOfMonthLbl.layer.cornerRadius = dayOfMonthLbl.bounds.height / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dayOfMonthLbl.text = nil
        shiftHoursLbl.text = nil
    }

    /// Circle priority: selected > today > worked > off.
    func configure(day: String, kind: DayKind, hours: String?, isToday: Bool, isSelected: Bool) {
        dayOfMonthLbl.text = day

        let showHours = (kind == .worked) && hours != nil
        shiftHoursLbl.isHidden = !showHours
        shiftHoursLbl.text = showHours ? hours : nil

        if kind == .outsideMonth {
            style(fill: .clear, text: UIColor.hairlineStrong, ring: nil)
        } else if isSelected {
            style(fill: UIColor.actionPrimaryPressed, text: .white, ring: nil)
        } else if isToday {
            style(fill: kind == .worked ? UIColor.surfaceSunken : .clear, text: UIColor.textInk, ring: UIColor.actionPrimaryPressed)
        } else if kind == .worked {
            style(fill: UIColor.surfaceSunken, text: UIColor.textInk, ring: nil)
        } else {
            style(fill: .clear, text: UIColor.textInk, ring: nil)
        }
    }

    private func style(fill: UIColor, text: UIColor, ring: UIColor?) {
        dayOfMonthLbl.backgroundColor = fill
        dayOfMonthLbl.textColor = text
        dayOfMonthLbl.layer.borderWidth = (ring == nil) ? 0 : 1.5
        // CGColor doesn't follow light/dark mode by itself, so resolve it for the current appearance
        dayOfMonthLbl.layer.borderColor = ring?.resolvedColor(with: traitCollection).cgColor
    }
    
}
