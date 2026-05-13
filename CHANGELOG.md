# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added comprehensive documentation comments for all types and fields
- Added new resource method for high usage reporting
- Enhanced type definitions with detailed field descriptions

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com'
- Query parameter type renamed from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- ApiKeysConfig field structure changed - privateAppLegacy and privateApp order changed, hapikey field added
- Field type changed from int to string for toObjectId and fromObjectId in LabelsBetweenObjectPair
- Field type changed from int to string for toObjectId in MultiAssociatedObjectWithLabel
- Removed custom API key header handling logic - now uses standard headers parameter

### Fixed
- Simplified authentication handling by removing custom header manipulation
- Improved code maintainability by removing repetitive header processing logic
- Standardized header handling across all resource methods
