# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added comment documentation for Basepom for all HubSpot Projects
- Added comprehensive documentation comments for all types and fields
- Improved type definitions with detailed field descriptions
- Enhanced error handling and response documentation

### Changed
- Query parameter type changed from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- Field type changed from int to string for toObjectId and fromObjectId in LabelsBetweenObjectPair
- Field type changed from int to string for toObjectId in MultiAssociatedObjectWithLabel
- Field name changed from string? label? to string label? in AssociationSpecWithLabel
- Enum values reordered in multiple status fields
- ApiKeysConfig field privateAppLegacy moved and hapikey field added
- Removed manual API key header injection logic - authentication handling changed significantly

### Fixed
- Simplified authentication configuration handling
- Removed redundant header manipulation code
- Cleaner HTTP client configuration
- Improved resource path handling
