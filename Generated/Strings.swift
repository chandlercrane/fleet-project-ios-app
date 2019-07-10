// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Long tap on the map to select a destination
  internal static let arMapHint = L10n.tr("Localizable", "ARMap_Hint")
  /// Calibration: %d%%
  internal static func generalCalibration(_ p1: Int) -> String {
    return L10n.tr("Localizable", "General_Calibration", p1)
  }
  /// AR Routing
  internal static let menuARButton = L10n.tr("Localizable", "Menu_AR_Button")
  /// Safety mode
  internal static let menuCollisionDetectionButton = L10n.tr("Localizable", "Menu_CollisionDetection_Button")
  /// Lane detection
  internal static let menuLaneDetectionButton = L10n.tr("Localizable", "Menu_LaneDetection_Button")
  /// Object Detection
  internal static let menuObjectDetectionButton = L10n.tr("Localizable", "Menu_ObjectDetection_Button")
  /// Object Mapping
  internal static let menuObjectMappingButton = L10n.tr("Localizable", "Menu_ObjectMapping_Button")
  /// Segmentation
  internal static let menuSegmentationButton = L10n.tr("Localizable", "Menu_Segmentation_Button")
  /// Sign Detection
  internal static let menuSignDetectionButton = L10n.tr("Localizable", "Menu_SignDetection_Button")
  /// Mapbox DataFlow Integration Example
  internal static let menuTitle = L10n.tr("Localizable", "Menu_Title")
  /// I have read and agree, on behalf of myself and my\ncompany and its affiliates, to be bound by the terms of\nthe Vision SDK Evaluation Agreement.
  internal static let welcomeBody = L10n.tr("Localizable", "Welcome_Body")
  /// Evaluation Agreement
  internal static let welcomeBodyLinkSubstring = L10n.tr("Localizable", "Welcome_Body_LinkSubstring")
  /// Submit
  internal static let welcomeButton = L10n.tr("Localizable", "Welcome_Button")
  /// Welcome to Mapbox DataFlow Integration Example!
  internal static let welcomeTitle = L10n.tr("Localizable", "Welcome_Title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
