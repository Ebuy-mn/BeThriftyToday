import 'package:bethriftytoday/models/models.dart';
import 'package:bethriftytoday/screens/screens.dart';
import 'package:bethriftytoday/services/database/user_db.dart';
import 'package:bethriftytoday/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySetupScreen extends StatefulWidget {
  static const String routeName = '/currency-setup';

  @override
  _CurrencySetupScreenState createState() => _CurrencySetupScreenState();
}

class _CurrencySetupScreenState extends State<CurrencySetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              OnboardingHeader(),
              SizedBox(height: 50),
              Icon(
                Icons.attach_money,
                size: 42,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(height: 15),
              Text(
                'What\'s your currency?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              CurrencyGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyGridView extends StatelessWidget {
  const CurrencyGridView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currencies = Provider.of<List<Currency>>(context);

    if (currencies != null) {
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2,
        mainAxisSpacing: 40,
        shrinkWrap: true,
        children: currencies
            .map((Currency currency) => CurrencyCircle(currency))
            .toList(),
      );
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class CurrencyCircle extends StatelessWidget {
  final Currency currency;

  const CurrencyCircle(this.currency);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return FloatingActionButton(
      elevation: 0,
      heroTag: currency.name,
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Colors.white,
      onPressed: () async {
        await UserDatabaseService(user).updateUserCurrency(currency);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      },
      child: Text(
        currency.symbol,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
