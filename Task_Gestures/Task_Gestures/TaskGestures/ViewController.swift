//
//  ViewController.swift
//  Task_Gestures
//
//  Created by Z on 11/3/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet var contanView: UIView!
    
    private var greenViewCurrentTransform: CGAffineTransform!
    private var gestLocationBegan: CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configPanGesture(target: self, targetView: animView)
        configLongPressGesture(target: self, targetView: animView)
        configTapGesture(target: self, targetView: contanView)
    }
    
    func setCornerRadius(view: UIView, corneDadius: CGFloat) {
        view.layer.cornerRadius = corneDadius
        //view.layer.masksToBounds = true
    }
    func incCornerRadius(view: UIView) {
        if ( view.layer.cornerRadius < (view.frame.size.height - 10)) {
            view.layer.cornerRadius = view.layer.cornerRadius + 10
        }
        else {
            view.layer.cornerRadius = view.frame.size.height
        }
    }
    func decCornerRadius(view: UIView) {
        if (view.layer.cornerRadius > 10) {
            view.layer.cornerRadius = view.layer.cornerRadius - 10
        }
        else {
            view.layer.cornerRadius = 0
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
    func setupPanGesture(target: ViewController, targetView: UIView, gestureRecognizer: UIGestureRecognizer) {
        gestureRecognizer.delegate = target
        targetView.addGestureRecognizer(gestureRecognizer)
    }
    
    func configPanGesture(target: ViewController, targetView: UIView) {
        let gesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: target, action: #selector(panGestureSelector(_:)))
        setupPanGesture(target: target, targetView: targetView, gestureRecognizer: gesture)
    }
    
    func configLongPressGesture(target: ViewController, targetView: UIView) {
        let gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: target, action: #selector(longPressGestureSelector(_:)))
        setupPanGesture(target: target, targetView: targetView, gestureRecognizer: gesture)
    }
    
    func configTapGesture(target: ViewController, targetView: UIView) {
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: #selector(tapGestureSelector(_:)))
        setupPanGesture(target: target, targetView: targetView, gestureRecognizer: gesture)
    }
    
    @objc func longPressGestureSelector(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .possible:
            break
        case .began:
            gestLocationBegan = gesture.location(in: view)
            fallthrough
        case .cancelled:
            fallthrough
        case .changed:
            let gestLocation = gesture.location(in: view)
            if (gestLocationBegan.y < gestLocation.y) {
                self.incCornerRadius(view: self.animView)
            }
            else {
                self.decCornerRadius(view: self.animView)
            }
            break
        case .ended:
            break
        case .failed:
            break
        @unknown default:
            break
        }
        textLabel.text = "longPress: cR=" + "\(self.animView.layer.cornerRadius)"
    }
    
    @objc func panGestureSelector(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .possible:
            break
        case .began:
            greenViewCurrentTransform = animView.transform
            fallthrough
        case .changed:
            let gestTrans = gesture.translation(in: view)
            animView.transform = greenViewCurrentTransform.translatedBy(x: gestTrans.x, y: gestTrans.y)
            break
        case .ended:
            greenViewCurrentTransform = animView.transform
             break
        case .cancelled:
            break
        case .failed:
            break
        @unknown default:
            break
        }
        textLabel.text = "pan: x=" + "\(self.animView.frame.origin.x)" + " y=" + "\(self.animView.frame.origin.y)"
    }
    
    @objc func tapGestureSelector(_ gesture: UIPanGestureRecognizer) {
        let gestTrans = gesture.location(in: view)
        UIView.animate(withDuration: 0.3) {
            self.animView.frame = CGRect(origin: gestTrans, size: self.animView.frame.size)
        }
        textLabel.text = "tap: x=" + "\(self.animView.frame.origin.x)" + " y=" + "\(self.animView.frame.origin.y)"
    }
}

