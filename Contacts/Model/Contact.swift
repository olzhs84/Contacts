//
//  Contact.swift
//  Contacts
//
//  Created by olzhs on 18.01.2022.
//

import Foundation

protocol ContactProtocol {
    var title: String { get set }

    var phone: String { get set }

}

struct Contact: ContactProtocol {
    
    var title: String
    var phone: String
    
    
}



