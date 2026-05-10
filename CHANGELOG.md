# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'WORK' as a new enum value for AssociationSpec.associationCategory
- Added 'WORK' as a new enum value for AssociationSpecWithLabel.category
- Added 'hapikey' field to ApiKeysConfig for HubSpot API key authentication
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client
- Added comprehensive field-level documentation comments to all types
- Added new required field 'privateAppLegacy' to ApiKeysConfig (was already present but ordering changed)

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- AssociationSpec.associationCategory enum values reordered and 'WORK' category added (existing code using positional matching may break)
- AssociationSpecWithLabel.category enum values reordered and 'WORK' category added
- BatchResponseLabelsBetweenObjectPair.status enum values reordered
- BatchResponsePublicAssociationMultiWithLabelWithErrors.status enum values reordered
- BatchResponsePublicDefaultAssociation.status enum values reordered
- BatchResponseLabelsBetweenObjectPairWithErrors.status enum values reordered
- BatchResponsePublicAssociationMultiWithLabel.status enum values reordered
- API key header handling removed from individual resource functions (apiKeyConfig headers no longer injected per-request, breaking authentication for API key users)
- Resource function ordering changed (post associations/usage/high-usage-report moved before batch operations)

### Fixed
- Refactored auth config handling in init() to use typed variable instead of type cast
- Simplified header passing by using headers directly instead of constructing intermediate headerValues map
