# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and their fields
- Added class-level documentation comment 'Basepom for all HubSpot Projects' to Client class
- Added 'WORK' as a new valid category in AssociationSpec and AssociationSpecWithLabel enums
- Added 'hapikey' field to ApiKeysConfig

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK' category
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered enum values
- Changed 'ApiKeysConfig' record: added new required field 'hapikey' (breaking for existing implementations)
- Removed API key header injection logic from all resource methods (authentication mechanism changed - apiKeyConfig headers no longer automatically added to requests)
- Reordered enum values in 'BatchResponseLabelsBetweenObjectPair.status' (CANCELED/COMPLETE/PENDING/PROCESSING vs PENDING/PROCESSING/CANCELED/COMPLETE)
- Reordered enum values in 'BatchResponsePublicAssociationMultiWithLabelWithErrors.status'
- Reordered enum values in 'BatchResponsePublicDefaultAssociation.status'
- Reordered enum values in 'BatchResponsePublicAssociationMultiWithLabel.status'
- Reordered enum values in 'BatchResponseLabelsBetweenObjectPairWithErrors.status'
- Reordered enum values in 'AssociationSpec.associationCategory'

### Fixed
- Refactored authentication handling in init() to use typed variable instead of casting
- Simplified header handling by removing redundant apiKeyConfig header injection per method
