//
//  CollectionViewCell.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/17/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

protocol ContentAwareCollectionViewCell {
  func configure(#model: AnyObject, prototype: Bool)
  func fittedSizeForConstrainedSize(constrainedSize: CGSize) -> CGSize
}

class CollectionViewCell: UICollectionViewCell, ContentAwareCollectionViewCell {
  
  struct Const {
    static var ReuseIdentifier = "CollectionViewCell"
  }
  
  let TextLabelSidePadding: CGFloat = 8.0
  
  let textLabel = UILabel()
  let containerView = CellBubble()
  
  convenience init() {
    self.init(frame: CGRect.zeroRect)
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    contentView.addSubview(containerView)
    containerView.backgroundColor = UIColor.whiteColor()
    containerView.color = getRandomColor()
    textLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
    textLabel.textColor = UIColor.whiteColor()
    textLabel.numberOfLines = 0
    textLabel.lineBreakMode = .ByWordWrapping
    containerView.addSubview(textLabel)
  }
  
  func configure(#model: AnyObject, prototype: Bool) {
    let poem = model as! Poem
    textLabel.text = poem.text
  }
  
  func fittedSizeForConstrainedSize(size: CGSize) -> CGSize {
    let textLabelConstrainedSize = CGSize(width: size.width - TextLabelSidePadding * 2.0, height: size.height - TextLabelSidePadding * 2.0)
    let textLabelSize = textLabel.sizeThatFits(textLabelConstrainedSize)
    // The cell itself chooses its own size based on its content and constrains from the collection view
    return CGSize(width: size.width, height: textLabelSize.height + TextLabelSidePadding * 2.0)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerView.frame = contentView.bounds
    let textLabelFrame = CGRectInset(containerView.bounds, TextLabelSidePadding, TextLabelSidePadding)
    textLabel.frame = textLabelFrame
  }
  
  private func getRandomColor() -> UIColor {
    let colors = [
      UIColor(red:0.4, green:0.23, blue:0.72, alpha:1.0),
      UIColor(red:0.01, green:0.53, blue:0.82, alpha:1.0),
      UIColor(red:0.01, green:0.66, blue:0.96, alpha:1.0),
      UIColor(red:0.27, green:0.54, blue:1.0, alpha:1.0)
    ]
    return colors[Int(arc4random_uniform(UInt32(colors.count)))]
  }

}
