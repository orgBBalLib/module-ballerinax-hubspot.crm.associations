# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new resource method for high usage reporting
- Enhanced type documentation with comprehensive field descriptions
- Added hapikey field to ApiKeysConfig for additional authentication method

### Changed
- Removed manual API key header injection logic - methods no longer automatically add 'private-app' and 'private-app-legacy' headers
- Changed field types in MultiAssociatedObjectWithLabel: toObjectId changed from int to string
- Changed field types in LabelsBetweenObjectPair: toObjectId and fromObjectId changed from int to string
- Renamed query parameter type from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- Modified ApiKeysConfig record structure - added hapikey field and reordered fields
- Changed AssociationSpecWithLabel.label field from string? to string (removed nullable)
- Updated enum values in AssociationSpecWithLabel.category and AssociationSpec.associationCategory - added 'WORK' option and reordered values

### Fixed
- Simplified authentication header handling by removing redundant manual header injection
- Improved type consistency by standardizing object ID fields as strings
- Updated method documentation for better clarity
