# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added 'hapikey' field to ApiKeysConfig for HubSpot API key authentication
- Added 'WORK' category to AssociationSpec and AssociationSpecWithLabel enums
- Added doc comments to all public types and their fields
- Added class-level doc comment 'Basepom for all HubSpot Projects' to Client class

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint routing
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig type changed: added new required field 'hapikey', changing the structure of authentication configuration
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpecWithLabel.category enum changed: removed 'USER_DEFINED' order and added 'WORK' value
- AssociationSpec.associationCategory enum changed: added 'WORK' value
- API key header injection removed from all resource methods (private-app and private-app-legacy headers no longer automatically added)
- Resource method 'post associations/usage/high-usage-report' moved to different position in class (functional reordering with comment change from 'Report' to 'Report high usage')

### Fixed
- Improved auth config handling using typed variable instead of type cast
- Simplified header handling by removing redundant API key header injection logic from individual methods
