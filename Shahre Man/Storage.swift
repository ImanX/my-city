//
//  Storage.swift
//  Shahre Man
//
//  Created by ImanX on 2/10/18.
//  Copyright © 2018 ImanX. All rights reserved.
//

import Foundation
class Storage: UserDefaults {

    public static var me:Storage{
        return Storage();
    }

    private init() {
        super.init(suiteName: "shahreman.hex")!;
    }
        
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key);
        self.synchronize();
    }
    
    override func removeObject(forKey defaultName: String) {
        super.removeObject(forKey: defaultName);
        self.synchronize();
    }
    
    func removeAll(){
        for key in self.dictionaryRepresentation().keys{
            if key.contains("city"){
                continue;
            }
            removeObject(forKey: key);
        }
    }
    
    
}
