//
// AuthorizationAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class AuthorizationAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserinfoGet(completion: @escaping ((_ error: Error?) -> Void)) {
        apiUserinfoGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /api/userinfo

     - returns: RequestBuilder<Void> 
     */
    open class func apiUserinfoGetWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/api/userinfo"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter accessToken: (query)  (optional)
     - parameter acrValues: (query)  (optional)
     - parameter assertion: (query)  (optional)
     - parameter claimsLocales: (query)  (optional)
     - parameter clientAssertion: (query)  (optional)
     - parameter clientAssertionType: (query)  (optional)
     - parameter clientId: (query)  (optional)
     - parameter clientSecret: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter codeChallenge: (query)  (optional)
     - parameter codeChallengeMethod: (query)  (optional)
     - parameter codeVerifier: (query)  (optional)
     - parameter display: (query)  (optional)
     - parameter grantType: (query)  (optional)
     - parameter identityProvider: (query)  (optional)
     - parameter idTokenHint: (query)  (optional)
     - parameter loginHint: (query)  (optional)
     - parameter maxAge: (query)  (optional)
     - parameter nonce: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter postLogoutRedirectUri: (query)  (optional)
     - parameter prompt: (query)  (optional)
     - parameter redirectUri: (query)  (optional)
     - parameter refreshToken: (query)  (optional)
     - parameter request: (query)  (optional)
     - parameter requestId: (query)  (optional)
     - parameter requestUri: (query)  (optional)
     - parameter resource: (query)  (optional)
     - parameter responseMode: (query)  (optional)
     - parameter responseType: (query)  (optional)
     - parameter scope: (query)  (optional)
     - parameter state: (query)  (optional)
     - parameter token: (query)  (optional)
     - parameter tokenTypeHint: (query)  (optional)
     - parameter uiLocales: (query)  (optional)
     - parameter username: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func connectAuthorizeGet(accessToken: String? = nil, acrValues: String? = nil, assertion: String? = nil, claimsLocales: String? = nil, clientAssertion: String? = nil, clientAssertionType: String? = nil, clientId: String? = nil, clientSecret: String? = nil, code: String? = nil, codeChallenge: String? = nil, codeChallengeMethod: String? = nil, codeVerifier: String? = nil, display: String? = nil, grantType: String? = nil, identityProvider: String? = nil, idTokenHint: String? = nil, loginHint: String? = nil, maxAge: Int64? = nil, nonce: String? = nil, password: String? = nil, postLogoutRedirectUri: String? = nil, prompt: String? = nil, redirectUri: String? = nil, refreshToken: String? = nil, request: String? = nil, requestId: String? = nil, requestUri: String? = nil, resource: String? = nil, responseMode: String? = nil, responseType: String? = nil, scope: String? = nil, state: String? = nil, token: String? = nil, tokenTypeHint: String? = nil, uiLocales: String? = nil, username: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        connectAuthorizeGetWithRequestBuilder(accessToken: accessToken, acrValues: acrValues, assertion: assertion, claimsLocales: claimsLocales, clientAssertion: clientAssertion, clientAssertionType: clientAssertionType, clientId: clientId, clientSecret: clientSecret, code: code, codeChallenge: codeChallenge, codeChallengeMethod: codeChallengeMethod, codeVerifier: codeVerifier, display: display, grantType: grantType, identityProvider: identityProvider, idTokenHint: idTokenHint, loginHint: loginHint, maxAge: maxAge, nonce: nonce, password: password, postLogoutRedirectUri: postLogoutRedirectUri, prompt: prompt, redirectUri: redirectUri, refreshToken: refreshToken, request: request, requestId: requestId, requestUri: requestUri, resource: resource, responseMode: responseMode, responseType: responseType, scope: scope, state: state, token: token, tokenTypeHint: tokenTypeHint, uiLocales: uiLocales, username: username).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - GET /connect/authorize
     
     - parameter accessToken: (query)  (optional)
     - parameter acrValues: (query)  (optional)
     - parameter assertion: (query)  (optional)
     - parameter claimsLocales: (query)  (optional)
     - parameter clientAssertion: (query)  (optional)
     - parameter clientAssertionType: (query)  (optional)
     - parameter clientId: (query)  (optional)
     - parameter clientSecret: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter codeChallenge: (query)  (optional)
     - parameter codeChallengeMethod: (query)  (optional)
     - parameter codeVerifier: (query)  (optional)
     - parameter display: (query)  (optional)
     - parameter grantType: (query)  (optional)
     - parameter identityProvider: (query)  (optional)
     - parameter idTokenHint: (query)  (optional)
     - parameter loginHint: (query)  (optional)
     - parameter maxAge: (query)  (optional)
     - parameter nonce: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter postLogoutRedirectUri: (query)  (optional)
     - parameter prompt: (query)  (optional)
     - parameter redirectUri: (query)  (optional)
     - parameter refreshToken: (query)  (optional)
     - parameter request: (query)  (optional)
     - parameter requestId: (query)  (optional)
     - parameter requestUri: (query)  (optional)
     - parameter resource: (query)  (optional)
     - parameter responseMode: (query)  (optional)
     - parameter responseType: (query)  (optional)
     - parameter scope: (query)  (optional)
     - parameter state: (query)  (optional)
     - parameter token: (query)  (optional)
     - parameter tokenTypeHint: (query)  (optional)
     - parameter uiLocales: (query)  (optional)
     - parameter username: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func connectAuthorizeGetWithRequestBuilder(accessToken: String? = nil, acrValues: String? = nil, assertion: String? = nil, claimsLocales: String? = nil, clientAssertion: String? = nil, clientAssertionType: String? = nil, clientId: String? = nil, clientSecret: String? = nil, code: String? = nil, codeChallenge: String? = nil, codeChallengeMethod: String? = nil, codeVerifier: String? = nil, display: String? = nil, grantType: String? = nil, identityProvider: String? = nil, idTokenHint: String? = nil, loginHint: String? = nil, maxAge: Int64? = nil, nonce: String? = nil, password: String? = nil, postLogoutRedirectUri: String? = nil, prompt: String? = nil, redirectUri: String? = nil, refreshToken: String? = nil, request: String? = nil, requestId: String? = nil, requestUri: String? = nil, resource: String? = nil, responseMode: String? = nil, responseType: String? = nil, scope: String? = nil, state: String? = nil, token: String? = nil, tokenTypeHint: String? = nil, uiLocales: String? = nil, username: String? = nil) -> RequestBuilder<Void> {
        let path = "/connect/authorize"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "AccessToken": accessToken, 
            "AcrValues": acrValues, 
            "Assertion": assertion, 
            "ClaimsLocales": claimsLocales, 
            "ClientAssertion": clientAssertion, 
            "ClientAssertionType": clientAssertionType, 
            "ClientId": clientId, 
            "ClientSecret": clientSecret, 
            "Code": code, 
            "CodeChallenge": codeChallenge, 
            "CodeChallengeMethod": codeChallengeMethod, 
            "CodeVerifier": codeVerifier, 
            "Display": display, 
            "GrantType": grantType, 
            "IdentityProvider": identityProvider, 
            "IdTokenHint": idTokenHint, 
            "LoginHint": loginHint, 
            "MaxAge": maxAge?.encodeToJSON(), 
            "Nonce": nonce, 
            "Password": password, 
            "PostLogoutRedirectUri": postLogoutRedirectUri, 
            "Prompt": prompt, 
            "RedirectUri": redirectUri, 
            "RefreshToken": refreshToken, 
            "Request": request, 
            "RequestId": requestId, 
            "RequestUri": requestUri, 
            "Resource": resource, 
            "ResponseMode": responseMode, 
            "ResponseType": responseType, 
            "Scope": scope, 
            "State": state, 
            "Token": token, 
            "TokenTypeHint": tokenTypeHint, 
            "UiLocales": uiLocales, 
            "Username": username
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter accessToken: (query)  (optional)
     - parameter acrValues: (query)  (optional)
     - parameter assertion: (query)  (optional)
     - parameter claimsLocales: (query)  (optional)
     - parameter clientAssertion: (query)  (optional)
     - parameter clientAssertionType: (query)  (optional)
     - parameter clientId: (query)  (optional)
     - parameter clientSecret: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter codeChallenge: (query)  (optional)
     - parameter codeChallengeMethod: (query)  (optional)
     - parameter codeVerifier: (query)  (optional)
     - parameter display: (query)  (optional)
     - parameter grantType: (query)  (optional)
     - parameter identityProvider: (query)  (optional)
     - parameter idTokenHint: (query)  (optional)
     - parameter loginHint: (query)  (optional)
     - parameter maxAge: (query)  (optional)
     - parameter nonce: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter postLogoutRedirectUri: (query)  (optional)
     - parameter prompt: (query)  (optional)
     - parameter redirectUri: (query)  (optional)
     - parameter refreshToken: (query)  (optional)
     - parameter request: (query)  (optional)
     - parameter requestId: (query)  (optional)
     - parameter requestUri: (query)  (optional)
     - parameter resource: (query)  (optional)
     - parameter responseMode: (query)  (optional)
     - parameter responseType: (query)  (optional)
     - parameter scope: (query)  (optional)
     - parameter state: (query)  (optional)
     - parameter token: (query)  (optional)
     - parameter tokenTypeHint: (query)  (optional)
     - parameter uiLocales: (query)  (optional)
     - parameter username: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func connectAuthorizePost(accessToken: String? = nil, acrValues: String? = nil, assertion: String? = nil, claimsLocales: String? = nil, clientAssertion: String? = nil, clientAssertionType: String? = nil, clientId: String? = nil, clientSecret: String? = nil, code: String? = nil, codeChallenge: String? = nil, codeChallengeMethod: String? = nil, codeVerifier: String? = nil, display: String? = nil, grantType: String? = nil, identityProvider: String? = nil, idTokenHint: String? = nil, loginHint: String? = nil, maxAge: Int64? = nil, nonce: String? = nil, password: String? = nil, postLogoutRedirectUri: String? = nil, prompt: String? = nil, redirectUri: String? = nil, refreshToken: String? = nil, request: String? = nil, requestId: String? = nil, requestUri: String? = nil, resource: String? = nil, responseMode: String? = nil, responseType: String? = nil, scope: String? = nil, state: String? = nil, token: String? = nil, tokenTypeHint: String? = nil, uiLocales: String? = nil, username: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        connectAuthorizePostWithRequestBuilder(accessToken: accessToken, acrValues: acrValues, assertion: assertion, claimsLocales: claimsLocales, clientAssertion: clientAssertion, clientAssertionType: clientAssertionType, clientId: clientId, clientSecret: clientSecret, code: code, codeChallenge: codeChallenge, codeChallengeMethod: codeChallengeMethod, codeVerifier: codeVerifier, display: display, grantType: grantType, identityProvider: identityProvider, idTokenHint: idTokenHint, loginHint: loginHint, maxAge: maxAge, nonce: nonce, password: password, postLogoutRedirectUri: postLogoutRedirectUri, prompt: prompt, redirectUri: redirectUri, refreshToken: refreshToken, request: request, requestId: requestId, requestUri: requestUri, resource: resource, responseMode: responseMode, responseType: responseType, scope: scope, state: state, token: token, tokenTypeHint: tokenTypeHint, uiLocales: uiLocales, username: username).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /connect/authorize
     
     - parameter accessToken: (query)  (optional)
     - parameter acrValues: (query)  (optional)
     - parameter assertion: (query)  (optional)
     - parameter claimsLocales: (query)  (optional)
     - parameter clientAssertion: (query)  (optional)
     - parameter clientAssertionType: (query)  (optional)
     - parameter clientId: (query)  (optional)
     - parameter clientSecret: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter codeChallenge: (query)  (optional)
     - parameter codeChallengeMethod: (query)  (optional)
     - parameter codeVerifier: (query)  (optional)
     - parameter display: (query)  (optional)
     - parameter grantType: (query)  (optional)
     - parameter identityProvider: (query)  (optional)
     - parameter idTokenHint: (query)  (optional)
     - parameter loginHint: (query)  (optional)
     - parameter maxAge: (query)  (optional)
     - parameter nonce: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter postLogoutRedirectUri: (query)  (optional)
     - parameter prompt: (query)  (optional)
     - parameter redirectUri: (query)  (optional)
     - parameter refreshToken: (query)  (optional)
     - parameter request: (query)  (optional)
     - parameter requestId: (query)  (optional)
     - parameter requestUri: (query)  (optional)
     - parameter resource: (query)  (optional)
     - parameter responseMode: (query)  (optional)
     - parameter responseType: (query)  (optional)
     - parameter scope: (query)  (optional)
     - parameter state: (query)  (optional)
     - parameter token: (query)  (optional)
     - parameter tokenTypeHint: (query)  (optional)
     - parameter uiLocales: (query)  (optional)
     - parameter username: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func connectAuthorizePostWithRequestBuilder(accessToken: String? = nil, acrValues: String? = nil, assertion: String? = nil, claimsLocales: String? = nil, clientAssertion: String? = nil, clientAssertionType: String? = nil, clientId: String? = nil, clientSecret: String? = nil, code: String? = nil, codeChallenge: String? = nil, codeChallengeMethod: String? = nil, codeVerifier: String? = nil, display: String? = nil, grantType: String? = nil, identityProvider: String? = nil, idTokenHint: String? = nil, loginHint: String? = nil, maxAge: Int64? = nil, nonce: String? = nil, password: String? = nil, postLogoutRedirectUri: String? = nil, prompt: String? = nil, redirectUri: String? = nil, refreshToken: String? = nil, request: String? = nil, requestId: String? = nil, requestUri: String? = nil, resource: String? = nil, responseMode: String? = nil, responseType: String? = nil, scope: String? = nil, state: String? = nil, token: String? = nil, tokenTypeHint: String? = nil, uiLocales: String? = nil, username: String? = nil) -> RequestBuilder<Void> {
        let path = "/connect/authorize"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "AccessToken": accessToken, 
            "AcrValues": acrValues, 
            "Assertion": assertion, 
            "ClaimsLocales": claimsLocales, 
            "ClientAssertion": clientAssertion, 
            "ClientAssertionType": clientAssertionType, 
            "ClientId": clientId, 
            "ClientSecret": clientSecret, 
            "Code": code, 
            "CodeChallenge": codeChallenge, 
            "CodeChallengeMethod": codeChallengeMethod, 
            "CodeVerifier": codeVerifier, 
            "Display": display, 
            "GrantType": grantType, 
            "IdentityProvider": identityProvider, 
            "IdTokenHint": idTokenHint, 
            "LoginHint": loginHint, 
            "MaxAge": maxAge?.encodeToJSON(), 
            "Nonce": nonce, 
            "Password": password, 
            "PostLogoutRedirectUri": postLogoutRedirectUri, 
            "Prompt": prompt, 
            "RedirectUri": redirectUri, 
            "RefreshToken": refreshToken, 
            "Request": request, 
            "RequestId": requestId, 
            "RequestUri": requestUri, 
            "Resource": resource, 
            "ResponseMode": responseMode, 
            "ResponseType": responseType, 
            "Scope": scope, 
            "State": state, 
            "Token": token, 
            "TokenTypeHint": tokenTypeHint, 
            "UiLocales": uiLocales, 
            "Username": username
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func connectLogoutPost(completion: @escaping ((_ error: Error?) -> Void)) {
        connectLogoutPostWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /connect/logout

     - returns: RequestBuilder<Void> 
     */
    open class func connectLogoutPostWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/connect/logout"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter accessToken: (query)  (optional)
     - parameter acrValues: (query)  (optional)
     - parameter assertion: (query)  (optional)
     - parameter claimsLocales: (query)  (optional)
     - parameter clientAssertion: (query)  (optional)
     - parameter clientAssertionType: (query)  (optional)
     - parameter clientId: (query)  (optional)
     - parameter clientSecret: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter codeChallenge: (query)  (optional)
     - parameter codeChallengeMethod: (query)  (optional)
     - parameter codeVerifier: (query)  (optional)
     - parameter display: (query)  (optional)
     - parameter grantType: (query)  (optional)
     - parameter identityProvider: (query)  (optional)
     - parameter idTokenHint: (query)  (optional)
     - parameter loginHint: (query)  (optional)
     - parameter maxAge: (query)  (optional)
     - parameter nonce: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter postLogoutRedirectUri: (query)  (optional)
     - parameter prompt: (query)  (optional)
     - parameter redirectUri: (query)  (optional)
     - parameter refreshToken: (query)  (optional)
     - parameter request: (query)  (optional)
     - parameter requestId: (query)  (optional)
     - parameter requestUri: (query)  (optional)
     - parameter resource: (query)  (optional)
     - parameter responseMode: (query)  (optional)
     - parameter responseType: (query)  (optional)
     - parameter scope: (query)  (optional)
     - parameter state: (query)  (optional)
     - parameter token: (query)  (optional)
     - parameter tokenTypeHint: (query)  (optional)
     - parameter uiLocales: (query)  (optional)
     - parameter username: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func connectTokenPost(accessToken: String? = nil, acrValues: String? = nil, assertion: String? = nil, claimsLocales: String? = nil, clientAssertion: String? = nil, clientAssertionType: String? = nil, clientId: String? = nil, clientSecret: String? = nil, code: String? = nil, codeChallenge: String? = nil, codeChallengeMethod: String? = nil, codeVerifier: String? = nil, display: String? = nil, grantType: String? = nil, identityProvider: String? = nil, idTokenHint: String? = nil, loginHint: String? = nil, maxAge: Int64? = nil, nonce: String? = nil, password: String? = nil, postLogoutRedirectUri: String? = nil, prompt: String? = nil, redirectUri: String? = nil, refreshToken: String? = nil, request: String? = nil, requestId: String? = nil, requestUri: String? = nil, resource: String? = nil, responseMode: String? = nil, responseType: String? = nil, scope: String? = nil, state: String? = nil, token: String? = nil, tokenTypeHint: String? = nil, uiLocales: String? = nil, username: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        connectTokenPostWithRequestBuilder(accessToken: accessToken, acrValues: acrValues, assertion: assertion, claimsLocales: claimsLocales, clientAssertion: clientAssertion, clientAssertionType: clientAssertionType, clientId: clientId, clientSecret: clientSecret, code: code, codeChallenge: codeChallenge, codeChallengeMethod: codeChallengeMethod, codeVerifier: codeVerifier, display: display, grantType: grantType, identityProvider: identityProvider, idTokenHint: idTokenHint, loginHint: loginHint, maxAge: maxAge, nonce: nonce, password: password, postLogoutRedirectUri: postLogoutRedirectUri, prompt: prompt, redirectUri: redirectUri, refreshToken: refreshToken, request: request, requestId: requestId, requestUri: requestUri, resource: resource, responseMode: responseMode, responseType: responseType, scope: scope, state: state, token: token, tokenTypeHint: tokenTypeHint, uiLocales: uiLocales, username: username).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     - POST /connect/token
     
     - parameter accessToken: (query)  (optional)
     - parameter acrValues: (query)  (optional)
     - parameter assertion: (query)  (optional)
     - parameter claimsLocales: (query)  (optional)
     - parameter clientAssertion: (query)  (optional)
     - parameter clientAssertionType: (query)  (optional)
     - parameter clientId: (query)  (optional)
     - parameter clientSecret: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter codeChallenge: (query)  (optional)
     - parameter codeChallengeMethod: (query)  (optional)
     - parameter codeVerifier: (query)  (optional)
     - parameter display: (query)  (optional)
     - parameter grantType: (query)  (optional)
     - parameter identityProvider: (query)  (optional)
     - parameter idTokenHint: (query)  (optional)
     - parameter loginHint: (query)  (optional)
     - parameter maxAge: (query)  (optional)
     - parameter nonce: (query)  (optional)
     - parameter password: (query)  (optional)
     - parameter postLogoutRedirectUri: (query)  (optional)
     - parameter prompt: (query)  (optional)
     - parameter redirectUri: (query)  (optional)
     - parameter refreshToken: (query)  (optional)
     - parameter request: (query)  (optional)
     - parameter requestId: (query)  (optional)
     - parameter requestUri: (query)  (optional)
     - parameter resource: (query)  (optional)
     - parameter responseMode: (query)  (optional)
     - parameter responseType: (query)  (optional)
     - parameter scope: (query)  (optional)
     - parameter state: (query)  (optional)
     - parameter token: (query)  (optional)
     - parameter tokenTypeHint: (query)  (optional)
     - parameter uiLocales: (query)  (optional)
     - parameter username: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func connectTokenPostWithRequestBuilder(accessToken: String? = nil, acrValues: String? = nil, assertion: String? = nil, claimsLocales: String? = nil, clientAssertion: String? = nil, clientAssertionType: String? = nil, clientId: String? = nil, clientSecret: String? = nil, code: String? = nil, codeChallenge: String? = nil, codeChallengeMethod: String? = nil, codeVerifier: String? = nil, display: String? = nil, grantType: String? = nil, identityProvider: String? = nil, idTokenHint: String? = nil, loginHint: String? = nil, maxAge: Int64? = nil, nonce: String? = nil, password: String? = nil, postLogoutRedirectUri: String? = nil, prompt: String? = nil, redirectUri: String? = nil, refreshToken: String? = nil, request: String? = nil, requestId: String? = nil, requestUri: String? = nil, resource: String? = nil, responseMode: String? = nil, responseType: String? = nil, scope: String? = nil, state: String? = nil, token: String? = nil, tokenTypeHint: String? = nil, uiLocales: String? = nil, username: String? = nil) -> RequestBuilder<Void> {
        let path = "/connect/token"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "AccessToken": accessToken, 
            "AcrValues": acrValues, 
            "Assertion": assertion, 
            "ClaimsLocales": claimsLocales, 
            "ClientAssertion": clientAssertion, 
            "ClientAssertionType": clientAssertionType, 
            "ClientId": clientId, 
            "ClientSecret": clientSecret, 
            "Code": code, 
            "CodeChallenge": codeChallenge, 
            "CodeChallengeMethod": codeChallengeMethod, 
            "CodeVerifier": codeVerifier, 
            "Display": display, 
            "GrantType": grantType, 
            "IdentityProvider": identityProvider, 
            "IdTokenHint": idTokenHint, 
            "LoginHint": loginHint, 
            "MaxAge": maxAge?.encodeToJSON(), 
            "Nonce": nonce, 
            "Password": password, 
            "PostLogoutRedirectUri": postLogoutRedirectUri, 
            "Prompt": prompt, 
            "RedirectUri": redirectUri, 
            "RefreshToken": refreshToken, 
            "Request": request, 
            "RequestId": requestId, 
            "RequestUri": requestUri, 
            "Resource": resource, 
            "ResponseMode": responseMode, 
            "ResponseType": responseType, 
            "Scope": scope, 
            "State": state, 
            "Token": token, 
            "TokenTypeHint": tokenTypeHint, 
            "UiLocales": uiLocales, 
            "Username": username
        ])
        

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
