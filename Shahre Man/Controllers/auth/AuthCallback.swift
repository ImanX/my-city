//
//  AuthCallback.swift
//  Shahre Man
//
//  Created by ImanX on 2/11/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class AuthCallback: RequestCallback {
    public var didFindUserAndWaitVerification : (()->Void)?;
    public var didNotFoundUser:(()->Void)?;
    public var didSuccessResolveProfile:((_ profile:Profile)->Void)?;
    public var didSuccessRegisterUser:(()->Void)?;
    public var didSuccessSendOTP:(()->Void)?;
    public var didSuccessAuthentication:((_ profile:Profile)->Void)?;
}
