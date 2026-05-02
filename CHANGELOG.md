# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' category to AssociationSpec and AssociationSpecWithLabel enums
- Added doc comments to all public types and fields
- Added class-level doc comment to Client class

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint paths
- ApiKeysConfig type changed: removed 'privateAppLegacy' and 'privateApp' fields, replaced with 'hapikey', 'privateApp', and 'privateAppLegacy' (reordered and added new required field 'hapikey')
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- MultiAssociatedObjectWithLabel.toObjectId field type changed from 'int' to 'string'
- AssociationSpecWithLabel.category enum changed: removed 'USER_DEFINED' ordering and added 'WORK' value
- AssociationSpec.associationCategory enum changed: added 'WORK' value
- BatchResponseLabelsBetweenObjectPair.status enum ordering changed (minor but 'CANCELED' vs 'CANCELLED' consistency)
- API key header injection logic removed from all resource methods (apiKeyConfig no longer injected into headers automatically)
- BatchResponsePublicDefaultAssociation.numErrors field added (was missing before), changing response structure

### Fixed
- Simplified auth config handling in init() using typed variable instead of type cast
- Removed redundant header map construction in resource methods
- Fixed MultiAssociatedObjectWithLabel.toObjectId type from int to string for correctness
