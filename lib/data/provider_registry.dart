/// Seed list of financial providers in Ghana.
///
/// This is data, not logic: the plan is to refresh it from the Bank of Ghana,
/// National Insurance Commission and NPRA registers and ship updates without
/// an app release. Names and SMS sender IDs below must be checked against
/// those registers and real messages before a public release.
class ProviderSeed {
  const ProviderSeed(this.id, this.name, this.kind, [this.smsSenders = const []]);

  final String id;
  final String name;

  /// momo | bank | wallet | insurer | pension | health
  final String kind;
  final List<String> smsSenders;
}

const providerSeeds = <ProviderSeed>[
  // Mobile money networks.
  ProviderSeed('mtn_momo', 'MTN MoMo', 'momo', ['MobileMoney', 'MTN MoMo', 'MTNMoMo']),
  ProviderSeed('telecel_cash', 'Telecel Cash', 'momo', ['T-CASH', 'TelecelCash', 'Telecel']),
  ProviderSeed('at_money', 'AT Money', 'momo', ['AT Money', 'ATMoney', 'AirtelTigo']),

  // Universal banks.
  ProviderSeed('absa', 'Absa Bank Ghana', 'bank', ['Absa']),
  ProviderSeed('access', 'Access Bank Ghana', 'bank', ['AccessBank']),
  ProviderSeed('adb', 'Agricultural Development Bank', 'bank', ['ADB']),
  ProviderSeed('boa', 'Bank of Africa Ghana', 'bank', ['BOA']),
  ProviderSeed('calbank', 'CalBank', 'bank', ['CalBank']),
  ProviderSeed('cbg', 'Consolidated Bank Ghana', 'bank', ['CBG']),
  ProviderSeed('ecobank', 'Ecobank Ghana', 'bank', ['Ecobank']),
  ProviderSeed('fbn', 'FBNBank Ghana', 'bank', ['FBNBank']),
  ProviderSeed('fidelity', 'Fidelity Bank Ghana', 'bank', ['Fidelity']),
  ProviderSeed('first_atlantic', 'First Atlantic Bank', 'bank', ['FABL']),
  ProviderSeed('fnb', 'First National Bank Ghana', 'bank', ['FNB']),
  ProviderSeed('gcb', 'GCB Bank', 'bank', ['GCB', 'GCBBank']),
  ProviderSeed('gtbank', 'Guaranty Trust Bank Ghana', 'bank', ['GTBank']),
  ProviderSeed('nib', 'National Investment Bank', 'bank', ['NIB']),
  ProviderSeed('omnibsic', 'OmniBSIC Bank', 'bank', ['OmniBSIC']),
  ProviderSeed('prudential', 'Prudential Bank', 'bank', ['PBL']),
  ProviderSeed('republic', 'Republic Bank Ghana', 'bank', ['RepublicBk']),
  ProviderSeed('societe_generale', 'Societe Generale Ghana', 'bank', ['SGGhana']),
  ProviderSeed('stanbic', 'Stanbic Bank Ghana', 'bank', ['Stanbic']),
  ProviderSeed('stanchart', 'Standard Chartered Bank Ghana', 'bank', ['StanChart']),
  ProviderSeed('uba', 'United Bank for Africa Ghana', 'bank', ['UBA']),
  ProviderSeed('umb', 'Universal Merchant Bank', 'bank', ['UMB']),
  ProviderSeed('zenith', 'Zenith Bank Ghana', 'bank', ['Zenith']),

  // Online and foreign-currency wallets.
  ProviderSeed('wise', 'Wise', 'wallet'),
  ProviderSeed('paypal', 'PayPal', 'wallet'),
  ProviderSeed('payoneer', 'Payoneer', 'wallet'),

  // Pensions and health. Insurers come from the NIC register; "Other" covers
  // any provider missing from the list.
  ProviderSeed('ssnit', 'SSNIT', 'pension'),
  ProviderSeed('nhis', 'NHIS', 'health'),
  ProviderSeed('other_insurer', 'Other insurer', 'insurer'),
  ProviderSeed('other_pension', 'Other pension trustee', 'pension'),
];
