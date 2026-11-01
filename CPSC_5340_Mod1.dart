// CPSC 5340
// COURTNEY PROSS
// M1: A DATA SET WITH A SUMMARY AND FILTER FUNCTION

String summaryData(Map<String, int> values) {
  var maxValue = 0;
  var count = 0;
  for (var entry in values.entries) {
    var value = entry.value;
    if (value > maxValue) {
      maxValue = value;
    }
    count = count + 1;
  }
  var closetSummary = <String, int>{'count': count, 'max': maxValue};
  return 'Here is your summary information:\n $closetSummary\n';
}

final filterData = (Map<String, int> values) {
  var filteredValues = <String, int>{};
  for (var entry in values.entries) {
    var key = entry.key;
    var value = entry.value;

    if (value >= 5) {
      filteredValues.addAll({key: value});
    }
  }
  return 'Here is the subset of your data that you have a quantity of 5 or more of:\n $filteredValues\n';
};



void main() {
  var closetInventory = <String, int>{
    'shirts': 17,
    'pants': 6,
    'coats': 1,
    'shoes': 2,
    'suits': 1,
    'shorts': 5,
  };
  
  print(summaryData(closetInventory));
  print(filterData(closetInventory));
}
