import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_courses_blocs/common/constants/languages.dart';
import 'package:flutter_courses_blocs/common/screenutil/screenutil.dart';
import 'package:flutter_courses_blocs/presentation/app_localizations.dart';
import 'package:flutter_courses_blocs/presentation/blocs/language/language_cubit.dart';
import 'package:flutter_courses_blocs/presentation/blocs/loading/loading_cubit.dart';
import 'package:flutter_courses_blocs/presentation/blocs/login/login_cubit.dart';
import 'package:flutter_courses_blocs/presentation/journeys/login/login_form.dart';
import 'package:flutter_courses_blocs/presentation/journeys/login/login_screen.dart';
import 'package:flutter_courses_blocs/presentation/widgets/logo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class LanguageCubitMock extends Mock implements LanguageCubit {}

class LoginCubitMock extends Mock implements LoginCubit {}

class LoadingCubitMock extends Mock implements LoadingCubit {}

main() {
  LanguageCubitMock _languageCubitMock;
  LoginCubitMock _loginCubitMock;
  LoadingCubitMock _loadingCubitMock;

  _languageCubitMock = LanguageCubitMock();
  _loginCubitMock = LoginCubitMock();
  _loadingCubitMock = LoadingCubitMock();

  ScreenUtil.init();
  Widget app = MultiBlocProvider(
    providers: [
      BlocProvider<LanguageCubit>.value(value: _languageCubitMock),
      BlocProvider<LoginCubit>.value(value: _loginCubitMock),
      BlocProvider<LoadingCubit>.value(value: _loadingCubitMock),
    ],
    child: MaterialApp(
      locale: Locale(Languages.languages[0].code),
      supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: LoginScreen(),
    ),
  );

  testWidgets('should show basic login screen UI login form and logo',
      (WidgetTester tester) async {
    print('1');
    await tester.pumpWidget(app);
    print('2');

    expect(find.byType(Logo), findsOneWidget);
    print('3');
    expect(find.byType(LoginForm), findsOneWidget);
  });
}
