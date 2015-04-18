//
//  CellBubble.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/17/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

class CellBubble: UIView {
  
  var color: UIColor!
  
  override func drawRect(rect: CGRect) {
    let rectanglePath = UIBezierPath(roundedRect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height), cornerRadius: 6)
    color.setFill()
    rectanglePath.fill()
  }
  
}
