# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added documentation comments to all public types and fields
- Added class-level documentation comment 'Basepom for all HubSpot Projects' to Client class
- Added 'hapikey' field to ApiKeysConfig for additional authentication option
- Added 'WORK' as a new valid enum value for association category in AssociationSpec and AssociationSpecWithLabel

### Changed
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Changed field type 'toObjectId' in 'MultiAssociatedObjectWithLabel' from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record (breaking for existing implementations)
- Changed enum values order/added 'WORK' category to 'AssociationSpec.associationCategory' (added new enum value 'WORK')
- Changed enum values order/added 'WORK' category to 'AssociationSpecWithLabel.category' (added new enum value 'WORK')
- Removed API key header injection logic from all resource methods (apiKeyConfig headers no longer automatically added)
- Changed 'BatchResponseLabelsBetweenObjectPair.status' enum value from 'PENDING|PROCESSING|CANCELED|COMPLETE' ordering change (minor but 'CANCELED' spelling confirmed)
- Renamed resource function comment/doc from 'List Associations of an Object by Type' but more critically the query parameter type reference changed breaking existing callers using the old type name

### Fixed
- Simplified auth configuration logic in init() by using typed variable instead of type casting
- Removed redundant API key header injection from individual resource methods (likely moved to a centralized mechanism or OAuth-only)
- Added missing 'numErrors' field to 'BatchResponsePublicDefaultAssociation'
