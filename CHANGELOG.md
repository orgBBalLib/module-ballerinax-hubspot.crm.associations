# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new resource method for high usage reporting
- Added comprehensive documentation comments for all types and fields
- Added new 'WORK' category option for association types
- Added hapikey field to ApiKeysConfig for additional authentication method

### Changed
- Removed manual API key header injection logic - methods no longer automatically add private-app and private-app-legacy headers
- Changed query parameter type name from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- Modified field types in MultiAssociatedObjectWithLabel: toObjectId changed from int to string
- Modified field types in LabelsBetweenObjectPair: toObjectId and fromObjectId changed from int to string
- Changed AssociationSpecWithLabel.category enum values order and added new 'WORK' value
- Changed AssociationSpec.associationCategory enum values order and added new 'WORK' value
- Modified ApiKeysConfig record structure - added hapikey field and reordered existing fields

### Fixed
- Simplified authentication handling in client initialization
- Removed redundant header manipulation code in resource methods
- Improved type safety by using explicit union types for auth configuration
