//
//  CommonLocalizedStrings.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 25/1/22.
//

import Foundation

// MARK: - Post List

enum PostListStrings: String, LocalizationProtocol {
    case title = "post_list_view_controller_title"
    case delete = "post_list_view_controller_delete"
    case reload = "post_list_view_controller_reload"
}

// MARK: - Post Detail

enum PostDetailStrings: String, LocalizationProtocol {
    case message = "post_detail_view_controller_save"
    case button = "post_detail_view_controller_button"
}
