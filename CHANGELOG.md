# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new resource function 'put objects/[string fromObjectType]/[string fromObjectId]/associations/default/[string toObjectType]/[string toObjectId]' (reordered in file but functionally present)
- Added new resource function 'get objects/[string objectType]/[string objectId]/associations/[string toObjectType]' with updated query type
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' as a valid association category in AssociationSpec and AssociationSpecWithLabel
- Added extensive documentation comments to all types and fields

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint paths
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig now requires a new mandatory field 'hapikey' in addition to existing fields, breaking existing ApiKeysConfig instantiations
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- AssociationSpec.associationCategory enum values changed: added 'WORK' category
- AssociationSpecWithLabel.category enum values changed: added 'WORK', reordered values
- Removed API key header injection logic (private-app, private-app-legacy headers no longer automatically added from ApiKeysConfig)
- BatchResponseLabelsBetweenObjectPair.status enum values reordered (breaking for strict enum matching)
- PublicFetchAssociationsBatchRequest field 'id' moved/reordered relative to 'after' field

### Fixed
- Simplified auth config handling with explicit type assignment instead of casting
- Removed redundant header map creation for API key injection, relying on HTTP client auth instead
