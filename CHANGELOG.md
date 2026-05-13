# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added GetPageQueries type for query parameters
- Added comprehensive documentation comments for all types and fields
- Added new hapikey field to ApiKeysConfig

### Changed
- Removed GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries type and replaced with GetPageQueries
- Changed method parameter type from int:Signed32 to int for userId in high-usage-report endpoint
- Changed toObjectId field type from int to string in MultiAssociatedObjectWithLabel
- Changed typeId field type from int:Signed32 to int in AssociationSpecWithLabel
- Removed API key header injection logic - methods no longer automatically add private-app headers
- Changed associationTypeId field type from int:Signed32 to int in AssociationSpec
- Reordered enum values in various status and category fields
- Modified ApiKeysConfig to include hapikey field and reorder existing fields

### Fixed
- Simplified authentication handling in client initialization
- Removed redundant header manipulation code
- Cleaned up HTTP request handling by removing manual header construction
