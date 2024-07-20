import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class LoadWallet extends WalletEvent {}

class AddFunds extends WalletEvent {
  final double amount;

  const AddFunds(this.amount);

  @override
  List<Object> get props => [amount];
}

class WithdrawFunds extends WalletEvent {
  final double amount;

  const WithdrawFunds(this.amount);

  @override
  List<Object> get props => [amount];
}
