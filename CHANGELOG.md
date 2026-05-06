# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and fields
- Added documentation comment to Client class ('Basepom for all HubSpot Projects')
- Added 'hapikey' field to ApiKeysConfig for additional authentication option
- Improved auth config handling using typed variable instead of type cast

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed field type 'toObjectId' in 'MultiAssociatedObjectWithLabel' from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- Removed API key header injection logic from all resource functions (authentication mechanism changed - apiKeyConfig no longer automatically injected into headers)
- Changed enum values order and added 'WORK' category to 'AssociationSpec.associationCategory' (new enum value 'WORK' added)
- Changed enum values order and added 'WORK' category to 'AssociationSpecWithLabel.category' (new enum value 'WORK' added)
- Reordered enum values in 'BatchResponseLabelsBetweenObjectPair.status' from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING'
- Reordered enum values in multiple status fields across response types

### Fixed
- Simplified auth configuration logic using typed variable 'authConfig' instead of repeated type casts
- Cleaned up header handling by removing redundant API key injection code from individual resource functions
