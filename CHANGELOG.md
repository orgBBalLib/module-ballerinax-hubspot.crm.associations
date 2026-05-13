# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- ApiKeysConfig now includes 'hapikey' field for HubSpot API key authentication
- AssociationSpec and AssociationSpecWithLabel now support 'WORK' category
- Added doc comments to all public types and fields
- Client class now has a doc comment 'Basepom for all HubSpot Projects'

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', breaking existing deployments relying on the default URL
- ApiKeysConfig type changed: removed 'privateAppLegacy' and 'privateApp' fields, replaced with 'hapikey', 'privateApp', and 'privateAppLegacy' (reordered, 'hapikey' added as required field) - existing code using ApiKeysConfig without 'hapikey' will break
- MultiAssociatedObjectWithLabel.toObjectId field type changed from 'int' to 'string'
- AssociationSpec.associationCategory enum changed from 'HUBSPOT_DEFINED|USER_DEFINED|INTEGRATOR_DEFINED' to 'HUBSPOT_DEFINED|INTEGRATOR_DEFINED|USER_DEFINED|WORK' (added 'WORK' value)
- AssociationSpecWithLabel.category enum changed from 'HUBSPOT_DEFINED|USER_DEFINED|INTEGRATOR_DEFINED' to 'HUBSPOT_DEFINED|INTEGRATOR_DEFINED|USER_DEFINED|WORK' (added 'WORK' value)
- GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries type renamed to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- API key header injection (private-app, private-app-legacy) removed from all resource methods, breaking authentication for API key users
- BatchResponseLabelsBetweenObjectPair.status enum order changed (minor but could affect pattern matching)
- BatchResponsePublicAssociationMultiWithLabelWithErrors.status enum order changed

### Fixed
- Improved type safety in auth config handling by using explicit typed variable instead of casting
- MultiAssociatedObjectWithLabel.toObjectId corrected from int to string type
