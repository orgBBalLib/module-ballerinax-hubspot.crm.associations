# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new resource method: post associations/usage/high-usage-report/[int:Signed32 userId]
- Added new resource method: put objects/[string fromObjectType]/[string fromObjectId]/associations/default/[string toObjectType]/[string toObjectId]
- Added comprehensive documentation comments for all types and fields
- Added new enum value 'WORK' to association category types

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com'
- Field type changed in MultiAssociatedObjectWithLabel: toObjectId from int to string
- Query parameter type renamed from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- ApiKeysConfig field structure changed: removed privateAppLegacy as first field, added hapikey field, reordered fields
- Enum value ordering changed in multiple types (AssociationSpecWithLabel.category, batch response status fields)
- Removed API key header injection logic - methods no longer automatically add private-app headers

### Fixed
- Simplified authentication handling in init method with better type inference
- Removed redundant header manipulation code in resource methods
- Improved method documentation with clearer descriptions
