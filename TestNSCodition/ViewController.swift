//
//  ViewController.swift
//  TestNSCodition
//
//  Created by yuhua Tang on 2022/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    var p:Producer!
    var c:Cosumer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        start()
    }

    func start() {
        var pipeline = NSMutableArray()
        let condition = NSCondition()
        p = Producer(with: condition, collector: pipeline)
        c = Cosumer(with: condition, collector: pipeline)
       
        Thread.init(target: self, selector: #selector(startProducer), object: p).start()
        
        Thread.init(target: self, selector: #selector(startCosumer), object: c).start()
        condition.broadcast()
    }
    
    @objc func startProducer() {
        p.produce()
    }
    
    @objc func startCosumer() {
        c.cosume()
    }


}

