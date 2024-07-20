import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../blocs/wallet/wallet_bloc.dart';
import '../blocs/wallet/wallet_event.dart';
import '../blocs/wallet/wallet_state.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletInitial) {
            context.read<WalletBloc>().add(LoadWallet());
            return Center(child: CircularProgressIndicator());
          } else if (state is WalletLoaded) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Balance: ₹${state.balance.toStringAsFixed(2)}"),
                  ElevatedButton(
                    onPressed: () => _showAddFundsDialog(context),
                    child: Text("Add Funds"),
                  ),
                  ElevatedButton(
                    onPressed: () => _showWithdrawFundsDialog(context, state.balance),
                    child: Text("Withdraw Funds"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];
                        final transactionType = transaction.isAddition ? 'Added' : 'Withdrawn';
                        final amountColor = transaction.isAddition ? Colors.green : Colors.red;
                        return ListTile(
                          title: Text(
                            "$transactionType: ₹${transaction.amount.toStringAsFixed(2)}",
                            style: TextStyle(color: amountColor),
                          ),
                          subtitle: Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(transaction.timestamp)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is WalletError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _showAddFundsDialog(BuildContext context) {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Funds"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter amount"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                context.read<WalletBloc>().add(AddFunds(amount));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showWithdrawFundsDialog(BuildContext context, double currentBalance) {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Withdraw Funds"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter amount"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Withdraw"),
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                if (amount > currentBalance) {
                  Navigator.of(context).pop();
                  _showInsufficientFundsDialog(context);
                } else {
                  context.read<WalletBloc>().add(WithdrawFunds(amount));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showInsufficientFundsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Insufficient Funds"),
          content: Text("You do not have enough balance to withdraw this amount."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
