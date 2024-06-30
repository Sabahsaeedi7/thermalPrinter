import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            valueOrDefault<String>(
              _model.pofff?.height?.toString(),
              '0',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_model.toPrint != null &&
                          (_model.toPrint?.bytes?.isNotEmpty ?? false))
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: FlutterFlowPdfViewer(
                            fileBytes: _model.pdftoview?.bytes,
                            width: valueOrDefault<double>(
                              _model.pdftoview?.width,
                              350.0,
                            ),
                            height: 552.0,
                            horizontalScroll: false,
                          ),
                        ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        _model.toPrint = await actions.thermal80mmPDF(
                          'https://png.pngtree.com/element_our/20200702/ourmid/pngtree-vector-illustration-fork-spoon-chef-hat-restaurant-logo-image_2283563.jpg',
                          'Slemani',
                          'bazar',
                          '04545445458578',
                          '074725787',
                          '54545',
                          'soran',
                          '04454545',
                          'jamal',
                          'fgdhggfhfh',
                          '654678678676',
                          List.generate(
                              random_data.randomInteger(5, 10),
                              (index) => random_data.randomString(
                                    1,
                                    20,
                                    true,
                                    true,
                                    false,
                                  )).toList(),
                          _model.qty.toList(),
                          List.generate(
                                  random_data.randomInteger(10, 20),
                                  (index) =>
                                      random_data.randomDouble(1.0, 120.0))
                              .toList(),
                          List.generate(
                                  random_data.randomInteger(5, 10),
                                  (index) =>
                                      random_data.randomDouble(1.0, 120.0))
                              .toList(),
                          valueOrDefault<double>(
                            random_data.randomDouble(1.0, 120.0),
                            0.0,
                          ),
                          7500.25,
                          8500.3,
                          65,
                          'goooo',
                          false,
                          1212,
                          List.generate(
                                  random_data.randomInteger(5, 7),
                                  (index) =>
                                      random_data.randomDouble(1.25, 25.0))
                              .toList(),
                          58000.36,
                          59000.58,
                        );
                        _model.pdftoview = _model.toPrint;
                        setState(() {});

                        setState(() {});
                      },
                      text: 'PDF',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      _model.pofff = await actions.convertPdfToImage(
                        _model.pdftoview!,
                      );

                      setState(() {});
                    },
                    text: 'print',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ].divide(const SizedBox(height: 25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
