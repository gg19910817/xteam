//
//  NAMEPageWidgets.swift
//  TEMPLATE
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright © TODAYS_YEAR OWNER_TEAM. All rights reserved.
//

import UIKit

class NAMETop: View {
    
    /*
     1. lazy属性，会在调用属性时才初始化（这个操作线程不安全）。
     2. lazy中可以保证self被初始化，而非lazy属性中self未被初始化。
     3. 此处一般是私有属性，例如私有UI组件，只将属性暴露，不暴露组件。
     */
    private lazy var title = Label().then {
        $0.text = _THEME.text.locale("登陆后即可展示自己")
        _THEME.style(view: $0, size: _THEME.size.m, bold: true)
        addSubview($0)
    }
    private lazy var detail = Label().then {
        $0.text = _THEME.text.locale("登陆即表明同意用户协议和隐私政策")
        _THEME.style(view: $0, color: _THEME.color.visited, size: _THEME.size.xs)
        addSubview($0)
    }
    
    /*
    Tips:
    1. 这个方法在View创建以后调用
    2. 此时没有加入到父View中，也不会调用layoutSubviews
    3. 可以在此方法中，对子View进行一次性的布局和设置。
    */
    override func _initComplete() {
        super._initComplete()
        title.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
        }
        detail.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(_THEME.size.inset_padding)
            make.left.bottom.equalTo(0)
        }
    }

}

class NAMEMiddle: View {
    
    private lazy var phone = AntInput().then {
        addSubview($0)
    }
    private lazy var tips = Label().then {
        $0.text = _THEME.text.locale("未注册的手机号验证通过后将自动注册")
        _THEME.style(view: $0, color: _THEME.color.visited, size: _THEME.size.xs)
        addSubview($0)
    }
    private lazy var action = AntButton().then {
        addSubview($0)
    }

    override func _initComplete() {
        super._initComplete()
        phone.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
        }
        tips.snp.makeConstraints { (make) in
            make.top.equalTo(phone.snp.bottom).offset(_THEME.size.inset_padding)
            make.left.right.equalTo(0)
        }
        action.snp.makeConstraints { (make) in
            make.top.equalTo(tips.snp.bottom).offset(_THEME.size.panel_padding)
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(_THEME.size.tool_height)
        }
    }

}

class NAMEBottom: View {

    private lazy var more = AntButton().then{
        addSubview($0)
    }
    private lazy var apple = AntButton().then{
        addSubview($0)
    }
    private lazy var any = AntButton().then{
        addSubview($0)
    }
    private lazy var password = AntButton().then{
        addSubview($0)
    }
    
    override func _layoutSubviews() {
        super._layoutSubviews()
        more.pin.right().vCenter().sizeToFit()
        apple.pin.before(of: more).marginRight(_THEME.size.inset_padding).vCenter().sizeToFit()
        any.pin.before(of: apple).marginRight(_THEME.size.inset_padding).vCenter().sizeToFit()
        password.pin.before(of: any).left().marginRight(_THEME.size.inset_padding).vCenter().sizeToFit()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return .init(width: size.width, height: _THEME.size.tool_height)
    }
    
}
