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
    
    lazy var detail = UILabel().then {
        $0.text = "setContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPrioritysetContentHuggingPriority"
        $0.numberOfLines = 5
        $0.setContentHuggingPriority(.required, for: .vertical)
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
        
        detail.snp.makeConstraints { (make) in
            make.left.equalTo(_THEME.size.panel_padding)
            make.right.equalTo(-_THEME.size.panel_padding)
            make.top.equalTo(title.snp.bottom).offset(_THEME.size.inset_padding)
            make.bottom.equalTo(-_THEME.size.panel_padding)
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

