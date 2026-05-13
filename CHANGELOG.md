# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' as a valid category value in AssociationSpecWithLabel and AssociationSpec
- Added extensive documentation/comments to all public types and fields
- Added class-level documentation comment 'Basepom for all HubSpot Projects'

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK' value (breaking for consumers relying on exhaustive matching)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK' value
- Changed 'ApiKeysConfig' record: replaced 'privateAppLegacy' and added 'hapikey' field, reordered fields (structural change)
- Removed API key header injection logic from all resource methods (authentication mechanism changed - apiKeyConfig no longer injected into headers automatically)
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum order (CANCELED before COMPLETE now, though functionally same values)
- Renamed resource function comment/doc from 'List Associations of an Object by Type' - minor but the query type rename is breaking

### Fixed
- Simplified auth config handling in init() by using typed variable instead of type cast
- Removed redundant header map construction for API key injection (authentication now handled differently)
