# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and fields
- Added documentation comment to Client class ('Basepom for all HubSpot Projects')
- Improved auth config handling with explicit type variable instead of casting
- Added 'hapikey' field to ApiKeysConfig for additional authentication option

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed field 'toObjectId' in 'MultiAssociatedObjectWithLabel' from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- Changed enum values order/added 'WORK' to 'AssociationSpecWithLabel.category' (added 'WORK' value which changes the union type)
- Changed enum values order/added 'WORK' to 'AssociationSpec.associationCategory' (added 'WORK' value which changes the union type)
- Removed API key header injection logic from all resource methods (apiKeyConfig headers no longer automatically added to requests)
- Resource method ordering changed (post associations/usage/high-usage-report now appears before batch/archive instead of after batch/associate/default)

### Fixed
- Simplified auth configuration by removing redundant type cast
- Improved code clarity by using typed variable for authConfig
