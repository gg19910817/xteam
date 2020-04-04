//
//  TABLEPageCell.swift
//  TEMPLATE
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright © TODAYS_YEAR OWNER_TEAM. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import PinLayout

class TABLEPageCell: UITableViewCell, Reusable {
    
    lazy var panel = Panel().then {
        $0.setContentHuggingPriority(.required, for: .vertical)
        contentView.addSubview($0)
    }
    
    lazy var title = UILabel().then {
        $0.text = "setContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPriority"
        $0.numberOfLines = 2
        $0.setContentHuggingPriority(.required, for: .vertical)
        panel.addSubview($0)
    }
    
    lazy var profile = ProfileView().then {
        $0.setContentHuggingPriority(.required, for: .vertical)
        panel.addSubview($0)
    }
    
    lazy var detail = UILabel().then {
        $0.text = "setContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPriority"
        $0.numberOfLines = 5
        $0.setContentHuggingPriority(.required, for: .vertical)
        panel.addSubview($0)
    }
    
    lazy var social = SocialView().then {
        panel.addSubview($0)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        panel.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(-_THEME.size.panel_padding)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(_THEME.size.panel_padding)
            make.right.equalTo(-_THEME.size.panel_padding)
            make.top.equalTo(_THEME.size.panel_padding)
        }
        
        profile.snp.makeConstraints { (make) in
            make.left.equalTo(_THEME.size.panel_padding)
            make.right.equalTo(-_THEME.size.panel_padding)
            make.top.equalTo(title.snp.bottom).offset(_THEME.size.inset_padding)
        }
        
        detail.snp.makeConstraints { (make) in
            make.left.equalTo(_THEME.size.panel_padding)
            make.right.equalTo(-_THEME.size.panel_padding)
            make.top.equalTo(profile.snp.bottom).offset(_THEME.size.inset_padding)
        }
        
        social.snp.makeConstraints { (make) in
            make.left.equalTo(_THEME.size.panel_padding)
            make.right.equalTo(-_THEME.size.panel_padding)
            make.bottom.equalTo(-_THEME.size.panel_padding)
            make.top.equalTo(detail.snp.bottom).offset(_THEME.size.inset_padding)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // 去掉系统自带的选中
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        // 去掉系统自带的高亮
        if highlighted {
            panel.backgroundColor = _THEME.color.highlighted
        }else {
            panel.backgroundColor = _THEME.color.panel
        }
    }

}

class SocialView: UIView {

    lazy var agreement = UILabel().then {
        $0.text = "agreement"
        addSubview($0)
    }
    
    lazy var comment = UILabel().then {
        $0.text = "agreement"
        addSubview($0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        agreement.pin.left().vCenter().sizeToFit()
        comment.pin.after(of: agreement).marginLeft(_THEME.size.inset_padding).vCenter().sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 20)
    }

}

class ProfileView: UIView {

    lazy var avatar = UIImageView().then {
        // Tips
        // iOS11以后圆角已不再触发离屏渲染
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .red
        addSubview($0)
    }
    
    lazy var name = UILabel().then {
        $0.text = "马化腾"
        addSubview($0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatar.pin.size(.init(width: 30, height: 30)).left().vCenter()
        name.pin.after(of: avatar).marginLeft(_THEME.size.inset_padding).vCenter().sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 30)
    }

}