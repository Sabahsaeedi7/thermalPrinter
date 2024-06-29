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
            'Page Title',
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.gotoprint =
                          await actions.thermalPrinterEnAr80mmPDF(
                        'https://s.tmimgcdn.com/scr/1200x750/266400/restaurant-logo-auf-weissem-hintergrund_266438-original.jpg',
                        'gfdgdg',
                        'gfdgd',
                        'gfdgd',
                        'gdfg',
                        'gfdgdgd',
                        'gfdgdg',
                        'fgdgdgd',
                        'gfdgdg',
                        'gfdgdgd',
                        '64864646768',
                        List.generate(
                            random_data.randomInteger(5, 10),
                            (index) => random_data.randomString(
                                  5,
                                  10,
                                  true,
                                  false,
                                  false,
                                )).toList(),
                        List.generate(random_data.randomInteger(2, 4),
                                (index) => random_data.randomInteger(25, 100))
                            .toList(),
                        List.generate(random_data.randomInteger(10, 20),
                                (index) => random_data.randomDouble(2.0, 10.0))
                            .toList(),
                        List.generate(
                            random_data.randomInteger(5, 10),
                            (index) =>
                                random_data.randomDouble(25.0, 200.0)).toList(),
                        2500.00,
                        2500.00,
                        2500.00,
                        25,
                        'jhgjg',
                        true,
                        76767,
                        List.generate(
                            random_data.randomInteger(5, 10),
                            (index) =>
                                random_data.randomDouble(25.0, 500.0)).toList(),
                        2500.00,
                        00.0,
                      );

                      setState(() {});
                    },
                    text: 'Print',
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
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FlutterFlowPdfViewer(
                    fileBytes: _model.gotoprint?.bytes,
                    height: 583.0,
                    horizontalScroll: false,
                  ),
                ),
              ].divide(const SizedBox(height: 25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
