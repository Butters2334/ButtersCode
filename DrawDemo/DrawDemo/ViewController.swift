//
//  ViewController.swift
//  DrawDemo
//
//  Created by ac on 2022/6/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var colllectionView: UICollectionView!
    
    var cellGap:CGFloat = 15.0
    var cellWidth:CGFloat = 0.0
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let appWidth = UIScreen.main.bounds.size.width
            cellWidth = (appWidth - cellGap * 2)/3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                            indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        let draw = cell.subviews[0].subviews[0] as! Draw
        draw.pointCount = indexPath.item + 3
        draw.drawWidth = cellWidth
        draw.drawHeight = cellWidth
        draw.drawPolygon()
        let label = cell.subviews[0].subviews[1] as! UILabel
        label.text = "\(draw.pointCount)"
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let appWidth = UIScreen.main.bounds.size.width
        let cellWidth = (appWidth - cellGap * 2)/3
        return CGSize(width: cellWidth,height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellGap
    }
}

