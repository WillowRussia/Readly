//
//  PreviewView.swift
//  Readly
//
//  Created by Илья Востров on 28.02.2025.
//


import UIKit
import Lottie

final class PreviewView: UIViewController {
    
    var router: LaunchRouter?
    
    private lazy var lottieView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "BookAnimation")
        animationView.frame.size = CGSize(width: view.frame.width - 80, height: view.frame.width - 80)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        view.addSubview(lottieView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lottieView.play(toFrame: 90) { [weak self] completed in
            if completed {
                self?.router?.navigateToNextScreen()
            }
        }
    }
}
