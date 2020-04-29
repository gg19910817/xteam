//
//  TABLEPage.swift
//  TEMPLATE
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright © TODAYS_YEAR OWNER_TEAM. All rights reserved.
//

import UIKit

class NAMEPage: Page {

    /*
     1. lazy属性，会在调用属性时才初始化（这个操作线程不安全）。
     2. lazy中可以保证self被初始化，而非lazy属性中self未被初始化。
     3. 此处一般是私有属性，例如私有UI组件，只将属性暴露，不暴露组件。
     */
    private lazy var content = UIScrollView().then {
        view.addSubview($0)
    }
    private lazy var top = NAMETop().then {
        content.addSubview($0)
    }
    private lazy var middle = NAMEMiddle().then {
        content.addSubview($0)
    }
    private lazy var bottom = NAMEBottom().then {
        content.addSubview($0)
    }
    
    /*
    Tips:
    1. 这个方法在View创建以后调用
    2. 此时没有加入到父View中，也不会调用layoutSubviews
    3. 可以在此方法中，对子View进行一次性的布局和设置。
    */
    override func _initComplete() {
        super._initComplete()
        content.snp.makeConstraints { (make) in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        top.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(_THEME.size.input_padding)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(_THEME.size.input_padding)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-_THEME.size.input_padding)
        }
        middle.snp.makeConstraints { (make) in
            make.top.equalTo(top.snp.bottom).offset(_THEME.size.input_padding)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(_THEME.size.input_padding)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-_THEME.size.input_padding)
        }
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(top.snp.bottom).offset(_THEME.size.input_padding)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(_THEME.size.input_padding)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-_THEME.size.input_padding)
            make.bottom.equalTo(_THEME.size.input_padding)
        }
    }
    
}
