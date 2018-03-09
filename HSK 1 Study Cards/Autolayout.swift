//
//  Autolayout.swift
//  Breezi.io
//
//  Created by James Wright on 10/25/16.
//  Copyright © 2016 James Wright. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(autolayoutSuperview: UIView) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        autolayoutSuperview.addSubview(self)
    }
    
    func autolayout(toSuperview autolayoutSuperview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        autolayoutSuperview.addSubview(self)
    }
    
    @discardableResult
    func constrainToWidth(width: CGFloat) -> [NSLayoutConstraint] {
        let c = widthAnchor.constraint(equalToConstant: width)
        c.isActive = true
        c.identifier = "Width = \(width)"
        return [c]
    }
    
    @discardableResult
    func constrainToHeight(height: CGFloat) -> [NSLayoutConstraint] {
        let c = heightAnchor.constraint(equalToConstant: height)
        c.isActive = true
        c.identifier = "Height = \(height)"
        return [c]
    }
    
    @discardableResult
    func constrainToSize(width: CGFloat, height: CGFloat) -> [NSLayoutConstraint] {
        return constrainToWidth(width: width) + constrainToHeight(height: height)
    }
    
    @discardableResult
    func centerInSuperview(withOffset offset: CGPoint = CGPoint.zero) -> [NSLayoutConstraint] {
        guard let s = superview else { return [] }
        let x = centerXAnchor.constraint(equalTo: s.centerXAnchor, constant: offset.x)
        let y = centerYAnchor.constraint(equalTo: s.centerYAnchor, constant: offset.y)
        x.isActive = true
        y.isActive = true
        var xIdentifier = "X Center in Superivew"
        var yIdentifier = "Y Center in Superview"
        if offset.x > 0 {
            xIdentifier.append(" offset: \(offset.x)")
        }
        if offset.y > 0 {
            yIdentifier.append(" offset: \(offset.y)")
        }
        x.identifier = xIdentifier
        y.identifier = yIdentifier
        return [x, y]
    }
    
    @discardableResult
    func fillSuperview() -> [NSLayoutConstraint] {
        guard let s = superview else { return [] }
        let centerConstraints = centerInSuperview()
        let w = widthAnchor.constraint(equalTo: s.widthAnchor, multiplier: 1)
        let h = heightAnchor.constraint(equalTo: s.heightAnchor, multiplier: 1)
        w.isActive = true
        h.isActive = true
        w.identifier = "self.width = self.superview.width"
        h.identifier = "self.height = self.superview.height"
        return [w, h] + centerConstraints
    }
    
    @discardableResult
    func pin(attribute: NSLayoutAttribute, toAttribute: NSLayoutAttribute, ofView: UIView, withConstant: CGFloat) -> [NSLayoutConstraint] {
        let c = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: ofView, attribute: toAttribute, multiplier: 1, constant: withConstant)
        c.isActive = true
        c.identifier = "self.\(attribute) = \(ofView).\(toAttribute) + \(withConstant)"
        return [c]
    }
    
    @discardableResult
    func pinAllToSuperview(_ attributes: [NSLayoutAttribute]) -> [NSLayoutConstraint] {
        return attributes.map {
            let c = NSLayoutConstraint(item: self, attribute: $0, relatedBy: .equal, toItem: superview, attribute: $0, multiplier: 1, constant: 0)
            c.identifier = "\($0) equal to superview"
            c.isActive = true
            return c
        }
    }
    
}
