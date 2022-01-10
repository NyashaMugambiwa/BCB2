// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome back on RoboBank`
  String get welcome_note {
    return Intl.message(
      'Welcome back on RoboBank',
      name: 'welcome_note',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get login {
    return Intl.message(
      'Sign In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get sign_in {
    return Intl.message(
      'Create Account',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcome_message {
    return Intl.message(
      'Welcome back',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `Talk to Mimi?`
  String get offline_bot {
    return Intl.message(
      'Talk to Mimi?',
      name: 'offline_bot',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgot_password {
    return Intl.message(
      'Forgot your password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get sign_up {
    return Intl.message(
      'Don\'t have an account?',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in_text {
    return Intl.message(
      'Sign In',
      name: 'sign_in_text',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Robo Banking ChatBot`
  String get roboBank_title {
    return Intl.message(
      'Robo Banking ChatBot',
      name: 'roboBank_title',
      desc: '',
      args: [],
    );
  }

  /// `Transfers`
  String get transfers {
    return Intl.message(
      'Transfers',
      name: 'transfers',
      desc: '',
      args: [],
    );
  }

  /// `Airtime`
  String get airtime {
    return Intl.message(
      'Airtime',
      name: 'airtime',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `ChatBot`
  String get chatbot {
    return Intl.message(
      'ChatBot',
      name: 'chatbot',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get card_number {
    return Intl.message(
      'Card Number',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `Account Type`
  String get account_type {
    return Intl.message(
      'Account Type',
      name: 'account_type',
      desc: '',
      args: [],
    );
  }

  /// `Created on`
  String get created_on {
    return Intl.message(
      'Created on',
      name: 'created_on',
      desc: '',
      args: [],
    );
  }

  /// `Recent Transactions`
  String get recent_transactions {
    return Intl.message(
      'Recent Transactions',
      name: 'recent_transactions',
      desc: '',
      args: [],
    );
  }

  /// `Make All Your Transfers Here`
  String get make_transfers {
    return Intl.message(
      'Make All Your Transfers Here',
      name: 'make_transfers',
      desc: '',
      args: [],
    );
  }

  /// `Destination Bank`
  String get destination_bank {
    return Intl.message(
      'Destination Bank',
      name: 'destination_bank',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiary Account Number`
  String get ben_account_number {
    return Intl.message(
      'Beneficiary Account Number',
      name: 'ben_account_number',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiary Full Name`
  String get ben_full_name {
    return Intl.message(
      'Beneficiary Full Name',
      name: 'ben_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Internal Transfers`
  String get internal_transfers {
    return Intl.message(
      'Internal Transfers',
      name: 'internal_transfers',
      desc: '',
      args: [],
    );
  }

  /// `External Transfers`
  String get external_transfers {
    return Intl.message(
      'External Transfers',
      name: 'external_transfers',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Please type your message here`
  String get type_message {
    return Intl.message(
      'Please type your message here',
      name: 'type_message',
      desc: '',
      args: [],
    );
  }

  /// `Hello our potential customer, you have questions related to our banking services right? You are lost lost buddy, just let us know how you want us to assist you today by choose clicking a number that corresponds to the question you want to ask\n`
  String get offline_chatBot_welcome_note {
    return Intl.message(
      'Hello our potential customer, you have questions related to our banking services right? You are lost lost buddy, just let us know how you want us to assist you today by choose clicking a number that corresponds to the question you want to ask\n',
      name: 'offline_chatBot_welcome_note',
      desc: '',
      args: [],
    );
  }

  /// `1. How can i open an account`
  String get offline_chatBot_fs1 {
    return Intl.message(
      '1. How can i open an account',
      name: 'offline_chatBot_fs1',
      desc: '',
      args: [],
    );
  }

  /// `2. How long does it take to open an account ?`
  String get offline_chatBot_fs2 {
    return Intl.message(
      '2. How long does it take to open an account ?',
      name: 'offline_chatBot_fs2',
      desc: '',
      args: [],
    );
  }

  /// `3. What type of accounts can i open with your bank?`
  String get offline_chatBot_fs3 {
    return Intl.message(
      '3. What type of accounts can i open with your bank?',
      name: 'offline_chatBot_fs3',
      desc: '',
      args: [],
    );
  }

  /// `4. What do i need to open an account ?`
  String get offline_chatBot_fs4 {
    return Intl.message(
      '4. What do i need to open an account ?',
      name: 'offline_chatBot_fs4',
      desc: '',
      args: [],
    );
  }

  /// `RoboBank Main Menu`
  String get offline_chatBot_main_menu {
    return Intl.message(
      'RoboBank Main Menu',
      name: 'offline_chatBot_main_menu',
      desc: '',
      args: [],
    );
  }

  /// `Follow the steps below to open an account`
  String get offline_chatBot_subMenu1 {
    return Intl.message(
      'Follow the steps below to open an account',
      name: 'offline_chatBot_subMenu1',
      desc: '',
      args: [],
    );
  }

  /// `Download and install the mobile application in your smart device`
  String get offline_chatBot_sb1option1 {
    return Intl.message(
      'Download and install the mobile application in your smart device',
      name: 'offline_chatBot_sb1option1',
      desc: '',
      args: [],
    );
  }

  /// `Run the application`
  String get offline_chatBot_sb1option2 {
    return Intl.message(
      'Run the application',
      name: 'offline_chatBot_sb1option2',
      desc: '',
      args: [],
    );
  }

  /// `Login and click the link in blue at the bottom center of the login page`
  String get offline_chatBot_sb1option3 {
    return Intl.message(
      'Login and click the link in blue at the bottom center of the login page',
      name: 'offline_chatBot_sb1option3',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the fields with your valid details`
  String get offline_chatBot_sb1option4 {
    return Intl.message(
      'Fill in the fields with your valid details',
      name: 'offline_chatBot_sb1option4',
      desc: '',
      args: [],
    );
  }

  /// `Press # to return to the main menu`
  String get offline_chatBot_sb1ReturnHome {
    return Intl.message(
      'Press # to return to the main menu',
      name: 'offline_chatBot_sb1ReturnHome',
      desc: '',
      args: [],
    );
  }

  /// `Account Creation Duration`
  String get offline_chatBot_subMenu2 {
    return Intl.message(
      'Account Creation Duration',
      name: 'offline_chatBot_subMenu2',
      desc: '',
      args: [],
    );
  }

  /// `Once you follow through the registration process, and provide all your personal details that we ask from you, you will only need to wait for 4 hours as we wait for validation your identity`
  String get offline_chatBot_sb2option1 {
    return Intl.message(
      'Once you follow through the registration process, and provide all your personal details that we ask from you, you will only need to wait for 4 hours as we wait for validation your identity',
      name: 'offline_chatBot_sb2option1',
      desc: '',
      args: [],
    );
  }

  /// `Types Of Accounts you can open`
  String get offline_chatBot_subMenu3 {
    return Intl.message(
      'Types Of Accounts you can open',
      name: 'offline_chatBot_subMenu3',
      desc: '',
      args: [],
    );
  }

  /// `Once you follow through the registration process, and provide all your personal details that we ask from you, you will only need to wait for 4 hours as we wait for validation your identity`
  String get offline_chatBot_sb3option1 {
    return Intl.message(
      'Once you follow through the registration process, and provide all your personal details that we ask from you, you will only need to wait for 4 hours as we wait for validation your identity',
      name: 'offline_chatBot_sb3option1',
      desc: '',
      args: [],
    );
  }

  /// `Run the application`
  String get offline_chatBot_sb3option2 {
    return Intl.message(
      'Run the application',
      name: 'offline_chatBot_sb3option2',
      desc: '',
      args: [],
    );
  }

  /// `Login and click the link in blue at the bottom center of the login page`
  String get offline_chatBot_sb3option3 {
    return Intl.message(
      'Login and click the link in blue at the bottom center of the login page',
      name: 'offline_chatBot_sb3option3',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the fields with your valid details`
  String get offline_chatBot_sb3option4 {
    return Intl.message(
      'Fill in the fields with your valid details',
      name: 'offline_chatBot_sb3option4',
      desc: '',
      args: [],
    );
  }

  /// `Press # to return to the main menu`
  String get offline_chatBot_sb3ReturnHome {
    return Intl.message(
      'Press # to return to the main menu',
      name: 'offline_chatBot_sb3ReturnHome',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}