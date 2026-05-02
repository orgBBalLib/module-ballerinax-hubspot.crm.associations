# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and record fields
- Added documentation comment to Client class
- Added 'WORK' category to AssociationSpec and AssociationSpecWithLabel enums
- Added new required 'hapikey' field to ApiKeysConfig
- Reordered resource functions (post associations/usage/high-usage-report now appears first)

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint paths
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- ApiKeysConfig record changed: added new required field 'hapikey', changed field order (may affect record construction)
- AssociationSpec.associationCategory enum values changed: added 'WORK' value (breaking for exhaustive match patterns)
- AssociationSpecWithLabel.category enum values changed: added 'WORK' value (breaking for exhaustive match patterns)
- Removed API key header injection logic (private-app, private-app-legacy headers no longer automatically added from ApiKeysConfig)
- BatchResponseLabelsBetweenObjectPair.status enum value order changed (minor but affects exhaustive matching)
- BatchResponsePublicDefaultAssociation reordered/restructured fields

### Fixed
- Simplified auth configuration handling with explicit type assignment
- Removed redundant header map construction for API key injection
