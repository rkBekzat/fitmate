import 'package:easy_localization/easy_localization.dart';
import 'package:fitmate/bloc/barcode/barcode_bloc.dart';
import 'package:fitmate/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitmate/models/product_data.dart';
import 'package:fitmate/util/product_about.dart';

class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget({Key? key}) : super(key: key);

  @override
  createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScannerWidget> {
  double _newScanWidth = 0, _newScanHeight = 0;

  ProductData? product;

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
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        LocaleKeys.new_scan.tr(),
                        style: const TextStyle(fontSize: 100),
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
                                  product = snapshot.data;
                                  if (snapshot.hasData &&
                                      product?.productName !=
                                          "((product not found))") {
                                    return Text(
                                      snapshot.data?.productName ??
                                          LocaleKeys.no_name.tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 200,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else if (snapshot.hasError ||
                                      product?.productName ==
                                          "((product not found))") {
                                    return Text(
                                      LocaleKeys.no_product.tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
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
                              onPressed: () {
                                if (product == null) return;
                                if (product?.productName ==
                                    "((product not found))") return;
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return ProductAbout(
                                      productData: product!,
                                    );
                                  },
                                );
                              },
                              child: FittedBox(
                                child: Text(
                                  LocaleKeys.about_page.tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
