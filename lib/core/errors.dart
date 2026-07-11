import 'dart:async';
import 'dart:io';

import '../l10n/app_localizations.dart';

/// True when [error] looks like a lost/absent internet connection rather than a
/// genuine server or logic fault. Used to show "you're offline, try again"
/// instead of a raw exception string like `ClientException: Failed host
/// lookup`, and to treat cloud failures as non-fatal.
///
/// Deliberately string-based as well as type-based: Supabase wraps network
/// failures in several types (`ClientException`, `AuthRetryableFetchException`,
/// `SocketException`, `FunctionException`, `TimeoutException`) across its auth,
/// database and functions clients, and matching on text keeps this one check
/// authoritative without importing every one of them.
bool isOfflineError(Object? error) {
  if (error == null) return false;
  if (error is SocketException || error is TimeoutException) return true;
  final s = error.toString().toLowerCase();
  return s.contains('socketexception') ||
      s.contains('failed host lookup') ||
      s.contains('clientexception') ||
      s.contains('connection closed') ||
      s.contains('connection refused') ||
      s.contains('connection reset') ||
      s.contains('connection timed out') ||
      s.contains('network is unreachable') ||
      s.contains('no address associated with hostname') ||
      s.contains('xmlhttprequest') || // web
      s.contains('retryable') || // AuthRetryableFetchException
      s.contains('timeout');
}

/// A short, human, localized message for [error] — offline gets its own line,
/// everything else falls back to a generic "something went wrong". Never
/// exposes a raw exception to the user.
String friendlyError(Object? error, AppLocalizations l) =>
    isOfflineError(error) ? l.errorOffline : l.errorGeneric;
