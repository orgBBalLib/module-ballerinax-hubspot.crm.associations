# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new resource function 'post associations/usage/high-usage-report/[int:Signed32 userId]' at the beginning
- Added comprehensive documentation comments for all types and fields
- Added new 'hapikey' field to ApiKeysConfig type
- Enhanced type definitions with detailed field descriptions

### Changed
- Removed manual API key header injection logic - methods no longer automatically add 'private-app' and 'private-app-legacy' headers
- Changed query parameter type name from 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Modified ApiKeysConfig type to include new required 'hapikey' field
- Changed field types in multiple records from int to string (toObjectId, fromObjectId in LabelsBetweenObjectPair and toObjectId in MultiAssociatedObjectWithLabel)
- Reordered resource function definitions which may affect clients relying on specific ordering

### Fixed
- Simplified authentication configuration logic in init() method
- Removed redundant header manipulation code in resource methods
- Fixed inconsistent return type documentation in comments
