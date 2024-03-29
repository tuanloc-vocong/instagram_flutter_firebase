import 'package:flutter/cupertino.dart';
import 'package:instagram_mobile_flutter/view_models/auth/login_view_model.dart';
import 'package:instagram_mobile_flutter/widgets/indicators.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
    )
  }
}
