// Copyright (c) 2022 Detsky Mir PJSC. All rights reserved.

import RxCocoa
import RxSwift
import SnapKit
import RxDataSources
import UIKit

final class MainView: UIView {
    private enum Constants {
        static let collectionViewInsets: UIEdgeInsets = .init(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0
              )
      static let horizontalInset: CGFloat = 24
      static let minimumLineSpacing: CGFloat = 20
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        return layout
    }()
    
    fileprivate lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
    )
    
    fileprivate lazy var dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<(String, String), MainCollectionViewCell.Model>>(
        configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainCollectionViewCell.id,
                    for: indexPath
                ) as? MainCollectionViewCell
            else { return UICollectionViewCell() }

            cell.configure(with: item)
            
            return cell
        },
        configureSupplementaryView: { [weak self] dataSource, collectionView, kind, indexPath -> UICollectionReusableView in
            guard
                let self = self,
                kind == UICollectionView.elementKindSectionHeader
            else { return collectionView.dequeueEmptyReusableView(at: indexPath) }

            collectionView.registerReusableClass(
                GenericCollectionReusable<MainCollectionHeaderView>.self,
                viewOfKind: UICollectionView.elementKindSectionHeader
            )
            let headerView = collectionView.dequeueReusableView(
                ofType: GenericCollectionReusable<MainCollectionHeaderView>.self,
                viewOfKind: UICollectionView.elementKindSectionHeader,
                at: indexPath
            )
            
            headerView.view.configure(
                with: .init(
                    day: dataSource[indexPath.section].model.0,
                    group: dataSource[indexPath.section].model.1
                )
            )
            
            return headerView
        }
    )

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        addSubview(collectionView)
        collectionView.delegate = self
        
        makeConstraints()
        setupBindings()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: MainView {
    var items: (Observable<[SectionModel<(String, String), MainCollectionViewCell.Model>]>) -> Disposable {
        base.collectionView.rx.items(dataSource: base.dataSource)
    }
}

private extension MainView {
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    func setupBindings() {}
}

extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let headerView = GenericCollectionReusable<MainCollectionHeaderView>()
        headerView.view.configure(
            with: .init(
                day: dataSource[section].model.0,
                group: dataSource[section].model.1)
        )
        let size = headerView.systemLayoutSizeFitting(
            CGSize(width: collectionView.bounds.width, height: .zero),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return .init(
            width: collectionView.bounds.width,
            height: size.height.rounded(.up)
        )
    }
}
