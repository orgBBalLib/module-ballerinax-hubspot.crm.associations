# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New 'WORK' category added to AssociationSpecWithLabel and AssociationSpec enums
- Added 'hapikey' field to ApiKeysConfig
- Added doc comments to Client class, all types, and all fields
- BatchResponsePublicDefaultAssociation now includes 'numErrors' and 'errors' fields

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', breaking existing API path routing
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig now requires additional field 'hapikey' (previously only had 'privateAppLegacy' and 'privateApp'), making existing ApiKeysConfig initializations incomplete
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- Enum values reordered in 'AssociationSpecWithLabel.category': added new value 'WORK' to the union type
- Enum values reordered in 'AssociationSpec.associationCategory': added new value 'WORK' to the union type
- Removed API key header injection logic from all resource methods (private-app and private-app-legacy headers no longer automatically added)
- Resource method ordering changed for 'post associations/usage/high-usage-report' relative to other methods (functional reordering)

### Fixed
- Simplified auth config handling with explicit type assignment instead of casting
- Removed redundant header map construction for API key injection in resource methods
