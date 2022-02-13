class Transaction {
  
  final String _id;
  final String _title;
  final double _amount;
  final DateTime _date;

  Transaction(this._id, this._title, this._amount, this._date);

  String get id {
    return _id;
  }
  
  String get title {
    return _title;
  }

  double get amount {
    return _amount;
  }

  DateTime get date {
    return _date;
  }
}




