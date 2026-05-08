# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added class-level documentation comment 'Basepom for all HubSpot Projects'
- Added extensive documentation comments to all types and fields
- Added 'WORK' as a new valid category in AssociationSpec and AssociationSpecWithLabel enums
- Added new required 'hapikey' field to ApiKeysConfig
- Added 'errors' optional field to BatchResponsePublicDefaultAssociation
- Added documentation to BatchInputPublicFetchAssociationsBatchRequest

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK' category
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered values
- Changed 'ApiKeysConfig' record: added new required field 'hapikey' (breaking for existing implementations)
- Removed API key header injection logic from all resource methods (authentication behavior changed - no longer automatically adds private-app headers)
- Reordered resource methods (post associations/usage/high-usage-report now appears before batch/archive)
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum ordering (may affect pattern matching)
- Changed 'BatchResponsePublicDefaultAssociation' - moved fields around and added 'errors' field

### Fixed
- Improved auth config handling by using typed variable instead of type cast
- Simplified header handling by removing redundant API key header injection per-method
