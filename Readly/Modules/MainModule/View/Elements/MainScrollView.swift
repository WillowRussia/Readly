//
//  MainScrollView.swift
//  Readly
//
//  Created by Илья Востров on 24.05.2025.
//

import SwiftUI

// Протокол для делегирования событий ScrollView
protocol ScrollViewDelegate: AnyObject {
    /// Вызывается при скролле
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    
    /// Проверяет, разрешена ли прокрутка
    func shouldAllowScrolling() -> Bool
    
    /// Возвращает максимальное значение contentOffset.y
    func maxContentOffsetY() -> CGFloat
}

class ScrollManager: ObservableObject, ScrollViewDelegate {
    @Published var isScrollingEnabled = true
    @Published var maxOffsetY: CGFloat = 500
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Текущая позиция: \(scrollView.contentOffset.y)")
    }
    
    func shouldAllowScrolling() -> Bool {
        return isScrollingEnabled
    }
    
    func maxContentOffsetY() -> CGFloat {
        return maxOffsetY
    }
}

struct MainScrollView<Content: View>: UIViewRepresentable {
    weak var delegate: ScrollViewDelegate?
    let content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .mainBackground
        
        let hostingController = UIHostingController(rootView: content())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        context.coordinator.hostingController = hostingController
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if let hostingController = context.coordinator.hostingController {
            hostingController.rootView = content()
        } else {
            let hostingController = UIHostingController(rootView: content())
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            
            uiView.addSubview(hostingController.view)
            
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: uiView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
                hostingController.view.widthAnchor.constraint(equalTo: uiView.widthAnchor)
            ])
            
            context.coordinator.hostingController = hostingController
        }
        
        uiView.setNeedsLayout()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: MainScrollView
        private var previousContentOffset: CGPoint = .zero
        var hostingController: UIHostingController<Content>?
        
        init(_ parent: MainScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // Запрет оттягивания вверх
            if scrollView.contentOffset.y < 0 {
                scrollView.contentOffset.y = 0
            }
            
            // Ограничение по максимальному значению contentOffset.y
            if let maxY = parent.delegate?.maxContentOffsetY(), scrollView.contentOffset.y > maxY {
                scrollView.contentOffset.y = maxY
            }
            
            // Блокировка прокрутки
            if parent.delegate?.shouldAllowScrolling() == false {
                scrollView.setContentOffset(previousContentOffset, animated: false)
                return
            }
            
            previousContentOffset = scrollView.contentOffset
            
            parent.delegate?.scrollViewDidScroll(scrollView)
        }
    }
}
