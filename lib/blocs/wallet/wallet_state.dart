import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoaded extends WalletState {
  final double balance;
  final List<Transaction> transactions;

  const WalletLoaded(this.balance, this.transactions);

  @override
  List<Object> get props => [balance, transactions];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object> get props => [message];
}

class Transaction {
  final double amount;
  final DateTime timestamp;
  final bool isAddition;

  Transaction(this.amount, this.timestamp, this.isAddition);
}
