# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added hapikey field to ApiKeysConfig
- Added comprehensive documentation comments to most types and fields
- Added new WORK category option to association enums

### Changed
- Query parameter type renamed from GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- Field type changed from int to string for toObjectId in LabelsBetweenObjectPair
- Field type changed from int to string for fromObjectId in LabelsBetweenObjectPair
- Field type changed from int to string for toObjectId in MultiAssociatedObjectWithLabel
- ApiKeysConfig field privateAppLegacy moved from first to last position and new hapikey field added as first field
- Enum value order changed in AssociationSpecWithLabel category field
- Enum value order changed in multiple BatchResponse status fields
- Method comment changes that may indicate behavioral differences (e.g., 'Removes Links Between Objects' to 'Remove associations')

### Fixed
- Simplified authentication handling in client methods by removing manual header manipulation
- Removed redundant API key header processing code
