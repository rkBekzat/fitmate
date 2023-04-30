import 'package:fitmate/bloc/barcode/barcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitmate/models/product_data.dart';

class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget({Key? key}) : super(key: key);

  @override
  createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScannerWidget> {
  double _newScanWidth = 0, _newScanHeight = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    _newScanWidth = screenWidth * 0.60;
    _newScanHeight = _newScanWidth * 0.65;

    return BlocBuilder<BarcodeBloc, BarcodeState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.fromLTRB(0, screenHeight * 0.15, 0, 0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: _newScanWidth,
                  height: _newScanHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BarcodeBloc>(context)
                          .add(ScanBarcodeEvent());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 125, 122, 219)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'New Scan',
                        style: TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                ),
              ),
              state is GetBarcodeState
                  ? Container(
                      width: _newScanWidth,
                      height: _newScanWidth,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 64, 206, 107),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              state.barcode,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 200,
                                color: Color.fromARGB(255, 77, 53, 164),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          FittedBox(
                            child: FutureBuilder<ProductData?>(
                                future: state.product,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data?.productName ?? "No name",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 200,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                      "Product not found",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 200,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  return const CircularProgressIndicator();
                                }),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 229, 183, 97)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const FittedBox(
                                child: Text(
                                  "about page",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 200,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
