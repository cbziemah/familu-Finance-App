import 'package:flutter_test/flutter_test.dart';
import 'package:home_finance/sms/sms_parser.dart';

// Sample messages are shaped like real ones but written for these tests;
// replace them with real (anonymised) messages from each provider.
void main() {
  const parser = SmsParser();

  test('maps sender IDs to providers', () {
    expect(parser.providerForSender('MobileMoney'), 'mtn_momo');
    expect(parser.providerForSender('T-CASH'), 'telecel_cash');
    expect(parser.providerForSender('GCB'), 'gcb');
    expect(parser.providerForSender('Unknown'), isNull);
  });

  test('MTN MoMo payment with fee, tax and balance', () {
    final r = parser.parse(
      'Payment made for GHS 85.00 to MELCOM ACCRA MALL. Current Balance: GHS 1,250.30. '
      'Available Balance: GHS 1,250.30. Reference: shopping. Transaction ID: 51234567890. '
      'Fee charged: GHS 0.43 TAX charged: GHS 0.85.',
      sender: 'MobileMoney',
    )!;
    expect(r.direction, SmsDirection.debit);
    expect(r.amount, 8500);
    expect(r.counterparty, 'MELCOM ACCRA MALL');
    expect(r.balance, 125030);
    expect(r.fee, 43);
    expect(r.tax, 85);
    expect(r.reference, '51234567890');
    expect(r.providerId, 'mtn_momo');
    expect(r.matchedTemplate, isTrue);
  });

  test('MTN MoMo money received', () {
    final r = parser.parse(
      'Payment received for GHS 200.00 from AMA SERWAA Current Balance: GHS 1,450.30. '
      'Transaction ID: 51234567891.',
      sender: 'MobileMoney',
    )!;
    expect(r.direction, SmsDirection.credit);
    expect(r.amount, 20000);
    expect(r.balance, 145030);
  });

  test('Telecel Cash transfer', () {
    final r = parser.parse(
      'Confirmed. GHS 50.00 sent to 0201234567 KWAME on 2026-10-20 at 10:15. '
      'Your new balance is GHS 300.00. Fee GHS 0.50. Transaction ID 0000123456.',
      sender: 'T-CASH',
    )!;
    expect(r.direction, SmsDirection.debit);
    expect(r.amount, 5000);
    expect(r.counterparty, '0201234567 KWAME');
    expect(r.balance, 30000);
    expect(r.fee, 50);
  });

  test('unknown bank falls back to the generic parser', () {
    final r = parser.parse(
      'Your account XXXX4521 has been debited with GHS 1,200.00 on 24-Oct-2026. '
      'Avail Bal: GHS 12,400.00. Ref: TRF88231.',
      sender: 'SomeBank',
    )!;
    expect(r.direction, SmsDirection.debit);
    expect(r.amount, 120000);
    expect(r.balance, 1240000);
    expect(r.reference, 'TRF88231');
    expect(r.matchedTemplate, isFalse);
  });

  test('USD credit is read in USD', () {
    final r = parser.parse('Your account has been credited with USD 320.00 from WISE. Bal: USD 1,020.00')!;
    expect(r.direction, SmsDirection.credit);
    expect(r.currency, 'USD');
    expect(r.amount, 32000);
  });

  test('ignores promos and one-time codes', () {
    expect(parser.parse('Your OTP is 123456. Do not share it.'), isNull);
    expect(parser.parse('Dial *170# and win up to GHS 1,000 this weekend!'), isNull);
  });
}
