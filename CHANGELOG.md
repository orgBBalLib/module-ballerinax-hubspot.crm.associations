# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client class
- Added 'hapikey' field to ApiKeysConfig
- Added comprehensive field-level documentation comments to all public types
- Added 'WORK' category value to AssociationSpec and AssociationSpecWithLabel enums
- Added numErrors field to BatchResponsePublicDefaultAssociation
- Added errors field to BatchResponsePublicDefaultAssociation

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- Removed 'privateAppLegacy' as first field and added 'hapikey' field in 'ApiKeysConfig' (field order and content changed, breaking existing configurations)
- API key header injection removed from all resource methods - authentication via API keys no longer injected into headers automatically, breaking private-app authentication flow
- AssociationSpec.associationCategory enum extended with 'WORK' value (potentially breaking for exhaustive pattern matching)
- AssociationSpecWithLabel.category enum extended with 'WORK' value and order changed
- Status enum values reordered in BatchResponseLabelsBetweenObjectPair, BatchResponsePublicAssociationMultiWithLabelWithErrors, BatchResponsePublicDefaultAssociation, BatchResponsePublicAssociationMultiWithLabel, BatchResponseLabelsBetweenObjectPairWithErrors

### Fixed
- Refactored auth config handling to use typed variable instead of type cast for cleaner code
- Simplified header handling by removing redundant API key header injection logic from individual resource methods
