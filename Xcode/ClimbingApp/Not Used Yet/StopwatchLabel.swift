//
//  StopwatchLabel.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/22/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//


//  Description:
//  ------------
//  A small label used to display timers. Includes a small clock icon. 


import UIKit

class StopwatchLabel: UIStackView {
    
    
    // ********************************************************************** //
    // MARK: - Public Members
    // ********************************************************************** //
    
    /// Takes the given seconds and updates the time label with the correct
    /// hours, mins, and seconds. Normally it just shows mm:ss, however if there
    /// are enoug seconds for an hour the label takes the form of hh:mm:ss.
    public func setSeconds(_ seconds: Int? = nil) {
        let hours = (seconds ?? 0) / 3600
        let mins  = ((seconds ?? 0) / 60) % 60
        let secs  = (seconds ?? 0) % 60
        
        if hours > 0 {
            timeLabel.text = String(format: "%02i:%02i:%02i", hours, mins, secs)
        } else {
            timeLabel.text = String(format: "%02i:%02i", mins, secs)
        }
    }
    
    // ********************************************************************** //
    // MARK: - Constants & Varials
    // ********************************************************************** //
    
    /// The image tot he nright of the label.
    private let clockImage = UIImage(systemName: "stopwatch")
    
    /// The distance between the clock icon and the time.
    private let distanceBetweenTextAndIcon: CGFloat = 5
    
    /// The default time is zero.
    private let defaultTimeLabelValue: String = "00:00"
    
    /// The font of the didgets. We use a monospaced font since they change
    /// quite a bit. This make it so the sizing doesnt keep changing.
    private let font: UIFont = .monospacedDigitSystemFont(ofSize: 16, weight: .medium)
    
    /// The clock icon.
    private var clockImageView = UIImageView()
    
    /// The time text.
    private var timeLabel = UILabel()
    
    // ********************************************************************** //
    // MARK: - Initialization
    // ********************************************************************** //
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = distanceBetweenTextAndIcon
        
        configureCockImageView()
        configureTimeLabel()
        
        addArrangedSubview(timeLabel)
        addArrangedSubview(clockImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ********************************************************************** //
    // MARK: - Configuration
    // ********************************************************************** //
    
    /// Prepares the iconImageView by adding the image and setting thge tint color.
    private func configureCockImageView() {
        clockImageView.image = clockImage
        clockImageView.tintColor = .secondaryLabel
    }
    
    /// Prepares the time label by setting the alignment, font, color, and default
    /// text.
    private func configureTimeLabel() {
        timeLabel.text = defaultTimeLabelValue
        timeLabel.textAlignment = .right
        timeLabel.textColor = .secondaryLabel
        timeLabel.font = font
    }
}
