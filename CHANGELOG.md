# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and their fields
- Added documentation comment to the Client class ('Basepom for all HubSpot Projects')
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' category value to AssociationSpec and AssociationSpecWithLabel enums
- Added 'numErrors' and 'errors' optional fields to BatchResponsePublicDefaultAssociation

### Changed
- Renamed query parameter type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK' value (breaking for exhaustive pattern matching)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK' value (breaking for exhaustive pattern matching)
- Changed 'ApiKeysConfig' record: added new required field 'hapikey', reordered fields (structural change)
- Removed API key header injection logic from all resource methods (authentication behavior changed - private-app and private-app-legacy headers no longer automatically added)
- Changed 'BatchResponsePublicDefaultAssociation' record: added 'numErrors' and 'errors' fields (minor addition but existing code relying on exact structure may be affected)
- Changed status enum ordering in multiple types: 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING' (breaking for positional/ordered matching)

### Fixed
- Simplified auth config handling in client init by removing redundant type cast
- Improved code readability by removing redundant header manipulation logic for API key injection
- Updated resource method doc comments to be more concise and accurate
