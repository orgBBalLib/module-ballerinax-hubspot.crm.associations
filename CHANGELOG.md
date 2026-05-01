# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' category to AssociationSpec and AssociationSpecWithLabel enums
- Added doc comments to all public types and their fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint routing
- ApiKeysConfig field 'privateAppLegacy' removed and replaced with 'hapikey' as first field (field ordering and content changed)
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpecWithLabel.category enum values changed: added 'WORK', reordered values
- AssociationSpec.associationCategory enum values changed: added 'WORK', reordered values
- GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries type renamed to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- BatchResponseLabelsBetweenObjectPair.status enum values reordered (CANCELED before COMPLETE now)
- Resource method ordering changed for 'post associations/usage/high-usage-report' (moved to first position)
- API key header injection logic removed from all resource methods (apiKeyConfig headers no longer automatically added)
- BatchResponsePublicDefaultAssociation reordered fields and added errors field

### Fixed
- Simplified auth config handling in init function using typed variable instead of type cast
- Removed redundant header map construction for API key injection in all resource methods
