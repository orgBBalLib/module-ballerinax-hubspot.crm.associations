# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new type 'BatchResponseVoid' for void batch operations
- Added comprehensive documentation comments to all types and fields
- Added new query parameter type 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'

### Changed
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/archive' - return type changed from 'error?' to 'BatchResponseVoid|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/create' - return type changed from 'BatchResponseLabelsBetweenObjectPair|BatchResponseLabelsBetweenObjectPairWithErrors|error' to 'BatchResponseLabelsBetweenObjectPair|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/labels/archive' - return type changed from 'error?' to 'BatchResponseVoid|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/read' - return type changed from 'BatchResponsePublicAssociationMultiWithLabel|BatchResponsePublicAssociationMultiWithLabelWithErrors|error' to 'BatchResponsePublicAssociationMultiWithLabel|error'
- Method signature changed for 'put objects/[string fromObjectType]/[string fromObjectId]/associations/default/[string toObjectType]/[string toObjectId]' - removed payload parameter
- Method signature changed for 'delete objects/[string objectType]/[string objectId]/associations/[string toObjectType]/[string toObjectId]' - return type description changed from 'Returns http:Response with status 204 No Content' to 'No content'
- Type 'BatchResponseLabelsBetweenObjectPairWithErrors' removed
- Type 'BatchResponsePublicAssociationMultiWithLabelWithErrors' removed
- Query parameter type renamed from 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'
- Field type changes in multiple types: 'toObjectId' and 'fromObjectId' changed from 'int' to 'string' in LabelsBetweenObjectPair and MultiAssociatedObjectWithLabel
- Field type change in DateTime: 'value' changed from 'int' to 'int:Signed32'

### Fixed
- Corrected field types from 'int' to 'string' for object IDs to match API specification
- Simplified return types by removing error variants that are no longer needed
- Updated method descriptions to be more accurate and consistent
