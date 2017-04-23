//
//  FieldView.swift
//  TicTacToe
//
//  Created by Julia on 11/2/16.
//  Copyright © 2016 Make school. All rights reserved.
//

import UIKit

protocol FieldViewDelegate: class{
    func fieldViewTapped(sender: FieldView)
}

class FieldView: UILabel {
    
    weak var delegate: FieldViewDelegate?
    
    var coordinate: CGPoint = CGPoint.init(x: 0, y: 0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp(){
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: "tapRecognized")
        self.addGestureRecognizer(tap)
        
    }
    
    func tapRecognized(){
        delegate?.fieldViewTapped(sender: self)
    }
    
    
}
