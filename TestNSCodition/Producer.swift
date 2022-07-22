//
//  Producer.swift
//  TestNSCodition
//
//  Created by yuhua Tang on 2022/7/22.
//

import Foundation

class Producer {
    var collector:NSMutableArray!
    var condition:NSCondition!
    var shouldProduce = false
    init(with condition:NSCondition, collector:NSMutableArray) {
        self.condition = condition
        self.collector = collector
    }
    
    func produce() {
        shouldProduce = true
        while self.shouldProduce {
            self.condition.lock()
            
            if self.collector.count > 0 {
                // 这会阻塞当前线程，值得condition 被执行 signal
                self.condition.wait()
            }
           
            let randomInt = Int.random(in: 0..<100)
            self.collector.add(randomInt)
            print("produce :\(randomInt)")
            // 通知其他等待的线程 ，有东西吃了
            self.condition.signal()
            self.condition.unlock()
        }
    }
}
