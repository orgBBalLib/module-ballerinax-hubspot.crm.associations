# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client class
- Added 'WORK' category value to AssociationSpec and AssociationSpecWithLabel enums
- Added comprehensive documentation comments to all types and fields
- Added 'hapikey' field to ApiKeysConfig
- Improved auth config handling using typed variable instead of type cast

### Changed
- Renamed query parameter type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field 'toObjectId' in 'MultiAssociatedObjectWithLabel' changed type from 'int' to 'string'
- Added new required field 'hapikey' to 'ApiKeysConfig' record, breaking existing ApiKeysConfig instantiations
- Enum values reordered in 'AssociationSpecWithLabel.category': added 'WORK' as new value (minor addition but ordering changed)
- Enum values reordered in 'AssociationSpec.associationCategory': added 'WORK' as new value
- API key header injection removed from all resource functions (apiKeyConfig no longer injects private-app/private-app-legacy headers automatically), breaking authentication for API key users
- Resource function ordering changed for 'post associations/usage/high-usage-report' (moved before batch/archive), which may affect some clients

### Fixed
- Simplified auth configuration assignment using typed variable 'authConfig' instead of type cast
- Improved code readability by removing redundant header map construction for API key injection
