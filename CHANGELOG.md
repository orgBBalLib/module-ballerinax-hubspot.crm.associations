# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' value to association category enums
- Added doc comments to all public types and fields
- BatchResponsePublicDefaultAssociation now includes error handling fields (numErrors, errors)

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com'
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig field 'privateAppLegacy' order changed and new field 'hapikey' added (field ordering change in record literal may break existing code)
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpecWithLabel.category enum values changed: added 'WORK', reordered values
- AssociationSpec.associationCategory enum values changed: added 'WORK', reordered values
- BatchResponseLabelsBetweenObjectPair.status enum values reordered
- BatchResponsePublicDefaultAssociation now includes 'numErrors' and 'errors' fields (was missing before - structural change)
- Removed API key header injection logic (private-app, private-app-legacy headers no longer automatically added from ApiKeysConfig)
- ApiKeysConfig now includes new required field 'hapikey' making existing configs incomplete

### Fixed
- Improved auth config handling with explicit type assignment instead of casting
- MultiAssociatedObjectWithLabel.toObjectId changed from int to string for better compatibility
