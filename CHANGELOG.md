# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new type 'BatchResponseVoid' for operations that return no result data
- Added comprehensive documentation comments to all types and fields
- Added class-level documentation comment for Client class

### Changed
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/archive' - return type changed from 'error?' to 'BatchResponseVoid|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/create' - return type changed from 'BatchResponseLabelsBetweenObjectPair|BatchResponseLabelsBetweenObjectPairWithErrors|error' to 'BatchResponseLabelsBetweenObjectPair|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/labels/archive' - return type changed from 'error?' to 'BatchResponseVoid|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/read' - return type changed from 'BatchResponsePublicAssociationMultiWithLabel|BatchResponsePublicAssociationMultiWithLabelWithErrors|error' to 'BatchResponsePublicAssociationMultiWithLabel|error'
- Type 'BatchResponseLabelsBetweenObjectPairWithErrors' removed
- Type 'BatchResponsePublicAssociationMultiWithLabelWithErrors' removed
- Field type changed in LabelsBetweenObjectPair: 'toObjectId' from 'int' to 'string', 'fromObjectId' from 'int' to 'string'
- Field type changed in MultiAssociatedObjectWithLabel: 'toObjectId' from 'int' to 'string'
- Field type changed in DateTime: 'value' from 'int' to 'int:Signed32'
- Query parameter type renamed from 'GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries' to 'GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries'

### Fixed
- Improved method documentation with more accurate descriptions
- Standardized return type handling by removing error union types from batch responses
- Fixed field types to use proper string identifiers instead of integers for object IDs
