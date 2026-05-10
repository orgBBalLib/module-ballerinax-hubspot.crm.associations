# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' category to AssociationSpec and AssociationSpecWithLabel enums
- Added doc comments to all public types and fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client class
- BatchResponsePublicDefaultAssociation now includes 'numErrors' and 'errors' fields (previously missing)

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK' value (breaking for consumers relying on exhaustive matching)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK' value
- Changed 'ApiKeysConfig' record: renamed/reordered fields - added 'hapikey' field, changed field ordering (privateAppLegacy, privateApp order changed)
- Removed API key header injection logic from all resource functions (apiKeyConfig is no longer used to set request headers), breaking authentication for API key users
- Reordered enum values in 'BatchResponseLabelsBetweenObjectPair.status', 'BatchResponsePublicAssociationMultiWithLabelWithErrors.status', 'BatchResponsePublicDefaultAssociation.status', 'AssociationSpec.associationCategory', 'AssociationSpecWithLabel.category' - CANCELED now before COMPLETE

### Fixed
- Simplified auth config handling in client init using typed variable instead of type cast
- Removed redundant API key header injection per-request (authentication now handled at HTTP client level)
