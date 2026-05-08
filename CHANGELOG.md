# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client class
- Added comprehensive field-level documentation to all public types
- Added 'WORK' category value to AssociationSpec and AssociationSpecWithLabel enums
- Added 'hapikey' field to ApiKeysConfig

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- AssociationSpec.associationCategory enum changed from 'HUBSPOT_DEFINED|USER_DEFINED|INTEGRATOR_DEFINED' to 'HUBSPOT_DEFINED|INTEGRATOR_DEFINED|USER_DEFINED|WORK' (added 'WORK' value)
- AssociationSpecWithLabel.category enum changed from 'HUBSPOT_DEFINED|USER_DEFINED|INTEGRATOR_DEFINED' to 'HUBSPOT_DEFINED|INTEGRATOR_DEFINED|USER_DEFINED|WORK' (added 'WORK' value)
- Removed API key header injection logic from all resource functions (apiKeyConfig headers no longer automatically added)
- BatchResponseLabelsBetweenObjectPair.status enum order changed (minor but 'CANCELLED' vs 'CANCELED' inconsistency resolved)
- ApiKeysConfig field ordering changed with new required 'hapikey' field added

### Fixed
- Improved auth config handling by using typed variable instead of casting
- Refactored header handling to pass headers directly instead of merging with API key headers
