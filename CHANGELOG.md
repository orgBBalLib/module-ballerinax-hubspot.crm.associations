# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new resource method: post associations/usage/high-usage-report/[int:Signed32 userId]
- Added comprehensive documentation comments for all types and fields
- Added hapikey field to ApiKeysConfig for HubSpot API key authentication

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com'
- Field type changed in MultiAssociatedObjectWithLabel: toObjectId from int to string
- Query parameter type renamed from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- ApiKeysConfig structure changed: added hapikey field and reordered fields
- AssociationSpecWithLabel category enum values changed: removed some values and added 'WORK'
- AssociationSpec associationCategory enum values changed: added 'WORK' option
- Batch response status enum value changed from 'CANCELED' to different ordering
- Removed API key header injection logic - authentication mechanism changed

### Fixed
- Simplified authentication logic in init method with better type handling
- Removed redundant header manipulation code in resource methods
- Improved variable naming in auth configuration handling
