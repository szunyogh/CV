class ExceptionHelper {
  static String getExceptionMessage(String errorCode) {
    switch (errorCode) {
      case 'auth/email-already-exists':
        return 'The provided email is already in use by an existing user. Each user must have a unique email.';
      case 'auth/id-token-expired':
        return 'The provided Firebase ID token is expired.';
      case 'auth/invalid-argument':
        return 'An invalid argument was provided to an Authentication method. The error message should contain additional information.';
      case 'auth/invalid-email':
        return 'The provided value for the email user property is invalid. It must be a string email address.';
      case 'auth/invalid-email-verified':
        return 'The provided value for the emailVerified user property is invalid. It must be a boolean.';
      case 'auth/invalid-id-token':
        return 'The provided ID token is not a valid Firebase ID token.';
      case 'auth/invalid-password':
        return 'The provided value for the password user property is invalid. It must be a string with at least six characters.';
      case 'auth/user-not-found':
        return 'There is no existing user record corresponding to the provided identifier.';
      case 'ABORTED':
        return 'The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.';
      case 'ALREADY_EXISTS':
        return 'Some document that we attempted to create already exists.';
      case 'CANCELLED':
        return 'The operation was cancelled (typically by the caller).';
      case 'DATA_LOSS':
        return 'Unrecoverable data loss or corruption.';
      case 'DEADLINE_EXCEEDED':
        return 'Deadline expired before operation could complete. For operations that change the state of the system, this error may be returned even if the operation has completed successfully. For example, a successful response from a server could have been delayed long enough for the deadline to expire.';
      case 'FAILED_PRECONDITION':
        return '''Operation was rejected because the system is not in a state required for the operation's execution.''';
      case 'INTERNAL':
        return 'Internal errors. Means some invariants expected by underlying system has been broken. If you see one of these errors, something is very broken.';
      case 'INVALID_ARGUMENT':
        return 'Client specified an invalid argument. Note that this differs from FAILED_PRECONDITION. INVALID_ARGUMENT indicates arguments that are problematic regardless of the state of the system (e.g., an invalid field name).';
      case 'NOT_FOUND':
        return 'Some requested document was not found.';
      case 'OUT_OF_RANGE':
        return 'Operation was attempted past the valid range.';
      case 'PERMISSION_DENIED':
        return 'The caller does not have permission to execute the specified operation.';
      case 'RESOURCE_EXHAUSTED':
        return 'Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.';
      case 'UNAUTHENTICATED':
        return 'The request does not have valid authentication credentials for the operation.';
      case 'UNAVAILABLE':
        return 'The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff.';
      case 'UNIMPLEMENTED':
        return 'Operation is not implemented or not supported/enabled.';
      case 'storage/object-not-found':
        return 'No object exists at the desired reference.';
      case 'storage/unauthenticated':
        return 'User is unauthenticated, please authenticate and try again.';
      case 'storage/unauthorized':
        return 'User is not authorized to perform the desired action, check your security rules to ensure they are correct.';
      case 'storage/invalid-checksum':
        return 'File on the client does not match the checksum of the file received by the server. Try uploading again.';
      case 'storage/canceled':
        return 'User canceled the operation.';
      case 'storage/invalid-event-name':
        return 'Invalid event name provided. Must be one of [`running`, `progress`, `pause`]';
      case 'storage/invalid-argument':
        return 'The argument passed to put() must be `File`, `Blob`, or `UInt8` Array. The argument passed to putString() must be a raw, `Base64`, or `Base64URL` string.';
      case 'storage/server-file-wrong-size':
        return 'File on the client does not match the size of the file recieved by the server. Try uploading again.';
      default:
        return 'Unknown error...';
    }
  }
}
