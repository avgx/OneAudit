# OneAudit

Hand-written Swift models and HTTP request builders for the audit API.

**Sources of truth:**

- [Audit.proto](https://github.com/jerrygergov/axxon-telegram-vms/blob/main/support/protos/axxonsoft/bl/audit/Audit.proto) — inject endpoints (`/v1/audit/inject*`)
- [Events.proto — AuditEvent](https://github.com/jerrygergov/axxon-telegram-vms/blob/main/support/protos/axxonsoft/bl/events/Events.proto) — `EAuditEventType`, stream payload (`ET_Audit`)
- Legacy Next web server — `GET audit/{host}/{end}/{begin}?filter=...`

No `protoc` code generation.

## Dependencies

| Package | Role |
|---------|------|
| [RequestResponse](https://github.com/avgx/RequestResponse) | `AuditApi` → `Request<T>` |
| [OneWireFormat](https://github.com/avgx/OneWireFormat) | `AccessPoint`, `Timestamp.utc` |
| [SafeEnum](https://github.com/avgx/SafeEnum) | Unknown `eventType` / `operation` values |

## Journal

```swift
import OneAudit
import RequestResponse

let filter = AuditJournalFilter(
    begin: startDate,
    end: endDate,
    eventTypes: [.AE_USER_LOGIN, .AE_DEVICE_ADD]
)
let page = try await http.send(AuditApi.listJournal(host: host, filter: filter), with: builder).value
for entry in page.events {
    print(entry.displayText())
}
```

Wire timestamps use `Timestamp.utc` (`yyyyMMdd'T'HHmmss`).

## Inject

```swift
try await http.send(AuditApi.injectCameraViewingEvent(cameraAp: cameraAp), with: builder)
try await http.send(
    AuditApi.injectArchiveViewingEvent(cameraAp: cameraAp, archiveAp: archiveAp),
    with: builder
)
```

## Localization

Event templates live in `Resources/Localizable.xcstrings` (`audit.event.*` and legacy `AuditJournalMessage_*` keys).

```swift
let text = entry.displayText()
let filterLabel = AuditEventType.AE_USER_LOGIN.filterTitle
```
