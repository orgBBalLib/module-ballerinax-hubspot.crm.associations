# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' value to AssociationSpec.associationCategory and AssociationSpecWithLabel.category enums
- Added doc comments to all public types and their fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered values
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK', reordered values
- Changed 'ApiKeysConfig' record: added new required field 'hapikey', reordered fields
- Removed API key header injection logic from all resource functions (apiKeyConfig handling removed from individual methods)
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum value order (potential serialization impact)
- Changed 'BatchResponsePublicAssociationMultiWithLabelWithErrors.status' enum value order
- Changed 'BatchResponsePublicDefaultAssociation.status' enum value order
- Changed 'BatchResponsePublicAssociationMultiWithLabel.status' enum value order
- Changed 'BatchResponseLabelsBetweenObjectPairWithErrors.status' enum value order

### Fixed
- Refactored auth config handling in init() to use typed variable instead of type cast
- Simplified header handling by passing headers directly instead of creating intermediate headerValues map
