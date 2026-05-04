# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'WORK' category to AssociationSpec and AssociationSpecWithLabel enums
- Added new required 'hapikey' field to ApiKeysConfig
- Added doc comments to all public types and their fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint routing
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig record changed: added new required field 'hapikey', reordered fields (privateApp, privateAppLegacy order changed)
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpec.associationCategory enum values changed: added 'WORK' value
- AssociationSpecWithLabel.category enum values changed: added 'WORK' value, reordered values
- BatchResponseLabelsBetweenObjectPair.status enum values reordered
- Removed API key header injection logic from all resource functions (private-app and private-app-legacy headers no longer automatically added)
- PublicFetchAssociationsBatchRequest field order changed (after moved before id)

### Fixed
- Simplified auth config handling in init function for better type safety
- Removed redundant header map construction in resource functions
