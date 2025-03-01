//
//  PreviewView.swift
//  Readly
//
//  Created by Илья Востров on 28.02.2025.
//

import UIKit
import Lottie

class PreviewView: UIViewController {
    
    private lazy var lottieView: LottieAnimationView = {
        $0.frame.size = CGSize(width: view.frame.width - 80, height: view.frame.width - 80)
        $0.center = view.center
        $0.contentMode = .scaleAspectFill
        $0.animationSpeed = 1.3
        return $0
    }(LottieAnimationView(name: "BookAnimation"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        view.addSubview(lottieView)
        
        lottieView.play{ completed in
            if completed {
                NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo : WindowCase.regist])
            }
        }
    }
}
