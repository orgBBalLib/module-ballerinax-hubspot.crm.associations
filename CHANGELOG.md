# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added doc comments to all public types and their fields
- Added doc comments to Client class
- Added new resource function 'post associations/usage/high-usage-report/{userId}' (reordered, not new)
- Added new resource function 'put objects/{fromObjectType}/{fromObjectId}/associations/default/{toObjectType}/{toObjectId}'
- Added new resource function 'get objects/{objectType}/{objectId}/associations/{toObjectType}'
- AssociationSpec and AssociationSpecWithLabel now support 'WORK' category value
- BatchResponsePublicDefaultAssociation now includes error details fields

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing users who must now provide this field)
- AssociationSpec.associationCategory enum values reordered and 'WORK' added (order change may affect pattern matching)
- AssociationSpecWithLabel.category enum values reordered and 'WORK' added
- BatchResponseLabelsBetweenObjectPair.status enum values reordered
- BatchResponsePublicAssociationMultiWithLabelWithErrors.status enum values reordered
- BatchResponsePublicDefaultAssociation now includes 'numErrors' and 'errors' fields (structural change)
- Removed API key header injection logic from all resource functions (authentication behavior change - private-app and private-app-legacy headers no longer automatically added)
- ApiKeysConfig field 'privateAppLegacy' was previously the only required field, now 'hapikey' and 'privateApp' are also required

### Fixed
- Simplified auth config handling in init() to avoid unnecessary type casting
- Improved code clarity by using typed variable for authConfig
