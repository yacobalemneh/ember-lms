import 'dart:math';

class DistributionCalculator {
  List<double> data = [9, 2, 5, 4, 12, 7, 8, 11, 9, 3, 7, 4, 12, 5, 4, 10, 9, 6, 9, 4];


  get sumData => data.reduce((a, b) => a + b);

  get meanData => sumData / lengthOfData;

  get lengthOfData => data.length;

  _sum({var of}) {
    return of.reduce((a, b) => a + b);
  }

  _mean({var ofData}) {
    return _sum(of: ofData) / ofData.length;
  }

  get standardDeviation {
    var difference = [];
    for (var i = 0; i < lengthOfData; i++)
      difference.add(pow(data[i] - meanData, 2));
    return sqrt(_mean(ofData: difference));

  }

  get normalDistribution {

    var y = [];
    var variance = pow(standardDeviation, 2);

    for (var i = 0; i < lengthOfData; i++) {
      var exponent = pow(e, -1 * ((data[i] - meanData)/(2 * variance)));
      var result = 1/(standardDeviation * sqrt(2 * pi)) * exponent;
      y.add(result);

    }
    return y;
  }

  get zScore {
    var z = [];

    for (var i = 0; i < lengthOfData; i++)
      z.add((data[i] - meanData) / standardDeviation);

    return z;
  }


    DistributionCalculator() {
    print(meanData);
  }
}

DistributionCalculator calculator = DistributionCalculator();



