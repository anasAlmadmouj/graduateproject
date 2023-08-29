import 'package:graduateproject/app_layout/app_cubit/app_cubit.dart';
import 'package:graduateproject/app_layout/home_screen.dart';
import 'package:graduateproject/modules/login/cubit/login_states.dart';
import 'package:graduateproject/modules/login/login_screen.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';

import 'main_imports.dart';

///Todo: admin@zuj.edu.jo
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FireStoreStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            // ..getDepartment()
            // ..getUserType()
            // ..getCategory()
            // ..getAcademicYears()
              // ..getSubjects(context: context)
          // ..getSubject(context: context),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => UploadCubit(),
        ),
        BlocProvider(
          create: (context) => AdminCubit()..getUsers(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home:  const Root(),
        ),
      ),
    );
  }
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        bool isSignedIn = LoginCubit.get(context).getUserSignInState();
        String userType = CacheHelper.getData(key: spUserType) ?? '';
        if (isSignedIn) {
            return const HomePage();
          }
        return LoginScreen();
      },
    );
  }
}
