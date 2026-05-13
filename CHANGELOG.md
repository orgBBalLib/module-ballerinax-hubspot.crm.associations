# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added new type BatchResponseVoid for operations that don't return data
- Added comprehensive documentation comments to all types and fields
- Added new query parameter type GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries

### Changed
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/archive' - return type changed from 'error?' to 'BatchResponseVoid|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/labels/archive' - return type changed from 'error?' to 'BatchResponseVoid|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/create' - return type changed from 'BatchResponseLabelsBetweenObjectPair|BatchResponseLabelsBetweenObjectPairWithErrors|error' to 'BatchResponseLabelsBetweenObjectPair|error'
- Method signature changed for 'post associations/[string fromObjectType]/[string toObjectType]/batch/read' - return type changed from 'BatchResponsePublicAssociationMultiWithLabel|BatchResponsePublicAssociationMultiWithLabelWithErrors|error' to 'BatchResponsePublicAssociationMultiWithLabel|error'
- Method signature changed for 'put objects/[string fromObjectType]/[string fromObjectId]/associations/default/[string toObjectType]/[string toObjectId]' - removed payload parameter
- Query parameter type changed for GET method - GetObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries renamed to GetCrmV4ObjectsObjectTypeObjectIdAssociationsToObjectTypeGetPageQueries
- Type BatchResponseLabelsBetweenObjectPairWithErrors removed
- Type BatchResponsePublicAssociationMultiWithLabelWithErrors removed
- Field type changes in multiple types - several fields changed from int to string (e.g., toObjectId, fromObjectId)
- Field type change in DateTime record - 'value' field changed from 'int' to 'int:Signed32'

### Fixed
- Improved error handling by removing error-prone union types with error variants
- Standardized field types for object IDs from int to string for consistency
- Updated resource paths to use more specific API versioning (crm/v4)
