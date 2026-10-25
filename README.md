# Home Finance

A household money app for Ghana: MoMo, bank, card, cash and foreign-currency
balances in one place, income and spending by category, a child's costs by
term or year, and insurance and pension contributions.

Flutter (Android and iPhone), offline-first: all data stays in a local SQLite
database on the phone.

## Run it

```sh
flutter pub get
dart run build_runner build   # generates lib/data/database.g.dart
flutter run                   # on a connected phone or emulator
flutter test                  # unit and widget tests
```

Screenshots of every screen with the real fonts (for design review):

```sh
SCREENSHOT_FONTS=/path/to/ttf/files flutter test test/screenshot_test.dart
# writes build/screenshots/*.png; needs Manrope and Bricolage Grotesque .ttf files
```

## What is in this MVP

| Area | Status |
| --- | --- |
| Accounts: MoMo, bank, card, cash, savings, online wallets; any currency | Done |
| Balances computed from transactions; total in GHS with manual exchange rates | Done |
| Income, expenses, transfers; MoMo fee and e-levy saved as their own line | Done |
| Ghana-friendly categories with sub-categories (school fees, PTA, feeding, ...) | Done |
| Family members; tag spending; totals by term, year or month | Done |
| Insurance and pensions: monthly by default, contributions to date, due dates | Done |
| SMS reading: paste a MoMo or bank SMS, saved as a draft to confirm | Done |
| Duplicate SMS check and balance-gap warning | Done |
| Automatic SMS capture on Android, Shortcuts automation on iPhone | Next |
| PIN and fingerprint lock | Next |
| Encrypted database (SQLCipher) and Google Drive backup | Next |
| Due-date notifications | Next |
| Partner sharing and Supabase sync | Phase 2 |

## Layout

- `lib/core/money.dart`: amounts as integer pesewas, parsing and formatting
- `lib/data/database.dart`: Drift schema (every table carries `household_id` for later sync)
- `lib/data/repository.dart`: balances, transfers, summaries, premiums
- `lib/data/provider_registry.dart`, `seed.dart`: MoMo networks, banks, insurers; default categories
- `lib/sms/sms_parser.dart`: per-provider SMS templates plus a generic fallback
- `lib/ui/`: screens matching the approved mockup

SMS templates and the provider list are written from typical message shapes
and must be checked against real messages and the Bank of Ghana, NIC and NPRA
registers before a public release.
