//
//  DynamicValue.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 17/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)

final class Ref<T> {
    var value: T?
    init(value: T?) {
        self.value = value
    }
}

class DynamicValue<T> {
    
    private var ref: Ref<T>
       
    var value: T? {
        get { return ref.value }
        set {
            guard isKnownUniquelyReferenced(&ref) else {
                ref = Ref(value: newValue)
                self.notifyAll()
                return
            }
            ref.value = newValue
            self.notifyAll()
        }
    }
    
    private var observers = [String: CompletionHandler]()
    
    init(_ value: T) {
        ref = Ref(value: value)
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify(observer: observer)
    }
    
    public func remove(observer: NSObject) {
        observers.removeValue(forKey: observer.description)
    }
    
    private func notifyAll() {
        observers.forEach({ $0.value() })
    }
    
    private func notify(observer: NSObject) {
        observers.forEach { if $0.key == observer.description {
            $0.value()
        }}
    }
    
    deinit {
        observers.removeAll()
    }
}
