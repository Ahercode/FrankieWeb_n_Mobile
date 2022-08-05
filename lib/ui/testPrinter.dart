import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:sunmi_printer/sunmi_printer.dart';

class TestPrinter extends StatefulWidget {
  const TestPrinter({Key? key}) : super(key: key);

  @override
  _TestPrinterState createState() => _TestPrinterState();
}

class _TestPrinterState extends State<TestPrinter> {
  late PrinterStatus _printerStatus;
  late PrinterMode _printerMode;

  @override
  void initState() {
    super.initState();

    _bindingPrinter().then((bool? isBind) async => {
          if (isBind!)
            {
              _getPrinterStatus(),
              _printerMode = await _getPrinterMode(),
            }
        });
  }

  /// must binding ur printer at first init in app
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  /// you can get printer status
  Future<void> _getPrinterStatus() async {
    final PrinterStatus result = await SunmiPrinter.getPrinterStatus();
    setState(() {
      _printerStatus = result;
    });
  }

  Future<PrinterMode> _getPrinterMode() async {
    final PrinterMode mode = await SunmiPrinter.getPrinterMode();
    return mode;
  }

  Future<void> _printLabel() async {
    String receiptHeader = """'
    FRANKIES RESTAURANT
    0302773567/0249680000
    RECEIPT TO BE ISSUED AFTER PAYMENT
    \t-------------------
    '""";
    String receiptBody = """'
    Table: TABLES11, 1 Guests
    Invoice:507551
    Order:507551
    Server:CARL
    Time:${DateTime.now()}
    \t-------------------



    '""";
    List test = [receiptHeader, receiptBody];
    print(_printerStatus);
    final ByteData bytes = await rootBundle.load("assets/Frankie's_Logo.jpeg");
    final Uint8List list = bytes.buffer.asUint8List();
    /*if (_printerStatus == PrinterStatus.NORMAL &&
        _printerMode == PrinterMode.LABEL_MODE) {*/
    print("Read");
    // must start with this function if you are print with label
    await SunmiPrinter.startLabelPrint();

    /// 0 align left, 1 center, 2 align right.
    await SunmiPrinter.setAlignment(PrintAlign.LEFT);
    // spacing line
    await SunmiPrinter.lineWrap(1);
    // print image only support Uint8List
    await SunmiPrinter.printImage(list);
    await SunmiPrinter.lineWrap(0);
    await SunmiPrinter.printText(test.toList().toString());
    /*await SunmiPrinter.lineWrap(0);
    await SunmiPrinter.printText(receiptBody);*/
    // only run exitLabelPrint at last index if you need print multiple label at once;
    await SunmiPrinter.exitLabelPrint();
    //}
  }

  ByteData? imageData;

  /*@override
  void initState() {
    rootBundle
        .load('assets/test.jpg')
        .then((data) => setState(() => this.imageData = data));
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pingspace Demo Printer'),
        ),
        body: Column(
          children: [
            InkWell(
                onTap: () async {
                  /*print("object");
                  String url =
                      'https://pngimg.com/uploads/nike/small/nike_PNG18.png';
                  // convert image to Uint8List format
                  Uint8List byte =
                      (await NetworkAssetBundle(Uri.parse(url)).load(url))
                          .buffer
                          .asUint8List();*/
                  /* await rootBundle
                      .load("assets/Frankie's_Logo.jpeg")
                      .then((data) {
                    setState(() {
                      imageData = data;
                    });
                  });*/
                  print("object");
                  await _printLabel();
                },
                child: Container(
                    color: Colors.red,
                    width: 200,
                    height: 100,
                    child: const Text('Print Label'))),
            GestureDetector(child: const Text('Example only')),
          ],
        ));
  }
}

/*import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';

class TestPrinter extends StatefulWidget {
  @override
  _TestPrinterState createState() => _TestPrinterState();
}

class _TestPrinterState extends State<TestPrinter> {
  void _print() async {
    // Test regular text
    SunmiPrinter.hr();
    SunmiPrinter.text(
      'Test Sunmi Printer',
      styles: SunmiStyles(align: SunmiAlign.center),
    );
    SunmiPrinter.hr();

    // Test align
    SunmiPrinter.text(
      'left',
      styles: SunmiStyles(bold: true, underline: true),
    );
    SunmiPrinter.text(
      'center',
      styles:
          SunmiStyles(bold: true, underline: true, align: SunmiAlign.center),
    );
    SunmiPrinter.text(
      'right',
      styles: SunmiStyles(bold: true, underline: true, align: SunmiAlign.right),
    );

    // Test text size
    SunmiPrinter.text('Extra small text',
        styles: SunmiStyles(size: SunmiSize.xs));
    SunmiPrinter.text('Medium text', styles: SunmiStyles(size: SunmiSize.md));
    SunmiPrinter.text('Large text', styles: SunmiStyles(size: SunmiSize.lg));
    SunmiPrinter.text('Extra large text',
        styles: SunmiStyles(size: SunmiSize.xl));

    // Test row
    SunmiPrinter.row(
      cols: [
        SunmiCol(text: 'col1', width: 4),
        SunmiCol(text: 'col2', width: 4, align: SunmiAlign.center),
        SunmiCol(text: 'col3', width: 4, align: SunmiAlign.right),
      ],
    );

    // Test image
    ByteData bytes = await rootBundle.load("assets/Frankie's_Logo.jpeg");
    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.emptyLines(3);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Sunmi Printer'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Center(
              child: RaisedButton(
                onPressed: _print,
                child: const Text('Print demo', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
