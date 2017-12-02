//
// AccountAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class AccountAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountAccessDeniedGet(completion: @escaping ((_ error: Error?) -> Void)) {
        accountAccessDeniedGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/AccessDenied

     - returns: RequestBuilder<Void> 
     */
    open class func accountAccessDeniedGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Account/AccessDenied"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter userId: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountConfirmEmailGet(userId: String? = nil, code: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountConfirmEmailGetWithRequestBuilder(userId: userId, code: code).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/ConfirmEmail
     
     - parameter userId: (query)  (optional)
     - parameter code: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountConfirmEmailGetWithRequestBuilder(userId: String? = nil, code: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/ConfirmEmail"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "userId": userId, 
            "code": code
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter returnUrl: (query)  (optional)
     - parameter remoteError: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountExternalLoginCallbackGet(returnUrl: String? = nil, remoteError: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountExternalLoginCallbackGetWithRequestBuilder(returnUrl: returnUrl, remoteError: remoteError).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/ExternalLoginCallback
     
     - parameter returnUrl: (query)  (optional)
     - parameter remoteError: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountExternalLoginCallbackGetWithRequestBuilder(returnUrl: String? = nil, remoteError: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/ExternalLoginCallback"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "returnUrl": returnUrl, 
            "remoteError": remoteError
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter email: (query)  (optional)
     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountExternalLoginConfirmationPost(email: String? = nil, returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountExternalLoginConfirmationPostWithRequestBuilder(email: email, returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/ExternalLoginConfirmation
     
     - parameter email: (query)  (optional)
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountExternalLoginConfirmationPostWithRequestBuilder(email: String? = nil, returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/ExternalLoginConfirmation"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Email": email, 
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter provider: (query)  (optional)
     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountExternalLoginPost(provider: String? = nil, returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountExternalLoginPostWithRequestBuilder(provider: provider, returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/ExternalLogin
     
     - parameter provider: (query)  (optional)
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountExternalLoginPostWithRequestBuilder(provider: String? = nil, returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/ExternalLogin"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "provider": provider, 
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountForgotPasswordConfirmationGet(completion: @escaping ((_ error: Error?) -> Void)) {
        accountForgotPasswordConfirmationGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/ForgotPasswordConfirmation

     - returns: RequestBuilder<Void> 
     */
    open class func accountForgotPasswordConfirmationGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Account/ForgotPasswordConfirmation"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountForgotPasswordGet(completion: @escaping ((_ error: Error?) -> Void)) {
        accountForgotPasswordGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/ForgotPassword

     - returns: RequestBuilder<Void> 
     */
    open class func accountForgotPasswordGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Account/ForgotPassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter email: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountForgotPasswordPost(email: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountForgotPasswordPostWithRequestBuilder(email: email).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/ForgotPassword
     
     - parameter email: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountForgotPasswordPostWithRequestBuilder(email: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/ForgotPassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Email": email
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLockoutGet(completion: @escaping ((_ error: Error?) -> Void)) {
        accountLockoutGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/Lockout

     - returns: RequestBuilder<Void> 
     */
    open class func accountLockoutGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Account/Lockout"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLoginGet(returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountLoginGetWithRequestBuilder(returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/Login
     
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountLoginGetWithRequestBuilder(returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/Login"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter email: (query)  (optional)
     - parameter userName: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter rememberMe: (query)  (optional)
     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLoginPost(email: String? = nil, userName: String? = nil, password: String? = nil, rememberMe: Bool? = nil, returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountLoginPostWithRequestBuilder(email: email, userName: userName, password: password, rememberMe: rememberMe, returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/Login
     
     - parameter email: (query)  (optional)
     - parameter userName: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter rememberMe: (query)  (optional)
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountLoginPostWithRequestBuilder(email: String? = nil, userName: String? = nil, password: String? = nil, rememberMe: Bool? = nil, returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/Login"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Email": email, 
            "UserName": userName, 
            "Password": password, 
            "RememberMe": rememberMe, 
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter rememberMe: (query)  (optional)
     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLoginWith2faGet(rememberMe: Bool? = nil, returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountLoginWith2faGetWithRequestBuilder(rememberMe: rememberMe, returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/LoginWith2fa
     
     - parameter rememberMe: (query)  (optional)
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountLoginWith2faGetWithRequestBuilder(rememberMe: Bool? = nil, returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/LoginWith2fa"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "rememberMe": rememberMe, 
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter twoFactorCode: (query)  (optional)
     - parameter rememberMachine: (query)  (optional)
     - parameter rememberMe: (query)  (optional)
     - parameter rememberMe2: (query)  (optional)
     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLoginWith2faPost(twoFactorCode: String? = nil, rememberMachine: Bool? = nil, rememberMe: Bool? = nil, rememberMe2: Bool? = nil, returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountLoginWith2faPostWithRequestBuilder(twoFactorCode: twoFactorCode, rememberMachine: rememberMachine, rememberMe: rememberMe, rememberMe2: rememberMe2, returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/LoginWith2fa
     
     - parameter twoFactorCode: (query)  (optional)
     - parameter rememberMachine: (query)  (optional)
     - parameter rememberMe: (query)  (optional)
     - parameter rememberMe2: (query)  (optional)
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountLoginWith2faPostWithRequestBuilder(twoFactorCode: String? = nil, rememberMachine: Bool? = nil, rememberMe: Bool? = nil, rememberMe2: Bool? = nil, returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/LoginWith2fa"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "TwoFactorCode": twoFactorCode, 
            "RememberMachine": rememberMachine, 
            "RememberMe": rememberMe, 
            "rememberMe": rememberMe2, 
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLoginWithRecoveryCodeGet(returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountLoginWithRecoveryCodeGetWithRequestBuilder(returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/LoginWithRecoveryCode
     
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountLoginWithRecoveryCodeGetWithRequestBuilder(returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/LoginWithRecoveryCode"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter recoveryCode: (query)  (optional)
     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLoginWithRecoveryCodePost(recoveryCode: String? = nil, returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountLoginWithRecoveryCodePostWithRequestBuilder(recoveryCode: recoveryCode, returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/LoginWithRecoveryCode
     
     - parameter recoveryCode: (query)  (optional)
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountLoginWithRecoveryCodePostWithRequestBuilder(recoveryCode: String? = nil, returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/LoginWithRecoveryCode"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "RecoveryCode": recoveryCode, 
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLogoutPost(completion: @escaping ((_ error: Error?) -> Void)) {
        accountLogoutPostWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/Logout

     - returns: RequestBuilder<Void> 
     */
    open class func accountLogoutPostWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Account/Logout"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountRegisterGet(returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountRegisterGetWithRequestBuilder(returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/Register
     
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountRegisterGetWithRequestBuilder(returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/Register"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter email: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter returnUrl: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountRegisterPost(email: String? = nil, password: String? = nil, confirmPassword: String? = nil, returnUrl: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountRegisterPostWithRequestBuilder(email: email, password: password, confirmPassword: confirmPassword, returnUrl: returnUrl).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/Register
     
     - parameter email: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter returnUrl: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountRegisterPostWithRequestBuilder(email: String? = nil, password: String? = nil, confirmPassword: String? = nil, returnUrl: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/Register"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Email": email, 
            "Password": password, 
            "ConfirmPassword": confirmPassword, 
            "returnUrl": returnUrl
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountResetPasswordConfirmationGet(completion: @escaping ((_ error: Error?) -> Void)) {
        accountResetPasswordConfirmationGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/ResetPasswordConfirmation

     - returns: RequestBuilder<Void> 
     */
    open class func accountResetPasswordConfirmationGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/Account/ResetPasswordConfirmation"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter code: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountResetPasswordGet(code: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountResetPasswordGetWithRequestBuilder(code: code).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /Account/ResetPassword
     
     - parameter code: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountResetPasswordGetWithRequestBuilder(code: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/ResetPassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "code": code
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter email: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountResetPasswordPost(email: String? = nil, password: String? = nil, confirmPassword: String? = nil, code: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        accountResetPasswordPostWithRequestBuilder(email: email, password: password, confirmPassword: confirmPassword, code: code).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /Account/ResetPassword
     
     - parameter email: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter confirmPassword: (query)  (optional)
     - parameter code: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func accountResetPasswordPostWithRequestBuilder(email: String? = nil, password: String? = nil, confirmPassword: String? = nil, code: String? = nil) -> RequestBuilder<Void> {
        let path = "/Account/ResetPassword"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "Email": email, 
            "Password": password, 
            "ConfirmPassword": confirmPassword, 
            "Code": code
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter lmv: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiRegisterPost(lmv: LoginViewModel? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        apiRegisterPostWithRequestBuilder(lmv: lmv).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /api/register
     
     - parameter lmv: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiRegisterPostWithRequestBuilder(lmv: LoginViewModel? = nil) -> RequestBuilder<Void> {
        let path = "/api/register"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: lmv)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
