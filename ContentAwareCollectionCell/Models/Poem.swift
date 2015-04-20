//
//  Poem.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/17/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

class Poem: NSObject {
  
  var text: String
  var moodColor: UIColor
  
  init(text: String, moodColor: UIColor) {
    self.text = text
    self.moodColor = moodColor
  }
   
}
