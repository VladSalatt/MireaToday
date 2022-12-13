//
//  UICollection+Ext.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 13.12.2022.
//

import UIKit

/// Reuse identifiable type provides a reuse identifier, that could be used in appropriate methods of collection views
public protocol ReuseIdentifiable: AnyObject {}

public extension ReuseIdentifiable {
    /// The reuse identifier. It's equal to class name.
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

// MARK: - Conforming types

extension UITableViewCell: ReuseIdentifiable {}
extension UITableViewHeaderFooterView: ReuseIdentifiable {}
extension UICollectionReusableView: ReuseIdentifiable {}


extension UICollectionView {
    /// Регистрирует класс view для использования в `UICollectionReusableView`
    ///
    /// - Parameter viewType: Тип view, которая реализует протокол `ReusableView`
    func registerReusableClass<T>(_ viewType: T.Type, viewOfKind: String) where T: UICollectionReusableView {
        register(viewType, forSupplementaryViewOfKind: viewOfKind, withReuseIdentifier: viewType.reuseIdentifier)
    }
    
    /// Возвращает экземпляр переиспользуемой view по ее типу.
    ///
    /// - Parameters:
    ///   - viewType: Тип view (должна реализовывать протокол ReusableView).
    ///   - indexPath: Index path.
    /// - Returns: Экземпляр view.
    func dequeueReusableView<T>(ofType viewType: T.Type, viewOfKind: String, at indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: viewOfKind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
        ) as? T else {
            preconditionFailure("❌ Не удалось найти view с идентификатором \(viewType.reuseIdentifier)!")
        }
        return view
    }
    
    /// From Apple Docs:
    /// If you do not want a supplementary view in a particular case, your layout object should not create the attributes for that view. Alternatively, you
    /// can hide views by setting the isHidden property of the corresponding attributes to true or set the alpha property of the attributes to 0. To hide header
    /// and footer views in a flow layout, you can also set the width and height of those views to 0.
    /// - Parameters:
    ///     - indexPath: IndexPath
    /// - Returns: Invisible reusable view
    func dequeueEmptyReusableView(at indexPath: IndexPath) -> UICollectionReusableView {
        registerReusableClass(UICollectionReusableView.self, viewOfKind: UICollectionView.elementKindSectionHeader)

        let view = dequeueReusableView(
            ofType: UICollectionReusableView.self,
            viewOfKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        )
        view.frame.size.width = 0
        view.frame.size.height = 0
        return view
    }
}
