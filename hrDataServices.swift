//
//  hrDataServices.swift
//  Fundo
//
//  Purpose:
//  1. It is a Services class of HrData View
//  2. It makes a REST call to get EmployeeHR data & UpdateEmployeeHR data
//  3. It implements  protocols to pass data from hrDataServices to hrDataController

//  Created by BridgeLabz Solution LLP on 02/01/17.
//  Copyright © 2017 BridgeLabz Solution LLP. All rights reserved.
//

import UIKit
import Alamofire
class hrDataServices: NSObject {
    
    //Var of type hrDataModel
    var hrDataModelVar:hrDataModel?
    
    //Var of type controllerProtocol
    var hrDataContProtocal:controllerProtocal?
    
    init(mHrControllerProtocolObj:controllerProtocal) {
        
        hrDataContProtocal = mHrControllerProtocolObj
    }
    
    //Method making a REST call to get HR data from server
    func fetchHrDataFromDatabase()
    {
        let fetchedToken = UserDefaults.standard.value(forKey: "tokenKey")
        let header: HTTPHeaders = [
            "x-token":fetchedToken as! String
        ]
        let mUtilityObj = utility()
        let mUrlString = mUtilityObj.fetchplistData()
        
        //Making a REST call to server
        Alamofire.request("\(mUrlString)/readEmployeeHRData?engineerId=\(engineerId)",headers:header).responseJSON
            { response in
                print("value----",response.result.value)
                switch response.result
                {
                case .failure(let error):
                    print("**************error****************")
                    break
                case .success(let json):
                    print("Success: \(response.response?.url)")
                    let jsonData = json as! NSDictionary
                    if jsonData["hrData"] != nil
                    {
                        let dummy = jsonData["hrData"] as! NSDictionary
                        let startDate = dummy["blStartDate"] as! String
                        let contractInitiated = dummy["compContractInitiated"] as! String
                        let contractSigned = dummy["compContractSigned"] as! String
                        let company = dummy["company"] as! String
                        let companyJoinDate = dummy["companyJoinDate"] as! String
                        let companyLeaveDate = dummy["companyLeaveDate"] as! String
                        let contractSignDate = dummy["contractSignDate"] as! String
                        let employeeStatus = dummy["employeeStatus"] as! String
                        let enggContractInitiated = dummy["enggContractInitiated"] as!String
                        let enggContractSigned = dummy["enggContractSigned"] as! String
                        let fellowshipPeriod = dummy["fellowshipPeriod"] as! String
                        let hiringCity = dummy["hiringCity"] as! String
                        let initiateTransfer = dummy["initiateTransfer"] as! String
                        
                        //Initialised hrDataModel
                        let hrModelObj = hrDataModel(startDate:startDate,contractInitiated:contractInitiated,contractSigned:contractSigned,company:company,companyJoinDate:companyJoinDate,companyLeaveDate:companyLeaveDate,contractSignDate:contractSignDate,employeeStatus:employeeStatus,enggContractInitiated:enggContractInitiated,enggContractSigned:enggContractSigned,fellowshipPeriod:fellowshipPeriod,hiringCity:hiringCity,initiateTransfer:initiateTransfer)
                        self.hrDataModelVar = hrModelObj
                        
                        //Callback function sending data from hrDataservices class to hrDatacontroller class
                        self.hrDataContProtocal?.sendDataToViewModel(values:self.hrDataModelVar!)
                    }
                    break
                }
        }
    }
    
    //Method makes a REST call to update EmployeeHR data in server
    func updateHrData(hrData:hrDataModel)
    {
        let mUtilityObj = utility()
        let mUrl = mUtilityObj.fetchplistData()
        let fetchedToken = UserDefaults.standard.value(forKey: "tokenKey")
        let header: HTTPHeaders = [
            "x-token":fetchedToken as! String
        ]
        let mUrl2 = URL(string: "\(mUrl)/updateEmployeeHrData")
        let params = ["engineerId":(engineerId),"blStartDate": (hrData.startDateModel), "compContractInitiated" : (hrData.contractInitiatedModel),"compContractSigned":(hrData.contractSignedModel),"company":hrData.companyModel,"companyJoinDate":(hrData.companyJoinDateModel),"companyLeaveDate":(hrData.companyLeaveDateModel),"contractSignDate":(hrData.contractSignDateModel),"employeeStatus":hrData.employeeStatusModel,"enggContractInitiated":(hrData.enggContractInitiatedModel),"enggContractSigned":(hrData.enggContractSignedModel),"fellowshipPeriod":(hrData.fellowshipPeriodModel),"hiringCity":(hrData.hiringCityModel),"initiateTransfer":hrData.initiateTransferModel]
        
        //Making REST call
        Alamofire.request(mUrl2!, method: .put, parameters: params, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)   // result of response serialization
        }
    }
    
}


