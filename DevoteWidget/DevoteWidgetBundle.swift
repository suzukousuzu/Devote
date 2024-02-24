//
//  DevoteWidgetBundle.swift
//  DevoteWidget
//
//  Created by 鈴木航太 on 2024/02/24.
//

import WidgetKit
import SwiftUI

@main
struct DevoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        DevoteWidget()
        DevoteWidgetLiveActivity()
    }
}
