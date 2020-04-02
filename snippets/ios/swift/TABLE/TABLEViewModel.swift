//
//  TABLEViewModel.swift
//  TEMPLATE
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright © TODAYS_YEAR OWNER_TEAM. All rights reserved.
//

import UIKit
import RxDataSources

class TABLEViewModel: ViewModel {
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { (_, tableView, indexPath, element) in
            let cell:TABLEPageCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
    )
}
