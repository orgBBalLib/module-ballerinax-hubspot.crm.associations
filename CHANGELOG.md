# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New 'hapikey' field added to ApiKeysConfig
- Added 'WORK' as a valid category in AssociationSpec and AssociationSpecWithLabel enums
- Added class-level documentation comment 'Basepom for all HubSpot Projects'
- Extensive documentation comments added to all types and fields
- BatchResponsePublicDefaultAssociation now includes 'numErrors' and 'errors' fields

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- Removed API key header injection logic from client methods (authentication behavior changed - private-app and private-app-legacy headers no longer automatically added)
- AssociationSpec.associationCategory enum values changed: added 'WORK' category
- AssociationSpecWithLabel.category enum values changed: added 'WORK' category
- BatchResponseLabelsBetweenObjectPair.status enum value order changed (minor but 'CANCELLED' note in doc vs 'CANCELED' in code)
- ApiKeysConfig field order changed with new required 'hapikey' field added

### Fixed
- Simplified auth config handling in client init using typed variable instead of type cast
- Removed redundant header map construction for API key injection in all resource methods
- Reordered resource functions for better logical grouping
