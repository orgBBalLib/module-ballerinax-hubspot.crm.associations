# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New 'hapikey' field added to ApiKeysConfig
- Added 'WORK' category to AssociationSpec and AssociationSpecWithLabel enums
- Added documentation comments to all public types and their fields
- Added class-level documentation comment to Client class

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', which changes all relative resource paths
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig field 'privateAppLegacy' reordered and new field 'hapikey' added (field order change may break named argument construction)
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpecWithLabel.category enum values changed: added 'WORK' value
- AssociationSpec.associationCategory enum values changed: added 'WORK' value
- BatchResponseLabelsBetweenObjectPair.status enum value ordering changed
- Removed API key header injection logic from all resource methods (apiKeyConfig headers no longer automatically added)
- BatchResponsePublicDefaultAssociation now includes 'numErrors' and 'errors' fields that were not present before (structural change)

### Fixed
- Simplified auth config handling using typed variable instead of casting
- Removed redundant header map construction for API key injection in resource methods
