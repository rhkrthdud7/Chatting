//
//  Reusable.swift
//  Chatting
//
//  Created by Soso on 05/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var dentifier: String { get }
}

extension Reusable {
    static var dentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionReusableView: Reusable { }

// MARK: - UITableViewCell
extension UITableView {
    @discardableResult
    func registerReusableCell(withClass cellClass: Reusable.Type, fromNib: Bool = false) -> UITableView {
        if fromNib {
            let nib = UINib(nibName: cellClass.dentifier, bundle: nil)
            register(nib, forCellReuseIdentifier: cellClass.dentifier)
        } else {
            register(cellClass, forCellReuseIdentifier: cellClass.dentifier)
        }
        return self
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.dentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.dentifier)")
        }
        return cell
    }
    
    @discardableResult
    func registerReusableHeaderFooterView(withClass headerFooterViewClass: Reusable.Type, fromNib: Bool = false) -> UITableView {
        if fromNib {
            let nib = UINib(nibName: headerFooterViewClass.dentifier, bundle: nil)
            register(nib, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.dentifier)
        } else {
            register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.dentifier)
        }
        return self
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass headerFooterViewClass: T.Type = T.self) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.dentifier) as? T
    }
    
}

// MARK: - UICollectionView
extension UICollectionView {
    @discardableResult
    func registerReusableCell(withClass cellClass: Reusable.Type, fromNib: Bool = false) -> UICollectionView {
        if fromNib {
            let nib = UINib(nibName: cellClass.dentifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: cellClass.dentifier)
        } else {
            register(cellClass, forCellWithReuseIdentifier: cellClass.dentifier)
        }
        return self
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.dentifier, for: indexPath) as! T
    }
    
    @discardableResult
    func registerReusableSupplementaryView(withClass supplementaryView: Reusable.Type, forSupplementaryViewOfKind kind: String, fromNib: Bool = false) -> UICollectionView {
        if fromNib {
            let nib = UINib(nibName: supplementaryView.dentifier, bundle: nil)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: supplementaryView.dentifier)
        } else {
            register(supplementaryView, forSupplementaryViewOfKind: kind, withReuseIdentifier: supplementaryView.dentifier)
        }
        return self
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(withClass supplementaryView: T.Type, forSupplementaryViewOfKind kind: String, at indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.dentifier, for: indexPath) as! T
    }
    
}
