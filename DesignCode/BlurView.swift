//
//  BlurView.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/29.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct BlurView:UIViewRepresentable {

    
    typealias UIViewType = UIView  //只是需要简单的视图
    let style:UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)  //初始位置
        view.backgroundColor = .clear  //确保背景无色
        
//        let blurEffect=UIBlurEffect(style: .systemMaterial)
        let blurEffect=UIBlurEffect(style: style)   //定义模糊效果
        let blurView=UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints=false   //自适应
            view.insertSubview(blurView, at: 0) //0表示没有叠层
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
    }             //暂时不需要
    
    
    
    
    
    
}
