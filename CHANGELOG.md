# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig for HubSpot API key authentication
- Added 'WORK' category value to AssociationSpec and AssociationSpecWithLabel enums
- Added doc comments to all types and fields in types.bal
- Added class-level doc comment to Client class

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', breaking existing clients relying on the default URL
- ApiKeysConfig type changed: removed 'privateAppLegacy' and 'privateApp' fields, replaced with 'hapikey', 'privateApp', and 'privateAppLegacy' (reordered, 'hapikey' added as new required field)
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries', breaking existing code using the old type name
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string', breaking type compatibility
- AssociationSpec.associationCategory enum changed from 'HUBSPOT_DEFINED|USER_DEFINED|INTEGRATOR_DEFINED' to 'HUBSPOT_DEFINED|INTEGRATOR_DEFINED|USER_DEFINED|WORK', adding new 'WORK' value
- AssociationSpecWithLabel.category enum changed from 'HUBSPOT_DEFINED|USER_DEFINED|INTEGRATOR_DEFINED' to 'HUBSPOT_DEFINED|INTEGRATOR_DEFINED|USER_DEFINED|WORK', adding new 'WORK' value
- API key header injection (private-app, private-app-legacy) removed from all resource functions, breaking authentication for API key users
- BatchResponsePublicDefaultAssociation now includes 'numErrors' and 'errors' fields (previously did not have them), changing response structure
- Resource function ordering and doc comments changed for multiple endpoints

### Fixed
- Simplified auth config handling in init function using typed variable instead of casting
- Removed redundant header map creation for API key injection in resource functions
