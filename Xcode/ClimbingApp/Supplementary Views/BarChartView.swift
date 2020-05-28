//
//  BarChartView.swift
//  ClimbingApp
//
//  Created by Matt Marks on 1/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

/*
 
 The anatomy of BarChartView:
 
 
                                ___
                               |   |
          [Cell (CALayer)] --> |   |
                               |___|
            ___                 ___                           ___
           |   |               |   |                         |   |
           |   |               |   |                         |   |
           |___|               |___|                         |___|
  ___       ___                 ___  ___  ___  ___            ___
 |   |     |   |               |   ||   ||   ||   |          |   |
 |   |     |   |               |   ||   ||   ||   |          |   |
 |___|     |___|               |___||___||___||___|          |___|
  ___  ___  ___            ___  ___  ___  ___  ___  ___  ___  ___       ___  ___
 |   ||   ||   |          |   ||   ||   ||   ||   ||   ||   ||   |     |   ||   |
 |   ||   ||   |          |   ||   ||   ||   ||   ||   ||   ||   |     |   ||   |
 |___||___||___|          |___||___||___||___||___||___||___||___|     |___||___|
 --------------------------- [AxisLine (CAShapeLayer)] ---------------------------
  [LeftAxisLabel (UILabel)]                            [RightAxisLabel (UILabel)]
 
 */

import UIKit

class BarChartView: UIView {
    
    // ********************************************************************** //
    // MARK: - Public Members
    // ********************************************************************** //
    
    
    public func setVerticalSpacing(_ spacing: CGFloat) {
        // If vertical spacing is 0.0 then the cells become merged. Only the
        // corners of each bar maintain their corner radius.
        cellVertivalSpacing = spacing
        
        cells.values.forEach({$0.removeFromSuperlayer()})
        cells.removeAll()
        cells = createCells(data: data)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public func setHorizontalSpacing(_ spacing: CGFloat) {
        cellHorizontalSpacing = spacing
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public func setData(data: [Int]) {
        
        self.data = data
        
        cells.values.forEach({$0.removeFromSuperlayer()})
        cells.removeAll()
        cells = createCells(data: data)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    public func addBottomAxisLine(leftLabel: String? = nil, rightLabel: String? = nil) {

        axisLine.isHidden = false
        
        leftAxisLabel.text = leftLabel?.uppercased()
        leftAxisLabel.sizeToFit()
        
        rightAxisLabel.text = rightLabel?.uppercased()
        rightAxisLabel.sizeToFit()
        
        self.columnLabels.forEach({$0.removeFromSuperview()})
        self.columnLabels.removeAll()
          
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /// The number of column labels need to be the same as the number of columns.
    public func addBottomAxisLine(columnLabels: [String] = []) {

        axisLine.isHidden = false
        
        leftAxisLabel.text = nil
        leftAxisLabel.sizeToFit()
        
        rightAxisLabel.text = nil
        rightAxisLabel.sizeToFit()
        
        self.columnLabels.forEach({$0.removeFromSuperview()})
        self.columnLabels.removeAll()
        self.columnLabels = createColumnLabels(columnLabels)
          
        setNeedsLayout()
        layoutIfNeeded()
    }


    
    // ********************************************************************** //
    // MARK: - Constants & Variables
    // ********************************************************************** //
    
    private typealias Cell      = CALayer
    private typealias AxisLine  = CAShapeLayer
    private typealias AxisLabel = UILabel
    
    struct Constants {
        static let cellCornerRadius: CGFloat      = 3.0
        static let cellColor: UIColor             = .accent
        static let axisLineThickness: CGFloat     = 0.5
        static let axisLineColor: UIColor         = .accent
        static let axisLabelTextColor: UIColor    = .accent
        static let axisLabelFont: UIFont          = UIFont.roundedFont(forTextStyle: .caption1).bold()
    }
    
    /* This holds the row and column information for a given cell. Rows and columns
     increase from the top left to bottom right, with (0,0) being the top left. */
    private struct CellLocation: Hashable {
        let row: Int
        let column: Int
    }
    
    /* Each integer within the data array is equal to how many cells appear
    in a given column. The amount of columns is given by the length
    of the data array. */
    private var data: [Int] = []
    
    /* The left axis label appears at the bottom left of the bar chart. */
    private var leftAxisLabel: AxisLabel!
    
    /* The right axis label appears at the bottom right of the bar chart. */
    private var rightAxisLabel: AxisLabel!
    
    /* These labels appear centered under each column.
     If these exist, they must be the same in quantity as the number of columns. */
    private var columnLabels: [AxisLabel] = []
    
    /* The axis line appears directly above the axis labels of the bar chart. */
    private var axisLine: AxisLine!
    
    /* We initialize the bar chart by creating a grid of colorless cells and
     storing them in this dictionary. Then when layout events occur the cells that
     represent the data are colored properly. The keys are CellLocations, this is a
     structure that stores the row and column of the cell. The values are
     UIViews that prepresent the cells. */
    private var cells: [CellLocation : Cell] = [:]
    
    /* The horizontal spacing between the cells. */
    private var cellHorizontalSpacing: CGFloat = 10.0
    
    /* The vertical spacing between the cells. If this number is 0 we blend all
     the cells in each column together so they look like one bar. */
    private var cellVertivalSpacing: CGFloat = 2.0

    
    // ********************************************************************** //
    // MARK: - Initialization
    // ********************************************************************** //
    
    /// During initialization we make empty labels and lines.
    init() {
        super.init(frame: .zero)
        self.leftAxisLabel  = createLeftAxisLabel()
        self.rightAxisLabel = createRightAxisLabel()
        self.axisLine       = createAxisLine()
        
    }
    
    /// Required but unused.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ********************************************************************** //
    // MARK: - Lifecycle
    // ********************************************************************** //
    
    /// The bar chart contains a grid of colorless cells to start. Here, the cells
    /// are sized, positioned, and colored properly.
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAxisLine()
        layoutCells(data: data, cells: cells, axisLine: axisLine)
        layoutColumnLabels()
        
    }

    // ********************************************************************** //
    // MARK: - Lables
    // ********************************************************************** //
    
    /// Creates and returns the UILabel that represents the LeftAxisLabel at the
    /// bottom left corner of the view. The label starts with no text.
    ///
    /// - Returns:
    ///     - The UILabel that was created.
    private func createLeftAxisLabel() -> AxisLabel {
        let label = AxisLabel()
        label.font          = Constants.axisLabelFont
        label.textColor     = Constants.axisLabelTextColor
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
    
    /// Creates and returns the UILabel that represents the RightAxisLabel at the
    /// bottom right corner of the view. The label starts with no text.
    ///
    /// - Returns:
    ///     - The UILabel that was created.
    private func createRightAxisLabel() -> AxisLabel {
        let label = AxisLabel()
        label.font          = Constants.axisLabelFont
        label.textColor     = Constants.axisLabelTextColor
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
    
    /// Creates and returns a list of Axis Labels that constains one label for each
    /// string in the parameter. These labels will be positioined later - centered
    /// under each column.
    ///
    /// - Parameters:
    ///     - texts: An array of string that should be turned into labels.
    ///
    /// - Returns:
    ///     - An array of axis labels, one for each column.
    private func createColumnLabels(_ texts: [String]) -> [AxisLabel] {
        
        var labels: [AxisLabel] = []
        
        for text in texts {
            let label = AxisLabel()
            label.text          = text
            label.font          = Constants.axisLabelFont
            label.textColor     = Constants.axisLabelTextColor
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.sizeToFit()
            labels.append(label)
            addSubview(label)
        }
        
        return labels
        
    }
    
    /// Positions the column labels under the center of each column.
    private func layoutColumnLabels() {
        
        // We need a list of the center X values for each column.
        // We make this in two steps: First, we extract the centers for each cell.
        var centers = cells.values.map({$0.frame.midX})
        
        // Then, we remove duplicate values and sort the array.
        centers = Array(Set(centers)).sorted()
        
        // Applying the position.
        for (label, center) in zip(columnLabels, centers) {
            label.frame.origin = CGPoint(
                x: center - label.bounds.midX,
                y: bounds.height - label.frame.height
            )
        }
    }
    
    
    // ********************************************************************** //
    // MARK: - Cells
    // ********************************************************************** //
    
    /// Used to create the colorless set of colorless cells that initially populate
    /// view. These cells we be positioned, sized, and colored later. The amonut of
    /// rows and columns the grid has is given by the data.
    ///
    /// - Parameters:
    ///     - data: The data used to build the bar chart.
    ///
    /// - Returns:
    ///     - A dictionary with keys being cell locations and values being cells.
    private func createCells(data: [Int]) -> [CellLocation : Cell] {
        
        var cells: [CellLocation : Cell] = [:]
        
        let numColumns: Int = data.count
        
        // If the cells have no vertical spacing then only one bar is shown
        // per column. Thus we need just one cell.
        let numRows: Int = cellVertivalSpacing == 0 ? 1 : data.max() ?? 0
        
        for row in 0..<numRows {
            for col in 0..<numColumns {
                let cell = Cell()
                cell.cornerRadius = Constants.cellCornerRadius
                cell.backgroundColor = UIColor.clear.cgColor
                layer.addSublayer(cell)
                cells[CellLocation(row: row, column: col)] = cell
            }
        }
        
        return cells
    }
    
    /// Called in the 'layoutSubviews' method. This positions, sizes, and colors
    /// the cells within the bar chart. Only the cells that represent the data are
    /// colored in, however all cells are positioned and sized.
    ///
    /// - Parameters:
    ///     - data: The data used to build the bar chart.
    ///     - cells: A dictionary with cell location keys and cell values.
    ///     - axisLine: The small line that the cells appear above.
    private func layoutCells(
        data: [Int],
        cells: [CellLocation : Cell],
        axisLine: AxisLine
    ) {
        
        // Short variable names to keep line length down.
        let chs = cellHorizontalSpacing
        let cvs = cellVertivalSpacing
        let w   = bounds.width
        let b   = bounds.height - max(
            leftAxisLabel.frame.height,
            rightAxisLabel.frame.height,
            columnLabels.map({$0.frame.height}).max() ?? 0
        )
        
        
        // We find the size of the grid.
        let cols: Int = data.count
        let rows: Int = data.max() ?? 0
        
        // We find how wide and tall each cell should be.
        let cellWidth  = (w - ((CGFloat(cols) - 1) * chs)) / CGFloat(cols)
        let cellHeight = (b - ((CGFloat(rows) - 1) * cvs)) / CGFloat(rows)
        
        // Next, we position and shape the cells.
        // If the verical seperation is 0.0 then each column just has one large
        // cell. Otherwise, each column can have many cells.
        if cellVertivalSpacing == 0.0 {
            
            // We loop over all the cells and...
            for (loc, cell) in cells {
                // Position them.
                cell.frame.origin = CGPoint(
                    x: CGFloat(loc.column) * cellWidth + CGFloat(loc.column) * chs,
                    y: CGFloat(rows - data[loc.column]) * cellHeight
                )
                
                // Size them.
                cell.frame.size = CGSize(
                    width: cellWidth,
                    height: CGFloat(data[loc.column]) * cellHeight
                )
                
                // Since there is one cell per column we color each cell.
                cell.backgroundColor = Constants.cellColor.cgColor
            }
        } else {
            // We loop over all (a complete grid of cells) and...
            for (loc, cell) in cells {
                
                // Position them.
                cell.frame.origin = CGPoint(
                    x: CGFloat(loc.column) * cellWidth + CGFloat(loc.column) * chs,
                    y: CGFloat(loc.row) * cellHeight + CGFloat(loc.row) * cvs
                )
                
                // Size them.
                cell.frame.size = CGSize(
                    width: cellWidth,
                    height: cellHeight
                )
                
                // And color them if needed.
                if rows - data[loc.column] <= loc.row {
                    cell.backgroundColor = Constants.cellColor.cgColor
                }
                
            }
        }
        
        
        
        
        
    }
    
    // ********************************************************************** //
    // MARK: - Lines
    // ********************************************************************** //
    
    /// Creates and returns the CAShapeLayer used to represent the axis line at the
    /// bottom. It will be positioned later.
    ///
    /// - Returns:
    ///     - The CAShapeLayer created that is used as the line.
    private func createAxisLine() -> AxisLine {

        let line = AxisLine()
        line.isHidden = true
        line.fillColor = UIColor.clear.cgColor
        line.strokeColor = Constants.axisLineColor.cgColor
        line.lineWidth = Constants.axisLineThickness
        layer.addSublayer(line)
        return line

    }
    
    /// Positions the axis line at the bottom. It is placed above the axis labels,
    /// if there are any. Otherwise it is placed all the way at the bottom.
    private func layoutAxisLine() {
        
        let bottomPadding = max(
            leftAxisLabel.frame.height,
            rightAxisLabel.frame.height,
            columnLabels.map({$0.frame.height}).max() ?? 0
        )
        
        let p1 = CGPoint(x: .zero, y: bounds.height - bottomPadding)
        let p2 = CGPoint(x: bounds.width, y: bounds.height - bottomPadding)
        
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        axisLine.path = path.cgPath
    }

}
