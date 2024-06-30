import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  FFUploadedFile? pdftoview;

  List<int> qty = [55, 8, 88, 25, 555, 7878, 87878];
  void addToQty(int item) => qty.add(item);
  void removeFromQty(int item) => qty.remove(item);
  void removeAtIndexFromQty(int index) => qty.removeAt(index);
  void insertAtIndexInQty(int index, int item) => qty.insert(index, item);
  void updateQtyAtIndex(int index, Function(int) updateFn) =>
      qty[index] = updateFn(qty[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - thermal80mmPDF] action in Button widget.
  FFUploadedFile? toPrint;
  // Stores action output result for [Custom Action - convertPdfToImage] action in Button widget.
  FFUploadedFile? gogo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
