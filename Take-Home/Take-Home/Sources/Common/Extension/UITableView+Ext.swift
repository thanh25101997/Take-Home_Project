//
//  UITableView+Ext.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import UIKit
import RxSwift
import RxCocoa

extension UITableView {
    
    func registerCell(for id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }
    
}

extension Reactive where Base: UITableView {
    
    public func safeModelSelected<T>(_ modelType: T.Type) -> ControlEvent<T> {
        let source: Observable<T> = self.itemSelected.throttle(RxTimeInterval.seconds(1), latest: false, scheduler: MainScheduler.instance).flatMap { [weak view = self.base as UITableView] indexPath -> Observable<T> in
            guard let view = view else {
                return Observable.empty()
            }
            
            return Observable.just(try view.rx.model(at: indexPath))
        }
        
        return ControlEvent(events: source)
    }
}

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
