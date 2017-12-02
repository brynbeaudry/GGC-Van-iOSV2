//
// ManageAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class ManageAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageChangePasswordGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageChangePasswordGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/ChangePassword

     - returns: RequestBuilder<Void> 
     */
    open class func manageChangePasswordGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/ChangePassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter oldPassword: (query)  (optional)
     - parameter newPassword: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter statusMessage: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageChangePasswordPost(oldPassword: String? = nil, newPassword: String? = nil, confirmPassword: String? = nil, statusMessage: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        manageChangePasswordPostWithRequestBuilder(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword, statusMessage: statusMessage).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/ChangePassword
     
     - parameter oldPassword: (query)  (optional)
     - parameter newPassword: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter statusMessage: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func manageChangePasswordPostWithRequestBuilder(oldPassword: String? = nil, newPassword: String? = nil, confirmPassword: String? = nil, statusMessage: String? = nil) -> RequestBuilder<Void> {
        let path = "/Manage/ChangePassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "OldPassword": oldPassword, 
            "NewPassword": newPassword, 
            "ConfirmPassword": confirmPassword, 
            "StatusMessage": statusMessage
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageDisable2faPost(completion: @escaping ((_ error: Error?) -> Void)) {
        manageDisable2faPostWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/Disable2fa

     - returns: RequestBuilder<Void> 
     */
    open class func manageDisable2faPostWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/Disable2fa"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageDisable2faWarningGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageDisable2faWarningGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/Disable2faWarning

     - returns: RequestBuilder<Void> 
     */
    open class func manageDisable2faWarningGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/Disable2faWarning"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageEnableAuthenticatorGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageEnableAuthenticatorGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/EnableAuthenticator

     - returns: RequestBuilder<Void> 
     */
    open class func manageEnableAuthenticatorGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/EnableAuthenticator"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter code: (query)  (optional)
     - parameter sharedKey: (query)  (optional)
     - parameter authenticatorUri: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageEnableAuthenticatorPost(code: String? = nil, sharedKey: String? = nil, authenticatorUri: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        manageEnableAuthenticatorPostWithRequestBuilder(code: code, sharedKey: sharedKey, authenticatorUri: authenticatorUri).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/EnableAuthenticator
     
     - parameter code: (query)  (optional)
     - parameter sharedKey: (query)  (optional)
     - parameter authenticatorUri: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func manageEnableAuthenticatorPostWithRequestBuilder(code: String? = nil, sharedKey: String? = nil, authenticatorUri: String? = nil) -> RequestBuilder<Void> {
        let path = "/Manage/EnableAuthenticator"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Code": code, 
            "SharedKey": sharedKey, 
            "AuthenticatorUri": authenticatorUri
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageExternalLoginsGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageExternalLoginsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/ExternalLogins

     - returns: RequestBuilder<Void> 
     */
    open class func manageExternalLoginsGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/ExternalLogins"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageGenerateRecoveryCodesGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageGenerateRecoveryCodesGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/GenerateRecoveryCodes

     - returns: RequestBuilder<Void> 
     */
    open class func manageGenerateRecoveryCodesGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/GenerateRecoveryCodes"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageIndexGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageIndexGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/Index

     - returns: RequestBuilder<Void> 
     */
    open class func manageIndexGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/Index"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter username: (query)  (optional)
     - parameter isEmailConfirmed: (query)  (optional)
     - parameter email: (query)  (optional)
     - parameter phoneNumber: (query)  (optional)
     - parameter statusMessage: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageIndexPost(username: String? = nil, isEmailConfirmed: Bool? = nil, email: String? = nil, phoneNumber: String? = nil, statusMessage: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        manageIndexPostWithRequestBuilder(username: username, isEmailConfirmed: isEmailConfirmed, email: email, phoneNumber: phoneNumber, statusMessage: statusMessage).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/Index
     
     - parameter username: (query)  (optional)
     - parameter isEmailConfirmed: (query)  (optional)
     - parameter email: (query)  (optional)
     - parameter phoneNumber: (query)  (optional)
     - parameter statusMessage: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func manageIndexPostWithRequestBuilder(username: String? = nil, isEmailConfirmed: Bool? = nil, email: String? = nil, phoneNumber: String? = nil, statusMessage: String? = nil) -> RequestBuilder<Void> {
        let path = "/Manage/Index"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Username": username, 
            "IsEmailConfirmed": isEmailConfirmed, 
            "Email": email, 
            "PhoneNumber": phoneNumber, 
            "StatusMessage": statusMessage
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageLinkLoginCallbackGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageLinkLoginCallbackGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/LinkLoginCallback

     - returns: RequestBuilder<Void> 
     */
    open class func manageLinkLoginCallbackGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/LinkLoginCallback"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter provider: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageLinkLoginPost(provider: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        manageLinkLoginPostWithRequestBuilder(provider: provider).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/LinkLogin
     
     - parameter provider: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func manageLinkLoginPostWithRequestBuilder(provider: String? = nil) -> RequestBuilder<Void> {
        let path = "/Manage/LinkLogin"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "provider": provider
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter loginProvider: (query)  (optional)
     - parameter providerKey: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageRemoveLoginPost(loginProvider: String? = nil, providerKey: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        manageRemoveLoginPostWithRequestBuilder(loginProvider: loginProvider, providerKey: providerKey).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/RemoveLogin
     
     - parameter loginProvider: (query)  (optional)
     - parameter providerKey: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func manageRemoveLoginPostWithRequestBuilder(loginProvider: String? = nil, providerKey: String? = nil) -> RequestBuilder<Void> {
        let path = "/Manage/RemoveLogin"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "LoginProvider": loginProvider, 
            "ProviderKey": providerKey
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageResetAuthenticatorPost(completion: @escaping ((_ error: Error?) -> Void)) {
        manageResetAuthenticatorPostWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/ResetAuthenticator

     - returns: RequestBuilder<Void> 
     */
    open class func manageResetAuthenticatorPostWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/ResetAuthenticator"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageResetAuthenticatorWarningGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageResetAuthenticatorWarningGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/ResetAuthenticatorWarning

     - returns: RequestBuilder<Void> 
     */
    open class func manageResetAuthenticatorWarningGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/ResetAuthenticatorWarning"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter username: (query)  (optional)
     - parameter isEmailConfirmed: (query)  (optional)
     - parameter email: (query)  (optional)
     - parameter phoneNumber: (query)  (optional)
     - parameter statusMessage: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageSendVerificationEmailPost(username: String? = nil, isEmailConfirmed: Bool? = nil, email: String? = nil, phoneNumber: String? = nil, statusMessage: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        manageSendVerificationEmailPostWithRequestBuilder(username: username, isEmailConfirmed: isEmailConfirmed, email: email, phoneNumber: phoneNumber, statusMessage: statusMessage).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/SendVerificationEmail
     
     - parameter username: (query)  (optional)
     - parameter isEmailConfirmed: (query)  (optional)
     - parameter email: (query)  (optional)
     - parameter phoneNumber: (query)  (optional)
     - parameter statusMessage: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func manageSendVerificationEmailPostWithRequestBuilder(username: String? = nil, isEmailConfirmed: Bool? = nil, email: String? = nil, phoneNumber: String? = nil, statusMessage: String? = nil) -> RequestBuilder<Void> {
        let path = "/Manage/SendVerificationEmail"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Username": username, 
            "IsEmailConfirmed": isEmailConfirmed, 
            "Email": email, 
            "PhoneNumber": phoneNumber, 
            "StatusMessage": statusMessage
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageSetPasswordGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageSetPasswordGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/SetPassword

     - returns: RequestBuilder<Void> 
     */
    open class func manageSetPasswordGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/SetPassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter newPassword: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter statusMessage: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageSetPasswordPost(newPassword: String? = nil, confirmPassword: String? = nil, statusMessage: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        manageSetPasswordPostWithRequestBuilder(newPassword: newPassword, confirmPassword: confirmPassword, statusMessage: statusMessage).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Manage/SetPassword
     
     - parameter newPassword: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter statusMessage: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func manageSetPasswordPostWithRequestBuilder(newPassword: String? = nil, confirmPassword: String? = nil, statusMessage: String? = nil) -> RequestBuilder<Void> {
        let path = "/Manage/SetPassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "NewPassword": newPassword, 
            "ConfirmPassword": confirmPassword, 
            "StatusMessage": statusMessage
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func manageTwoFactorAuthenticationGet(completion: @escaping ((_ error: Error?) -> Void)) {
        manageTwoFactorAuthenticationGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Manage/TwoFactorAuthentication

     - returns: RequestBuilder<Void> 
     */
    open class func manageTwoFactorAuthenticationGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Manage/TwoFactorAuthentication"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
