# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added comprehensive documentation comments for all types and fields
- Added new resource method for high usage reporting
- Improved type definitions with detailed field descriptions

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com'
- Query parameter type changed from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- Field type changed in MultiAssociatedObjectWithLabel: toObjectId from int to string
- AssociationSpecWithLabel category enum values changed: removed 'WORK', reordered values
- AssociationSpec associationCategory enum values changed: reordered values
- ApiKeysConfig field changes: removed privateAppLegacy as first field, added hapikey field, reordered fields
- Removed API key header injection logic - methods no longer automatically add private-app headers

### Fixed
- Simplified authentication handling in init method
- Removed redundant header manipulation code
- Cleaner HTTP client configuration
