//
//  GenericCollectoinReusableCell.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 14.12.2022.
//

import RxSwift
import SnapKit
import UIKit

public final class GenericCollectionReusable<View: UIView>: UICollectionReusableView {
    public let view = View()

    public private(set) lazy var disposedOnReuseBag = DisposeBag()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        disposedOnReuseBag = DisposeBag()
    }
}

private extension GenericCollectionReusable {
    func makeConstraints() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

