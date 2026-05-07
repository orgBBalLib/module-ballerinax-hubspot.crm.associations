# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' as a new valid value for association category enums in AssociationSpec and AssociationSpecWithLabel
- Added doc comments to all public types and their fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client class
- Simplified auth configuration handling in client init using typed variable

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK' option (order also changed)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK' option (order also changed)
- Changed 'ApiKeysConfig' record: replaced 'privateAppLegacy' as first field with 'hapikey' as new field, and reordered fields
- Removed API key header injection logic from all resource functions (apiKeyConfig no longer used for headers), which may break clients relying on API key authentication via headers
- Reordered resource functions (e.g., 'post associations/usage/high-usage-report' moved before batch operations), which changes method ordering
- Renamed 'BatchResponseLabelsBetweenObjectPair.status' and other status enums reordered (CANCELED before COMPLETE before PENDING before PROCESSING)

### Fixed
- Simplified auth config assignment in init() to avoid unnecessary type casting
- Improved code clarity by removing redundant header map construction for API key injection
