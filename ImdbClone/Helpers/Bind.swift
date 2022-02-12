//
//  Bind.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 12/02/22.
//

import Foundation

class Bind<T> {
    typealias Listener = (T) -> ()
    
    // MARK:- variables for the binder
    var value: T {
        didSet {
            listener?(value)
        }
    }

    var listener: Listener?
    
    // MARK:- initializers for the binder
    init(_ value: T) {
        self.value = value
    }
    
    // MARK:- functions for the binder
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
