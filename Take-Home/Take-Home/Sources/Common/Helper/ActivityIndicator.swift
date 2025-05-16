//
//  ActivityIndicator.swift
//  Take-Home
//
//  Created by Van Thanh on 16/5/25.
//

import RxSwift
import RxCocoa
import Foundation

extension Observable {
    func subcribe(onNext: ((Element) -> Void)?) -> Disposable {
        return self.subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}

private struct ActivityToken<E>: ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable
    private let _subject = PublishSubject<Error>()
    private let _bag = DisposeBag()
    
    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _subject.subcribe(onNext: { error in
            disposeAction()
        }).disposed(by: _bag)
        _dispose = Disposables.create(with: disposeAction)
    }
    
    func dispose() {
        _dispose.dispose()
    }
    
    private func onError(_ error: Error) {
        _subject.onNext(error)
    }
    
    func asObservable() -> Observable<E> {
        return _source.do(onError: onError)
    }
}

public class ActivityIndicator: SharedSequenceConvertibleType {
    
    public typealias Element = Bool
    
    public typealias SharingStrategy = DriverSharingStrategy
    
    private let _lock = NSRecursiveLock()
    private let _variable = BehaviorRelay(value: 0)
    private let _loading: SharedSequence<SharingStrategy, Bool>
    private let isHidden = BehaviorRelay(value: false)
    
    public init() {
        _loading = _variable.withLatestFrom(isHidden) { (variable, isHidden) in
            return (variable > 0) && !isHidden
        }.asDriver(onErrorJustReturn: false).distinctUntilChanged()
//        _loading = _variable.asDriver()
//            .map { $0 > 0 }
//            .distinctUntilChanged()
    }
    
    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }) { t in
            return t.asObservable()
        }
    }
    
    public func setIsHidden(_ hidden: Bool) {
        isHidden.accept(hidden)
    }
    
    private func increment() {
        _lock.lock()
        _variable.accept(_variable.value + 1)
        _lock.unlock()
    }
    
    private func decrement() {
        _lock.lock()
        let _variableTemp = _variable.value - 1
        _variable.accept(_variableTemp <= 0 ? 0 : _variableTemp )
        _lock.unlock()
    }
    
   public func asSharedSequence() -> SharedSequence<DriverSharingStrategy, Element> {
         return _loading
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}
