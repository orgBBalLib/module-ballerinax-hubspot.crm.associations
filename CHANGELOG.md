# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added doc comments to all public types and fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client
- Improved auth config handling in init() using typed variable instead of type cast

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered values
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK', reordered values
- Changed 'ApiKeysConfig' record: removed 'privateAppLegacy' as first field, added 'hapikey' field, reordered fields
- Removed API key header injection logic from all resource functions (apiKeyConfig handling removed from individual methods)
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum value order (minor but potentially breaking for pattern matching)
- Changed 'BatchResponsePublicAssociationMultiWithLabelWithErrors.status' enum value order
- Changed 'BatchResponsePublicDefaultAssociation.status' enum value order
- Changed 'BatchResponsePublicAssociationMultiWithLabel.status' enum value order
- Changed 'BatchResponseLabelsBetweenObjectPairWithErrors.status' enum value order

### Fixed
- Simplified auth handling in init() by using typed variable instead of type cast
- Removed redundant API key header injection from individual resource methods (now handled differently)
