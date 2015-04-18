//
//  ViewController.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/15/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  private var collectionViewDataSource: CollectionViewDataSource!
  private var cellSizeCache = NSCache()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure collection view
    collectionViewDataSource = CollectionViewDataSource(collectionView: collectionView)
    collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.Const.ReuseIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = collectionViewDataSource
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

// MARK: - UICollectionViewFlowLayout Delegate

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    // If fitted size was computed in the past for this cell, return it from cache
    if let size = cellSizeCache.objectForKey(indexPath) as? NSValue {
      return size.CGSizeValue()
    }
    
    // Get a configured prototype cell
    let cell = collectionViewDataSource.configuredCellForIndexPath(indexPath, prototype: true) as! ContentAwareCollectionViewCell
    // Set a constrained size for the cell
    // *In this case we choose to constrain based on the width
    let width: CGFloat = collectionView.bounds.width / 3 - 10
    let height = CGFloat.max
    let constrainedSize = CGSize(width: width, height: height)
    
    // Finally get what we wanted, the fitted size for this cell
    let size = cell.fittedSizeForConstrainedSize(constrainedSize)
    
    // Cache it
    cellSizeCache.setObject(NSValue(CGSize: size), forKey: indexPath)
    
    return size
  }
  
}