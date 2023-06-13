import 'package:brown_brown/ui/styles.dart';
import 'package:flutter/material.dart';

class FertilizerData {
  final String name;

  /// 3원소
  final int n;
  final int p;
  final int k;

  /// 미량 원소
  final bool b;
  final bool ca;
  final bool cl;
  final bool co;
  final bool cu;
  final bool mg;
  final bool mn;
  final bool mo;
  final bool na;
  final bool ni;
  final bool s;
  final bool zn;

  FertilizerData(
    this.name,
    this.n,
    this.p,
    this.k, {
    this.b = false,
    this.ca = false,
    this.cl = false,
    this.co = false,
    this.cu = false,
    this.mg = false,
    this.mn = false,
    this.mo = false,
    this.na = false,
    this.ni = false,
    this.s = false,
    this.zn = false,
  });

  int pctOfN() => (n / (n + p + k) * 100).toInt();
  int pctOfP() => (p / (n + p + k) * 100).toInt();
  int pctOfK() => (k / (n + p + k) * 100).toInt();
}

class FertilizerCard extends StatelessWidget {
  const FertilizerCard(this.data, {super.key});

  final FertilizerData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Insets.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.name),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (data.pctOfN() != 0)
                Expanded(
                    flex: data.n,
                    child: Container(
                      color: Color(0XFFB5B991),
                      child: Text('N\n${data.pctOfN()}', textAlign: TextAlign.center),
                    )),
              if (data.pctOfP() != 0)
                Expanded(
                    flex: data.p,
                    child: Container(
                      color: Color(0XFFEDBB8A),
                      child: Text('P\n${data.pctOfP()}', textAlign: TextAlign.center),
                    )),
              if (data.pctOfK() != 0)
                Expanded(
                    flex: data.k,
                    child: Container(
                      color: Color(0XFFA7D3D4),
                      child: Text('K\n${data.pctOfK()}', textAlign: TextAlign.center),
                    )),
            ],
          ),
          VSpace.xs,
        ],
      ),
    );
  }
}
