# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig for HubSpot API key authentication
- Added 'WORK' as a new enum value in AssociationSpec.associationCategory and AssociationSpecWithLabel.category
- Added doc comments to all public types and their fields
- Added class-level doc comment to Client class

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint paths
- ApiKeysConfig type changed: removed 'privateAppLegacy' and 'privateApp' fields, replaced with 'hapikey', 'privateApp', and 'privateAppLegacy' (reordered, 'hapikey' added as required field)
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries type renamed to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- AssociationSpec.associationCategory enum values changed: added 'WORK' value ('HUBSPOT_DEFINED'|'INTEGRATOR_DEFINED'|'USER_DEFINED'|'WORK')
- AssociationSpecWithLabel.category enum values changed: added 'WORK' value ('HUBSPOT_DEFINED'|'INTEGRATOR_DEFINED'|'USER_DEFINED'|'WORK')
- BatchResponseLabelsBetweenObjectPair.status enum order changed (minor but also 'CANCELED' vs 'CANCELLED' normalization)
- API key headers (private-app, private-app-legacy) no longer automatically injected into requests - authentication header injection removed from all resource methods
- PublicFetchAssociationsBatchRequest field order changed (id and after swapped, though functionally same)
- Resource method ordering changed for 'post associations/usage/high-usage-report' - now listed first instead of third

### Fixed
- Simplified auth config handling with explicit type assignment instead of casting
- Removed redundant header map construction for API key injection (authentication now handled at HTTP client level)
