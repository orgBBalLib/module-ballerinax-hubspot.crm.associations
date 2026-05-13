# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new resource method 'put objects/[string fromObjectType]/[string fromObjectId]/associations/default/[string toObjectType]/[string toObjectId]' (moved/reordered)
- Added new resource method 'get objects/[string objectType]/[string objectId]/associations/[string toObjectType]' (reordered)
- Added 'hapikey' field to 'ApiKeysConfig'
- Added 'WORK' as a new enum value for association category types
- Added doc comments to all public types and fields
- Added class-level doc comment 'Basepom for all HubSpot Projects'

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered values (order change may break exhaustive pattern matching)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK', reordered values
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum value ordering (reordered: 'CANCELED' now first)
- Changed 'BatchResponsePublicAssociationMultiWithLabelWithErrors.status' enum value ordering
- Changed 'BatchResponsePublicDefaultAssociation.status' enum value ordering
- Changed 'BatchResponseLabelsBetweenObjectPairWithErrors.status' enum value ordering
- Changed 'BatchResponsePublicAssociationMultiWithLabel.status' enum value ordering
- Removed 'ApiKeysConfig.privateAppLegacy' as the only field (now has 'hapikey' added and field order changed - breaking for record construction)
- Added new required field 'hapikey' to 'ApiKeysConfig' record (existing code constructing ApiKeysConfig without 'hapikey' will break)
- API key header injection logic removed from client methods (auth headers no longer added per-request, breaking private-app authentication flow)
- Removed per-request API key header injection for 'private-app' and 'private-app-legacy' headers in all resource methods

### Fixed
- Refactored auth config handling in 'init' to use typed variable instead of type cast, improving type safety
- Simplified header handling by removing redundant API key header injection logic
