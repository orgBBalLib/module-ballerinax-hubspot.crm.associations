# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' as a new enum value for AssociationSpec.associationCategory and AssociationSpecWithLabel.category
- Added doc comments to all public types and their fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered values (breaking for strict enum consumers)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK', reordered values
- Changed 'ApiKeysConfig' record: replaced 'privateAppLegacy' first field ordering and added 'hapikey' field (new required field added to required record)
- Removed API key header injection logic from all resource functions (apiKeyConfig no longer used for header injection in individual methods)
- Reordered resource functions in client (e.g., 'post associations/usage/high-usage-report' moved to top, changing relative ordering)
- BatchResponseLabelsBetweenObjectPair.status enum values reordered
- BatchResponsePublicAssociationMultiWithLabelWithErrors.status enum values reordered
- BatchResponsePublicDefaultAssociation.status enum values reordered
- BatchResponseLabelsBetweenObjectPairWithErrors.status enum values reordered
- BatchResponsePublicAssociationMultiWithLabel.status enum values reordered

### Fixed
- Simplified auth config handling in init() using typed variable instead of type cast
- Removed redundant API key header injection per-method (likely moved to centralized handling or OAuth-only)
- Added missing 'hapikey' API key support in ApiKeysConfig
