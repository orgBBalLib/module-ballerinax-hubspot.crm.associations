# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and their fields
- Added documentation comment to Client class ('Basepom for all HubSpot Projects')
- Added 'WORK' as a new valid category in 'AssociationSpec.associationCategory' and 'AssociationSpecWithLabel.category'
- Added new required 'hapikey' field to 'ApiKeysConfig'

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered values (order change may affect pattern matching)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK', reordered values
- Changed 'ApiKeysConfig' record: added new required field 'hapikey' (breaking for existing implementations)
- Removed API key header injection logic from all resource functions (private-app and private-app-legacy headers no longer automatically added)
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum value ordering (reordered)
- Changed 'BatchResponsePublicAssociationMultiWithLabelWithErrors.status' enum value ordering
- Changed 'BatchResponsePublicDefaultAssociation.status' enum value ordering
- Changed 'BatchResponseLabelsBetweenObjectPairWithErrors.status' enum value ordering

### Fixed
- Improved auth config handling by using typed variable instead of type cast
- Simplified header handling by passing headers directly instead of merging with API key headers
