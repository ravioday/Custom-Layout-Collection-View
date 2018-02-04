//
//  ViewController.swift
//  circular-layout-collection
//
//  Created by Ravi Joshi on 2/1/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

struct Item {
    var name: String
    var color: UIColor
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let itemsArray = [Item(name: "Item 1", color: .orange), Item(name: "Item 2", color: .green), Item(name: "Item 3", color: .blue),
                      Item(name: "Item 4", color: .red), Item(name: "Item 5", color: .black),
                      Item(name: "Item 6", color: .gray), Item(name: "Item 7", color: .yellow)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circularLayout = CircularCollectionViewLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 10.0, y: 10.0, width: UIScreen.main.bounds.width-20.0, height: UIScreen.main.bounds.height),
                                              collectionViewLayout: circularLayout)
        collectionView.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier())
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier(), for: indexPath)
        let item = itemsArray[indexPath.item]
        cell.contentView.backgroundColor = item.color
        return cell
    }
}

