//
//  LineChartView.swift
//  ClimbingApp
//
//  Created by Matt Marks on 1/21/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

/*

The anatomy of LineChartView:
 
------------------------- [TopAxisLine (CAShapeLayer)] ---------------------------
 [TopLeftAxisLabel (UILabel)]                        [TopRightAxisLabel (UILabel)]
 
 
- - - - - - - - - - - - - - o - - - - - - - - - - -  [GridLine (CAShapeLayer)] - -
                           / \                               [GridLabel (UILabel)]
[Line (CAShapeLayer)] --> /   \         o
                         /     \       / \     o
- - - - - - - - - - - - / - - - \ - - /- -\ - / - -  [GridLine (CAShapeLayer)] - -
             o         /         \   /     \ /               [GridLabel (UILabel)]
            / \       /           \ /       o
           /   \     /             o
- - - - - /- - -\ - /- - - - - - - - - - - - - - - - [GridLine (CAShapeLayer)] - -
         /       \ /                                         [GridLabel (UILabel)]
        /         o <-- [Dot (CALayer)]
       /
- - - /- - - - - - - - - - - - - -- - - - - - - - -  [GridLine (CAShapeLayer)] - -
     /                                                       [GridLabel (UILabel)]
    o
 
------------------------ [BottomAxisLine (CAShapeLayer)] -------------------------
 [BottomLeftAxisLabel (UILabel)]                  [BottomRightAxisLabel (UILabel)]

*/

import UIKit

class LineChartView: UIView {
    
    // ********************************************************************** //
    // MARK: - Public Members
    // ********************************************************************** //
    
    /* The color of the dots representing data points. */
    public var dotColor: UIColor = .systemBlue {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /* The color of lines connecting data points*/
    public var lineColor: UIColor = .systemBlue {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /* The color of the dotted drid lines in the middle of the graph. */
    public var gridLineColor: UIColor = .systemGray3 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /* The color of the labes under te dotted grid lines. */
    public var gridLabelTextColor: UIColor = .systemGray3 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /* The color of top or bottom axis lines. */
    public var axisLineColor: UIColor = .systemGray2 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /* The color of labels under the top or bottom axis line.*/
    public var axisLabelTextColor: UIColor = .systemGray2 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    
    /// Adds a point for each CGPoint given in the data. Lines will connect those
    /// points.
    ///
    /// - Parameters:
    ///     - data: An array of CGPoints containing the data that will be displayed.
    public func setData(data: [CGPoint]) {
        
        self.data = data
        
        dots.forEach({$0.removeFromSuperlayer()})
        dots.removeAll()
        dots = createDots()
        
        lines.forEach({$0.removeFromSuperlayer()})
        lines.removeAll()
        lines = createLines()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /// Adds a dotted horizontal line with a label to the view.
    ///
    /// - Parameters:
    ///     - yVal: The y position of the line.
    ///     - text: The text that will appear below the line.
    public func addGridLine(atYVal yVal: CGFloat, withText text: String?) {
        
        gridLineYValues.append(yVal)
        gridLinesTexts.append(text)
        
        gridLines.forEach({$0.removeFromSuperlayer()})
        gridLines.removeAll()
        gridLines = createGridLines()
        
        gridLabels.forEach({$0.removeFromSuperview()})
        gridLabels.removeAll()
        gridLabels = createGridLabels()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /// Adds a solid line to the top of the view. The line can have a left and right
    /// label.
    ///
    /// - Parameters:
    ///     - leftText: Text that appears below the line to the left.
    ///     - rightText: Text that appears below the line to the right.
    public func addTopAxisLine(leftText: String?, rightText: String?) {
        
        topAxisLine.isHidden = false
        
        topLeftAxisLabel.text = leftText?.uppercased()
        topLeftAxisLabel.sizeToFit()
        
        topRightAxisLabel.text = rightText?.uppercased()
        topRightAxisLabel.sizeToFit()
        
        setNeedsLayout()
        layoutIfNeeded()
        
    }
    
    /// Adds a solid line to the bottom of the view. The line can have a left and
    /// right label.
    ///
    /// - Parameters:
    ///     - leftText: Text that appears below the line to the left.
    ///     - rightText: Text that appears below the line to the right.
    public func addBottomAxisLine(leftText: String?, rightText: String?) {
        
        botAxisLine.isHidden = false
        
        botLeftAxisLabel.text = leftText?.uppercased()
        botLeftAxisLabel.sizeToFit()
        
        botRightAxisLabel.text = rightText?.uppercased()
        botRightAxisLabel.sizeToFit()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    // ********************************************************************** //
    // MARK: - Constants & Variables
    // ********************************************************************** //
    
    private typealias AxisLine  = CAShapeLayer
    private typealias GridLine  = CAShapeLayer
    private typealias Dot       = CALayer
    private typealias Line      = CAShapeLayer
    private typealias AxisLabel = UILabel
    private typealias GridLabel = UILabel
    
    struct Constants {
        static let dotBorderThickness: CGFloat     = 2.5
        static let dotDiameter: CGFloat            = 12.0
        static let lineThickness: CGFloat          = 2.5
        static let gridLineThickness: CGFloat      = 0.5
        static let gridLineDashPattern: [NSNumber] = [4]
        static let gridLabelFont: UIFont           = UIFont.roundedFont(forTextStyle: .caption1).bold()
        static let axisLineThickness: CGFloat      = 0.5
        static let axisLabelFont: UIFont           = UIFont.roundedFont(forTextStyle: .caption1).bold()
        
    }
    
    /* These are the vertical positions the grid lines will be drawn at. */
    private var gridLineYValues: [CGFloat] = []
    
    /* This is an array of strings that are used to label the grid lines. */
    private var gridLinesTexts: [String?] = []
    
    /* This is the raw data that will be used in the plot. */
    private var data: [CGPoint] = []
    
    /* Appears in the top left corner under the top axis line. */
    private var topLeftAxisLabel: AxisLabel!
    
    /* Appears in the top right corner under the top axis line. */
    private var topRightAxisLabel: AxisLabel!
    
    /* Appears in the bottom left corner under the bottom axis line. */
    private var botLeftAxisLabel: AxisLabel!
    
    /* Appears in the bottom left corner under the bottom axis line. */
    private var botRightAxisLabel: AxisLabel!
    
    /* Appears at the very top of the view.  */
    private var topAxisLine: AxisLine!
    
    /* Appears at the very bottom of the view above the bottom axis labels. */
    private var botAxisLine: AxisLine!
    
    /* Appear as horizontal lines in the within the view. */
    private var gridLines: [GridLine] = []
    
    /* Appear to the right under each drid line. */
    private var gridLabels: [GridLabel] = []
    
    /* These are the lines connecting the dots. */
    private var lines: [Line] = []
    
    /* These are the dots reporesenting the data. */
    private var dots: [Dot] = []

    // ********************************************************************** //
    // MARK: - Initialization
    // ********************************************************************** //
    
    init() {
        super.init(frame: .zero)
        self.topAxisLine       = createAxisLine()
        self.botAxisLine       = createAxisLine()
        self.topLeftAxisLabel  = createTopLeftAxisLabel()
        self.topRightAxisLabel = createTopRightAxisLabel()
        self.botLeftAxisLabel  = createBotLeftAxisLabel()
        self.botRightAxisLabel = createBotRightAxisLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ********************************************************************** //
    // MARK: - Lifecycle
    // ********************************************************************** //
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Only here do we know the correct bounds of the view.
        // So this is where we position items.
        layoutTopAxisLine()
        layoutBottomAxisLine()
        layoutDots()
        layoutLines()
        layoutGridLines()
        layoutGridLabels()
    }
    
    // ********************************************************************** //
    // MARK: - Labels
    // ********************************************************************** //
    
    /// Creates and returns the UILabel that represents the TopLeftAxisLabel at the
    /// top left corner of the view. The label starts with no text.
    ///
    /// - Returns:
    ///     - The UILabel that was created.
    private func createTopLeftAxisLabel() -> AxisLabel {
        let label = AxisLabel()
        label.font          = Constants.axisLabelFont
        label.textColor     = axisLabelTextColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.topAnchor.constraint(equalTo: topAnchor)
        ])
        return label
    }
    
    /// Creates and returns the UILabel that represents the TopRightAxisLabel at the
    /// top right corner of the view. The label starts with no text.
    ///
    /// - Returns:
    ///     - The UILabel that was created.
    private func createTopRightAxisLabel() -> AxisLabel {
        let label = AxisLabel()
        label.font          = Constants.axisLabelFont
        label.textColor     = axisLabelTextColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.topAnchor.constraint(equalTo: topAnchor)
        ])
        return label
    }
    
    /// Creates and returns the UILabel that represents the BottomLeftAxisLabel
    /// at the bottom left corner of the view. The label starts with no text.
    ///
    /// - Returns:
    ///     - The UILabel that was created.
    private func createBotLeftAxisLabel() -> AxisLabel {
        let label = AxisLabel()
        label.font          = Constants.axisLabelFont
        label.textColor     = axisLabelTextColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return label
    }
    
    /// Creates and returns the UILabel that represents the BottomRightAxisLabel
    /// at the bottom right corner of the view. The label starts with no text.
    ///
    /// - Returns:
    ///     - The UILabel that was created.
    private func createBotRightAxisLabel() -> AxisLabel {
        let label = AxisLabel()
        label.font          = Constants.axisLabelFont
        label.textColor     = axisLabelTextColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return label
    }
    
    /// Creates and returns the UILabels that appear right below each grid line.
    ///
    /// - Returns:
    ///     - An array of UILabels uses as grid labels.
    private func createGridLabels() -> [GridLabel] {
        var labels: [UILabel] = []
        
        for string in gridLinesTexts {
            let label = UILabel()
            label.text = string
            label.font = Constants.gridLabelFont
            label.textColor = gridLabelTextColor
            label.sizeToFit()
            addSubview(label)
            labels.append(label)
        }
        
        return labels
    }
    
    /// Positions each grid label right below its respective grid line.
    private func layoutGridLabels() {
        
        for (label, yVal) in zip(gridLabels, gridLineYValues) {
            let xOrigin = bounds.width - label.frame.width
            let yOrigin = normalizeY(yVal: yVal)
            label.frame.origin = CGPoint(x: xOrigin, y: yOrigin)
        }
        
    }
    
    // ********************************************************************** //
    // MARK: - Lines
    // ********************************************************************** //
    
    
    /// Creates and returns a small line at the that is used as
    /// an axis line. These will be above or below the data.
    ///
    /// - Returns:
    ///     - The CAShapeLayer created that is used as the line.
    private func createAxisLine() -> AxisLine {
        let line = AxisLine()
        line.isHidden = true
        line.fillColor = UIColor.clear.cgColor
        line.strokeColor = axisLineColor.cgColor
        line.lineWidth = Constants.axisLineThickness
        layer.addSublayer(line)
        return line
    }
    
    /// Positions the top axis line at the top of the view.
    private func layoutTopAxisLine() {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: bounds.width, y: .zero))
        topAxisLine.path = path.cgPath
    }
    
    /// Positions the bottom axis line right above the bottom axis labels.
    /// If there are not bottom axis labels then the line is put all the way at
    /// the bottom of the view.
    private func layoutBottomAxisLine() {
        
        let bottomPadding = max(
            botLeftAxisLabel.frame.height,
            botRightAxisLabel.frame.height
        )
        
        let p1 = CGPoint(x: .zero, y: bounds.height - bottomPadding)
        let p2 = CGPoint(x: bounds.width, y: bounds.height - bottomPadding)
        
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        botAxisLine.path = path.cgPath
    }
    
    /// Creats lines for each pair of points and returns them as an array.
    /// These lines start as CAShape layers. Their paths are added later.
    ///
    /// - Returns:
    ///     - An array of lines.
    private func createLines() -> [Line] {
        var lines: [Line] = []
        lines = (1..<data.count).map({_ in Line()})
        for line in lines {
            line.fillColor   = UIColor.clear.cgColor
            line.strokeColor = lineColor.cgColor
            line.lineWidth   = Constants.lineThickness
            layer.addSublayer(line)
        }
        return lines
    }
    
    /// Positions all the lines to be between points in the view.
    /// These lines exist between points. 
    private func layoutLines() {
        
        for (line, (dotStart, dotEnd)) in zip(lines, zip(dots.dropLast(), dots.dropFirst())) {
            
            // We extract the origins from each point.
            let startPoint = dotStart.frame.origin
            let endPoint = dotEnd.frame.origin
            
            // We need the centers of each dot.
            let startCenter = CGPoint(
                x: startPoint.x + Constants.dotDiameter/2,
                y: startPoint.y + Constants.dotDiameter/2
            )
            
            let endCenter = CGPoint(
                x: endPoint.x + Constants.dotDiameter/2,
                y: endPoint.y + Constants.dotDiameter/2
            )
            
            
            // We make the line exist between these two points.
            let path = UIBezierPath()
            path.move(to: startCenter)
            path.addLine(to: endCenter)
            line.path = path.cgPath
            
            // Finally, we shorten the line just a bit so it doesnt overlap
            // with the center of the dots. We want these lines to only exist
            // *between* the dots.
            let distance = distanceBetweenPoints(startPoint, endPoint)
            let radius = Constants.dotDiameter/2
            line.strokeStart = radius/distance
            line.strokeEnd = 1 - radius/distance
            
        }

    }
    
    /// Creates and returns a grid line for each y value given in
    /// the 'gridLineYValues'. These grid lines are positioned later during layout.
    ///
    /// - Returns:
    ///     - A list of grid lines.
    private func createGridLines() -> [GridLine] {
        
        var gridLines: [GridLine] = []
        
        for _ in gridLineYValues {
            let gridLine = GridLine()
            gridLine.fillColor       = UIColor.clear.cgColor
            gridLine.strokeColor     = gridLineColor.cgColor
            gridLine.lineWidth       = Constants.gridLineThickness
            gridLine.lineDashPattern = Constants.gridLineDashPattern
            layer.addSublayer(gridLine)
            gridLines.append(gridLine)
        }
        
        return gridLines
    }
    
    /// For each grid line we position it correctly be creating a horizontal path
    /// whose y value is the normalized verison of the cooresponding y value given.
    private func layoutGridLines() {
        
        for (gridLine, yVal) in zip(gridLines, gridLineYValues) {
            let yPos = normalizeY(yVal: yVal)
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: yPos))
            path.addLine(to: CGPoint(x: bounds.width, y: yPos))
            gridLine.path = path.cgPath
        }
        
    }
    
    // ********************************************************************** //
    // MARK: - Dots
    // ********************************************************************** //
    
    /// When data is set this is called. An array of dots are created and returned.
    /// They all start at the origin and will be positioned layer in the layoutDots
    /// method.
    ///
    /// - Returns:
    ///     - An array of dots that were created.
    private func createDots() -> [Dot] {
        
        var dots: [Dot] = []
        
        for _ in data {
            let dot = Dot()
            dot.frame.size      = CGSize(width: Constants.dotDiameter, height: Constants.dotDiameter)
            dot.cornerRadius    = Constants.dotDiameter / 2
            dot.backgroundColor = UIColor.clear.cgColor
            dot.borderColor     = dotColor.cgColor
            dot.borderWidth     = Constants.dotBorderThickness
            layer.addSublayer(dot)
            dots.append(dot)
        }
        
        return dots
    }
    
    /// Positions all the dots to the correct position in the view.
    /// The dots can exist between the top and bottom axis lines.
    private func layoutDots() {
        
        // Short names to prevent super long lines.
        let dotRadius = Constants.dotDiameter / 2
        
        // We also sort the data so our list of dots becomes ordered
        // by x value.
        let sortedData = data.sorted(by: {$0.x < $1.x})
        
        // Next we need to calculate where each datapoint goes within this area.
        for (datum, dot) in zip(sortedData, dots) {
            
            // We then use a ratio between these values to find the normalized
            // location for each dot.
            //var xNormalized = CGFloat((x - xMin) / (xMax - xMin)) * area.width
            let yNormalized = normalizeY(yVal: datum.y)
            let xNormalized = normalizeX(xVal: datum.x)
                        
            // These normalized positions refer to the centers of where each dot
            // should be. To position the dots correctly we worry about the
            // origin - not the center.
            let xOrigin = xNormalized - dotRadius
            let yOrigin = yNormalized - dotRadius
            
            // Finally, we position the dot.
            dot.frame.origin = CGPoint(x: xOrigin, y: yOrigin)
        }
        
    }
    
    
    
    // ********************************************************************** //
    // MARK: - Helpers & Utilities
    // ********************************************************************** //
    
    /// Finds the distane between two CGPoints.
    ///
    /// - Parameters:
    ///     - a: A CGPoint
    ///     - b: Another CGPoint
    ///
    /// - Returns:
    ///     - A CFloat representing the distance between the given CGPoints.
    private func distanceBetweenPoints(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        return sqrt( pow(a.x - b.x, 2) + pow(a.y - b.y, 2) )
    }
    
    
    /// Takes a given xValue and calculates where that x value corresponds to
    /// in the bounds of the view.
    ///
    /// - Parameters:
    ///     - xVal: A given xValue.
    ///
    /// - Returns:
    ///     - The CGFloat representing that xValues position in the view.
    private func normalizeX(xVal: CGFloat) -> CGFloat {
        
        // We need the area in which content can exist.
        let area = CGRect(
            x: .zero,
            y: .zero,
            width: bounds.width,
            height: bounds.height - max(botLeftAxisLabel.frame.height, botRightAxisLabel.frame.height)
        )
        
        // We take some raw values from the data.
        var x    = xVal
        var xMax = data.map({$0.x}).max() ?? .zero
        var xMin = data.map({$0.x}).min() ?? .zero
        
        // To make calculation easy, we make them all positive by adding an
        // offset equal to the minumium for that dimension.
        let xOffset = abs(xMin)
        x    += xOffset
        xMax += xOffset
        xMin += xOffset
        
        var xNormalized = CGFloat((x - xMin) / (xMax - xMin)) * area.width
        xNormalized += area.origin.x
        
        return xNormalized
        
    }
    
    /// Takes a given yValue and calculates where that y value corresponds to
    /// in the bounds of the view.
    ///
    /// - Parameters:
    ///     - yVal: A given yValue.
    ///
    /// - Returns:
    ///     - The CGFloat representing that yValues position in the view.
    private func normalizeY(yVal: CGFloat) -> CGFloat {
        
        // We need the area in which content can exist.
        let area = CGRect(
            x: .zero,
            y: .zero,
            width: bounds.width,
            height: bounds.height - max(botLeftAxisLabel.frame.height, botRightAxisLabel.frame.height)
        )
        
        // We take some raw values from the data.
        var y    = yVal
        var yMax = data.map({$0.y}).max() ?? .zero
        var yMin = data.map({$0.y}).min() ?? .zero
        
        // To make calculation easy, we make them all positive by adding an
        // offset equal to the minumium for that dimension.
        let yOffset = abs(yMin)
        y    += yOffset
        yMax += yOffset
        yMin += yOffset
        
        var yNormalized = area.height - CGFloat((y - yMin) / (yMax - yMin)) * area.height
        yNormalized += area.origin.y
        
        return yNormalized
        
    }
    
    
    
    
}
