//
//  CollectionViewDataSource.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/17/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

protocol ContentAwareCollectionViewDataSource {
  func configuredCellForIndexPath(indexPath: NSIndexPath, prototype: Bool) -> UICollectionViewCell
}

class CollectionViewDataSource: NSObject {
  
  var data = [AnyObject]()
  var prototypeCells = NSCache()
  var collectionView: UICollectionView!
  
  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    
    // Some dummy data
    let poems = [
      "in the parking lot this new fallen snow- much of it Reserved",
      "the scent of spring each time you're passing by - midwinter's daydream",
      "A mocking bird sings Moonlight silvers cat whiskers Dozing, she listens",
      "outside the deer park along the chainlink fence deer tracks in the snow",
      "on a receipt in shaky letters, times of early contractions",
      "A haiku critic deflowering* a daisy - haiku... not haiku..",
      "after the rain walking on moonlight",
      "my teapot, whistling like I can't hear it",
      "raising her voice trying to make him understand English",
      "the rain falls... feeding some things rusting others",
      "at night's end a small summer moon - field daisies",
      "making the tea the quiet of dawn - in a grey light",
      "slate grey sky in a shaft of sun gull's white underbelly",
      "heavy showers the cold front passes a flux of starlings",
      "sun breaking through white plumage brighter six little egrets",
      "as daylight fades beech leaves turning copper brown",
      "moments before dawn cool breeze in the unblackness anticipation",
      "the blind man crosses then amidst the crowd softly praises his dog",
      "unexpectedly the shadows from our past intruding",
      "empty street at noon on a school day a dog paces",
      "A bird in a cage of seventeen syllables singing happily",
      "split logs crackle while a winter wind howls into the darkness",
      "venetian blinds imprisoned bowl of red apples",
      "sparks rise in the night: even now the old tree still aspires to the stars",
      "in the shade of the fattest pumpkin sparrows pecking sand",
      "In desolate woods Amidst sea of fallen leaves Cry of distant crow",
      "abandoned house remains of a garden silent rain",
      "huge waves crashing along the pier mist rises",
      "Dividing the fog silently, tall pines",
      "in his jacket pocket a lemon candy from the funeral home"
    ]
    
    func getRandomColor() -> UIColor {
      let colors = [
        UIColor(red:0.4, green:0.23, blue:0.72, alpha:1.0),
        UIColor(red:0.01, green:0.53, blue:0.82, alpha:1.0),
        UIColor(red:0.01, green:0.66, blue:0.96, alpha:1.0),
        UIColor(red:0.27, green:0.54, blue:1.0, alpha:1.0)
      ]
      return colors[Int(arc4random_uniform(UInt32(colors.count)))]
    }

    for poem in poems {
      data.append(Poem(text: poem, moodColor: getRandomColor()))
    }
  }
  
}

// MARK: - UICollectionViewDataSource

extension CollectionViewDataSource: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = configuredCellForIndexPath(indexPath, prototype: false)
    cell.setNeedsLayout()
    return cell
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
}

// MARK: - Cell configuration

extension CollectionViewDataSource: ContentAwareCollectionViewDataSource {
  
  func configuredCellForIndexPath(indexPath: NSIndexPath, prototype: Bool) -> UICollectionViewCell {
    let cell = reusableCellForIndexPath(indexPath, prototype: prototype) as! CollectionViewCell
    let model: AnyObject = data[indexPath.row]
    cell.configure(model, prototype: prototype)
    return cell
  }
  
  private func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
    let model: AnyObject = data[indexPath.row]
    
    // Return reuseIdentifier based on model
    switch model {
    case let model as Poem:
      return CollectionViewCell.Const.ReuseIdentifier
    default:
      abort()
    }
  }
  
  private func reusableCellForIndexPath(indexPath: NSIndexPath, prototype: Bool) -> UICollectionViewCell {
    // Get reuse identifier
    let cellId = cellIdentifierForIndexPath(indexPath)
    
    // Return protoype if needed
    if prototype {
      return prototypeCellForIdentifier(cellId)
    }
    
    // Return dequeued cell
    return collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) 
  }
  
  private func prototypeCellForIdentifier(reuseIdentifier: String) -> UICollectionViewCell {
    // Try to fetch prototype from cache
    if let cell = prototypeCells.objectForKey(reuseIdentifier) as? UICollectionViewCell {
      return cell
    }
    
    // Create new cell for reuseIdentifier
    var cell: UICollectionViewCell
    switch reuseIdentifier {
    case CollectionViewCell.Const.ReuseIdentifier:
      cell = CollectionViewCell()
    default:
      abort()
    }
    
    // Cache it
    prototypeCells.setObject(cell, forKey: reuseIdentifier)
    
    return cell
  }
  
  
}
