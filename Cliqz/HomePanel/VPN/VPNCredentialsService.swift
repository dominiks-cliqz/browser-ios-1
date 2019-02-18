//
//  VPNCredentialsService.swift
//  Client
//
//  Created by Sahakyan on 1/23/19.
//  Copyright © 2019 Cliqz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct VPNData {
	let country: String
	let username: String
	let password: String
	let remoteID: String
	let serverIP: String
	let port: Int
}

class VPNCredentialsService {
	
	private static let APIKey = "LumenAPIKey"

	class func getVPNCredentials(completion: @escaping ([VPNData]) -> Void) {
		guard let apiKey = Bundle.main.object(forInfoDictionaryKey: APIKey) as? String, !apiKey.isEmpty,
				let subscriptionUserId = SubscriptionController.shared.getSubscriptionUserId() else {
			print("API Key is not available in Info.plist")
			return
		}
		if let udid = UIDevice.current.identifierForVendor {
			let params: Parameters = ["device_id": udid.uuidString,
					  	"revenue_cat_token": subscriptionUserId]
			let header = ["x-api-key": apiKey]
			var result = [VPNData]()
			Alamofire.request("https://ic4t94ok9b.execute-api.us-east-1.amazonaws.com/staging/get_credentials", method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
				if response.result.isSuccess {
					let json = JSON(response.result.value ?? "")
					if let fullResponse = json.dictionary,
						let body = fullResponse["body"]?.dictionary,
						let nodes = body["nodes"]?.array,
						let credentials = body["credentials"]?.dictionary,
						let username = credentials["username"]?.string,
						let password = credentials["password"]?.string {
						for node in nodes {
							if let data = node.dictionary,
								let ip = data["ipAddress"]?.string,
								let country = data["countryCode"]?.string,
								let name = data["name"]?.string {
								result.append(VPNData(country: country, username: username, password: password, remoteID: name, serverIP: ip, port: 0))
							}
						}
					}
				} else {
					print(response.error ?? "No Error from response") // TODO proper Error
				}
				completion(result)
			}
		} else {
			completion([VPNData]())
		}
	}
}
