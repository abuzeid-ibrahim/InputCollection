//
//  DeleteCell.swift
//  DynmicCollectionView
//
//  Created by abuzeid on 10.12.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import SwiftUI
import UIKit

final class DeleteCell: UICollectionViewCell {
    private var tapEvent: DoubleTapEvent?
    private lazy var deleteButton: UIButton = {
        let view = UIButton()
        if let image = UIImage(named: "delete-icon") {
            view.setImage(image, for: .normal)
        }
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        return view
    }()

    func set(onTap: @escaping DoubleTapEvent) {
        tapEvent = onTap
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        tapEvent = nil
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("no implemented")
    }
}

private extension DeleteCell {
    func setup() {
        contentView.backgroundColor = .clear
        contentView.addSubview(deleteButton)
        deleteButton.setConstrainsEqualToParentEdges(top: 12, bottom: 12, leading: 12, trailing: 12)
    }

    @objc func didTap(_ sender: UITapGestureRecognizer) {
        tapEvent?()
    }
}
