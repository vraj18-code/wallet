import 'package:bloc/bloc.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<LoadWallet>(_onLoadWallet);
    on<AddFunds>(_onAddFunds);
    on<WithdrawFunds>(_onWithdrawFunds);
  }

  double _balance = 0.0;
  List<Transaction> _transactions = [];

  void _onLoadWallet(LoadWallet event, Emitter<WalletState> emit) {
    emit(WalletLoaded(_balance, _transactions));
  }

  void _onAddFunds(AddFunds event, Emitter<WalletState> emit) {
    _balance += event.amount;
    _transactions.add(Transaction(event.amount, DateTime.now(), true));
    emit(WalletLoaded(_balance, _transactions));
  }

  void _onWithdrawFunds(WithdrawFunds event, Emitter<WalletState> emit) {
    if (_balance >= event.amount) {
      _balance -= event.amount;
      _transactions.add(Transaction(event.amount, DateTime.now(), false));
      emit(WalletLoaded(_balance, _transactions));
    } else {
      emit(WalletError("Insufficient funds"));
      emit(WalletLoaded(_balance, _transactions));
    }
  }
}
