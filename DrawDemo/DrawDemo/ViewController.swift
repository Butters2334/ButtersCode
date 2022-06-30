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
        return 999
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                            indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        let draw = cell.viewWithTag(100) as! Draw
        draw.pointCount = indexPath.item + 3
        draw.drawWidth = cellWidth
        draw.drawHeight = cellWidth
        draw.drawPolygon()
        let button = cell.viewWithTag(101) as! UIButton
        button.setTitle("\(draw.pointCount)", for: .normal)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let but = sender as! UIButton
        let draw = but.superview?.viewWithTag(100) as! Draw
        let vc = segue.destination;
        vc.view.layoutIfNeeded()
        let vcDrawView = vc.view.viewWithTag(100) as! Draw
        vcDrawView.layerFillColor = draw.layerFillColor
        vcDrawView.pointCount = draw.pointCount
        vcDrawView.drawWidth = vcDrawView.frame.size.width
        vcDrawView.drawHeight = vcDrawView.frame.size.height
        vcDrawView.drawPolygon()
    }
}

