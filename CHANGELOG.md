# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and their fields
- Added documentation comment to Client class ('Basepom for all HubSpot Projects')
- Added 'hapikey' field to ApiKeysConfig for HubSpot API key support
- Improved auth config handling using typed variable instead of type cast

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed field 'toObjectId' in 'MultiAssociatedObjectWithLabel' from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- Changed enum values order/added 'WORK' to 'AssociationSpecWithLabel.category' (added new enum value 'WORK' which may break exhaustive pattern matching)
- Changed enum values order/added 'WORK' to 'AssociationSpec.associationCategory' (added new enum value 'WORK' which may break exhaustive pattern matching)
- Removed API key header injection logic from all resource methods (apiKeyConfig no longer used for headers in requests - authentication mechanism changed)
- Resource methods no longer automatically inject 'private-app' and 'private-app-legacy' headers from ApiKeysConfig

### Fixed
- Simplified auth configuration assignment using typed variable instead of explicit cast
- Reordered resource methods for better logical grouping
