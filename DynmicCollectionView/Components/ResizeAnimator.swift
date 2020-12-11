//
//  ResizeAnimator.swift
//  DynmicCollectionView
//
//  Created by abuzeid on 09.12.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import UIKit
protocol ResizeAnimatorType {
    func animate(cell: UIView, at indexPath: IndexPath, with scale: CGFloat)
}

final class ResizeAnimator: ResizeAnimatorType {
    let collectionView: UICollectionView
    let measures: CollectionMeasures
    init(collectionView: UICollectionView,
         measures: CollectionMeasures) {
        self.collectionView = collectionView
        self.measures = measures
    }

    func animate(cell: UIView, at indexPath: IndexPath, with scale: CGFloat) {
        guard measures.canScaleWidth(for: indexPath, scale: scale) else { return }
        let indexes = measures.indexPathsInTheSameRow(for: indexPath.row, excludeMe: true)
        let unScale = measures.unScaleValue(scale: scale)
        for index in indexes {
            let sameRowCell = collectionView.cellForItem(at: index)!
            sameRowCell.transform = sameRowCell.transform
                .scaledBy(x: unScale, y: 1.0)
                .translatedBy(x: measures.translate(scale: unScale, for: index, source: indexPath), y: 0.0)
        }
        cell.transform = cell.transform.scaledBy(x: scale, y: 1.0)
        measures.updateCellSizeScale(for: indexPath, scale: scale)
    }
}