# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added doc comment 'Basepom for all HubSpot Projects' to Client class
- Added comprehensive documentation comments to all types and fields
- AssociationSpec and AssociationSpecWithLabel now support 'WORK' category
- ApiKeysConfig now includes 'hapikey' field for HubSpot API key authentication

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', breaking existing deployments relying on the default URL
- ApiKeysConfig type changed: added new required field 'hapikey', making existing ApiKeysConfig instances incomplete/invalid
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpecWithLabel.category enum changed: added 'WORK' value (breaking for exhaustive pattern matching)
- AssociationSpec.associationCategory enum changed: added 'WORK' value (breaking for exhaustive pattern matching)
- GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries type renamed to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- Resource function 'post associations/usage/high-usage-report/{userId}' moved in ordering (minor but signature-related context changes)
- API key header injection removed from all resource functions (previously injected 'private-app' and 'private-app-legacy' headers automatically, now relies solely on OAuth/bearer token config)
- BatchResponseLabelsBetweenObjectPair.status enum order changed (CANCELED before COMPLETE before PENDING before PROCESSING)
- PublicFetchAssociationsBatchRequest field 'id' and 'after' order swapped (structural change)

### Fixed
- Improved type safety for auth config handling (explicit type assignment instead of casting)
- Simplified header handling by removing redundant API key header injection logic from individual resource functions
