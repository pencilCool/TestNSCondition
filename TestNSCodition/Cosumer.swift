//
//  Cosumer.swift
//  TestNSCodition
//
//  Created by yuhua Tang on 2022/7/22.
//

import Foundation

class Cosumer {
   
    var condition:NSCondition!
    var collector:NSMutableArray
    var shouldConsume = false
    
    init(with condition:NSCondition,collector:NSMutableArray) {
        self.condition = condition
        self.collector = collector
    }
    
    func cosume() {
        shouldConsume = true
        while shouldConsume {
            condition.lock()
            if self.collector.count == 0{
                self.condition.wait()
            }
            
            let number = self.collector[0]
            print("cosume :\(number)")
            self.collector.removeObject(at: 0)
            self.condition.signal()
            self.condition.unlock()
        }
                
    }
}
