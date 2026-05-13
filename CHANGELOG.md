# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and their fields
- Added documentation comment to Client class
- ApiKeysConfig now includes 'hapikey' field for HubSpot API key authentication

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com'
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- ApiKeysConfig record changed: added new required field 'hapikey', making existing implementations potentially incompatible
- Removed API key header injection logic from all resource methods (apiKeyConfig no longer used for header injection)
- AssociationSpec.associationCategory enum values changed: added 'WORK' value (order also changed)
- AssociationSpecWithLabel.category enum values changed: added 'WORK' value (order also changed)
- BatchResponseLabelsBetweenObjectPair.status enum order changed
- BatchResponsePublicAssociationMultiWithLabelWithErrors.status enum order changed
- BatchResponsePublicDefaultAssociation.status enum order changed
- BatchResponseLabelsBetweenObjectPairWithErrors.status enum order changed
- BatchResponsePublicAssociationMultiWithLabel.status enum order changed

### Fixed
- Simplified auth configuration handling in init function for cleaner code
- Removed redundant header manipulation code from resource methods
