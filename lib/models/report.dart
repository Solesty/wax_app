class Report {
  final int temp;
  final String wax;
  final String timeStamp;
  final String line;

  Report({this.temp, this.wax, this.timeStamp, this.line});
  
  Report.toJSON(Map<String, dynamic> parsedItems)
      : temp = parsedItems['temp'],
        wax = parsedItems['wax'],
        line = parsedItems['line'],
        timeStamp = parsedItems['timeStamp'];
}
