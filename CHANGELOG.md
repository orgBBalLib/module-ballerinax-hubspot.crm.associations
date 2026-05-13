# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new field 'hapikey' to ApiKeysConfig
- Added 'WORK' as a new valid category value in AssociationSpec and AssociationSpecWithLabel
- Added doc comments to all public types and their fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', breaking existing API path routing
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig field 'privateAppLegacy' reordered and new field 'hapikey' added (field ordering change may break record construction)
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpecWithLabel.category enum values changed: removed 'USER_DEFINED' ordering and added 'WORK' value
- AssociationSpec.associationCategory enum values changed: added 'WORK' value
- BatchResponseLabelsBetweenObjectPair.status enum value changed from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING' (ordering change, also semantically different if used as union type)
- Removed API key header injection logic from all resource methods (privateApp and privateAppLegacy headers no longer automatically added)
- Resource methods no longer automatically inject API key headers, requiring callers to pass them manually

### Fixed
- Improved auth config handling with explicit type assignment instead of casting
- Simplified header passing by using headers directly instead of creating intermediate headerValues map
