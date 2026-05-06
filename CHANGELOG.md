# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig
- Added 'WORK' enum value to AssociationSpec.associationCategory and AssociationSpecWithLabel.category
- Added doc comments to all public types and fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed 'MultiAssociatedObjectWithLabel.toObjectId' field type from 'int' to 'string'
- Changed 'AssociationSpecWithLabel.category' enum values: added 'WORK', reordered values (breaking for strict enum matching)
- Changed 'AssociationSpec.associationCategory' enum values: added 'WORK', reordered values
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum value order (reordered from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING')
- Removed 'ApiKeysConfig.privateAppLegacy' as standalone field and added 'hapikey' field (changed ApiKeysConfig structure)
- Removed API key header injection logic from all resource methods (apiKeyConfig headers no longer automatically added)
- Changed 'PublicFetchAssociationsBatchRequest' field order (id and after swapped)
- BatchResponsePublicDefaultAssociation.status enum reordered
- BatchResponsePublicAssociationMultiWithLabelWithErrors.status enum reordered
- BatchResponseLabelsBetweenObjectPairWithErrors.status enum reordered

### Fixed
- Refactored auth config handling in init() to use typed variable instead of type cast
- Improved code clarity by removing redundant header map construction in resource methods
