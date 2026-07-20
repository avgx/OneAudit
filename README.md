# OneAudit

Swift package with **typed HTTP request builders** for Native BL **audit inject** endpoints (`/v1/audit/inject*`), aligned with `Audit.proto`.

Reading the audit journal / `ET_Audit` events is **OneEventHistory** (`ReadEvents` with `EEventType.audit`), not this package.

No protobuf code generation.

**Platforms:** iOS 15+, macOS 13+, tvOS 17+, visionOS 1+  
**Swift tools:** 6.1+

## Dependencies

| Package | Role |
|---------|------|
| [RequestResponse](https://github.com/avgx/RequestResponse) | `AuditApi` → `Request<Void>` |
| [OneWireFormat](https://github.com/avgx/OneWireFormat) | `AccessPoint` |

## API surface (`AuditApi`)

| Method | HTTP |
|--------|------|
| `injectCameraViewingEvent(cameraAp:)` | `POST /v1/audit/injectCameraViewingEvent` |
| `injectArchiveViewingEvent(cameraAp:archiveAp:)` | `POST /v1/audit/injectArchiveViewingEvent` |
| `injectPtzControlEvent(cameraAp:)` | `POST /v1/audit/injectPtzControlEvent` |

## Usage

```swift
import OneAudit
import RequestResponse
import HTTP

try await http.send(
    AuditApi.injectCameraViewingEvent(cameraAp: cameraAp),
    with: builder
)

try await http.send(
    AuditApi.injectArchiveViewingEvent(cameraAp: cameraAp, archiveAp: archiveAp),
    with: builder
)

try await http.send(
    AuditApi.injectPtzControlEvent(cameraAp: cameraAp),
    with: builder
)
```

## Module layout

```
Sources/OneAudit/
  API/AuditApi.swift
  Inject/          request bodies
  AccessPoint.swift
```

## Tests

```bash
swift test
```
