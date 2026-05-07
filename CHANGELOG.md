# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' category value to AssociationSpec and AssociationSpecWithLabel enums
- Added documentation comments to all public types and fields
- Added class-level documentation comment for Client class
- Improved auth config handling using typed variable instead of type cast

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK' value (breaking for exhaustive match patterns)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK' value (breaking for exhaustive match patterns)
- Changed 'ApiKeysConfig' record: added new required field 'hapikey', changed field order
- Removed API key header injection logic from all resource functions (private-app and private-app-legacy headers no longer automatically added)
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum order (CANCELED|COMPLETE|PENDING|PROCESSING vs PENDING|PROCESSING|CANCELED|COMPLETE) - functionally same but type changed
- Changed 'BatchResponsePublicAssociationMultiWithLabelWithErrors.status' enum order
- Changed 'BatchResponsePublicDefaultAssociation.status' enum order
- Changed 'BatchResponsePublicAssociationMultiWithLabel.status' enum order
- Changed 'BatchResponseLabelsBetweenObjectPairWithErrors.status' enum order

### Fixed
- Simplified auth configuration assignment by using typed variable instead of type cast
- Removed redundant header map construction for API key injection (now relies on http client auth config)
