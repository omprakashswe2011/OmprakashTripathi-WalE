//
//  NasaImageOfTheDayModel.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation
import UIKit

struct NasaImageOfTheDayModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case explanation = "explanation"
        case hdurl = "hdurl"
        case media_type = "media_type"
        case service_version = "service_version"
        case title = "title"
        case url = "url"
    }

    public let date: String
    public let explanation: String
    public var hdurl: String
    public var media_type: String
    public let service_version: String
    public let title: String
    public let url: String
}
