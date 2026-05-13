# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'WORK' as a new valid category value in AssociationSpec and AssociationSpecWithLabel
- Added 'hapikey' field to ApiKeysConfig
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client
- Added extensive inline documentation/comments to all types and fields
- Added 'numErrors' field to 'BatchResponsePublicDefaultAssociation'

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed field type 'toObjectId' in 'MultiAssociatedObjectWithLabel' from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- Changed enum values ordering/added 'WORK' category to 'AssociationSpecWithLabel.category' (added 'WORK' as new valid value, changed from 'HUBSPOT_DEFINED|USER_DEFINED|INTEGRATOR_DEFINED' to 'HUBSPOT_DEFINED|INTEGRATOR_DEFINED|USER_DEFINED|WORK')
- Changed enum values ordering/added 'WORK' to 'AssociationSpec.associationCategory' (added 'WORK' as new valid value)
- Removed API key header injection logic from all resource functions (private-app and private-app-legacy headers no longer automatically added)
- Changed status enum ordering in 'BatchResponseLabelsBetweenObjectPair' from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING'
- Changed status enum ordering in 'BatchResponsePublicAssociationMultiWithLabelWithErrors' from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING'
- Changed status enum ordering in 'BatchResponsePublicDefaultAssociation' from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING'
- Changed status enum ordering in 'BatchResponsePublicAssociationMultiWithLabel' from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING'
- Changed status enum ordering in 'BatchResponseLabelsBetweenObjectPairWithErrors' from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING'

### Fixed
- Refactored auth config handling to use typed variable instead of type cast for cleaner code
- Improved header passing by using headers directly instead of constructing new header maps
