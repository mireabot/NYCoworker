//
//  FirebaseErrors.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/18/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

func parseAuthError(_ error: Error) -> String {
    guard let authError = error as? AuthErrorCode else {
        return "Unknown error occurred"
    }
    switch authError.code {
    case .invalidCustomToken:
        return "Invalid custom token"
    case .customTokenMismatch:
        return "Service account and API key belong to different projects"
    case .invalidCredential:
        return "Invalid IDP token or request URI"
    case .userDisabled:
        return "User account is disabled on the server"
    case .networkError:
        return "Looks like you're offline."
    default:
        return "Unknown error occurred"
    }
}

func firestoreError(forError error: Error) -> String {
    guard let errorCode = error as? FirestoreErrorCode else {
        return "Unknown error occurred"
    }
    
    switch errorCode.code {
    case .cancelled:
        return "The operation was cancelled."
    case .invalidArgument:
        return "The operation was called with an invalid argument."
    case .deadlineExceeded:
        return "The operation timed out."
    case .notFound:
        return "The requested document or collection was not found."
    case .OK:
        return "Unknown error occurred"
    case .unknown:
        return "Unknown error occurred"
    case .alreadyExists:
        return "Object already exist"
    case .permissionDenied:
        return "Unknown error occurred"
    case .resourceExhausted:
        return "Unknown error occurred"
    case .failedPrecondition:
        return "Unknown error occurred"
    case .aborted:
        return "Unknown error occurred"
    case .outOfRange:
        return "Unknown error occurred"
    case .unimplemented:
        return "Unknown error occurred"
    case .internal:
        return "Unknown error occurred"
    case .unavailable:
        return "Unknown error occurred"
    case .dataLoss:
        return "Unknown error occurred"
    case .unauthenticated:
        return "Unknown error occurred"
    @unknown default:
        return "Unknown error occurred"
    }
}
