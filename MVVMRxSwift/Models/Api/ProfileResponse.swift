//
//  ProfileResponse.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import Foundation

public struct ProfileResponse: Codable {
    let id: String?
    let name: String?
    let tagline: String?
    let details: String?
    let officialLinks: [OfficialLinks]?

    enum DataCodingKeys: String, CodingKey {
        case data
    }
    
    enum ValuesDataCodingKeys: String, CodingKey {
        case profile
        case name
        case id
    }
    
    enum GeneralCodingKeys: String, CodingKey {
        case general
    }
    
    enum OverviewCodingKeys: String, CodingKey {
        case overview
    }
    
    enum ProjectDetailsCodingKeys: String, CodingKey {
        case tagline
        case projectDetails = "project_details"
        case officialLinks = "official_links"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DataCodingKeys.self)

        let data = try values.nestedContainer(keyedBy: ValuesDataCodingKeys.self, forKey: .data)
        
        id = try data.decodeIfPresent(String.self, forKey: .id)
        name = try data.decodeIfPresent(String.self, forKey: .name)

        let profile = try data.nestedContainer(keyedBy: GeneralCodingKeys.self, forKey: .profile)
        let general = try profile.nestedContainer(keyedBy: OverviewCodingKeys.self, forKey: .general)
        let overview = try general.nestedContainer(keyedBy: ProjectDetailsCodingKeys.self, forKey: .overview)
        tagline = try overview.decodeIfPresent(String.self, forKey: .tagline)
        details = try overview.decodeIfPresent(String.self, forKey: .projectDetails)
        officialLinks = try overview.decodeIfPresent([OfficialLinks].self, forKey: .officialLinks)
    }
}

public struct OfficialLinks: Codable {
    let name: String
    let link: String
}
