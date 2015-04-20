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
    super.drawRect(rect)
    let rectanglePath = UIBezierPath(roundedRect: rect, cornerRadius: 6)
    color.setFill()
    rectanglePath.fill()
  }

}
