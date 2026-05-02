# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New resource function 'post associations/usage/high-usage-report' moved/reordered in client
- New resource function 'put objects/{fromObjectType}/{fromObjectId}/associations/default/{toObjectType}/{toObjectId}' added
- New resource function 'get objects/{objectType}/{objectId}/associations/{toObjectType}' retained with updated query type name
- Added 'hapikey' field to ApiKeysConfig
- Added doc comments to all public types and fields

### Changed
- Default serviceUrl changed from 'https://api.hubapi.com/crm/v4' to 'https://api.hubapi.com', affecting all API endpoint paths
- Renamed query type 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- ApiKeysConfig record changed: added new required field 'hapikey', changed field ordering (breaking for positional initialization)
- MultiAssociatedObjectWithLabel.toObjectId type changed from 'int' to 'string'
- AssociationSpec.associationCategory enum expanded to include 'WORK' value (potentially breaking for exhaustive match)
- AssociationSpecWithLabel.category enum expanded to include 'WORK' value (potentially breaking for exhaustive match)
- API key headers ('private-app', 'private-app-legacy') no longer automatically injected from ApiKeysConfig - callers must now pass headers manually, breaking authentication for API key users
- BatchResponseLabelsBetweenObjectPair.status enum order changed from 'PENDING|PROCESSING|CANCELED|COMPLETE' to 'CANCELED|COMPLETE|PENDING|PROCESSING'
- BatchResponsePublicAssociationMultiWithLabelWithErrors.status enum order changed
- BatchResponsePublicDefaultAssociation.status enum order changed
- BatchResponseLabelsBetweenObjectPairWithErrors.status enum order changed

### Fixed
- Simplified auth config handling with explicit type assignment instead of casting
- Removed redundant header map construction for API key injection (authentication now handled differently)
- Added documentation comments throughout types.bal and client.bal
