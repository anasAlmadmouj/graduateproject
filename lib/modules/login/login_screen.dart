import 'package:flutter/material.dart';
import 'package:graduateproject/modules/login/login.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is LoginErrorState){
          showToast(message: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: HexColor('#F7F7F7'),
          body: Form(
            key: formKey,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 25, left: 25, bottom: 100),
              child: ListView(
                children: [
                  Center(
                      child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/images/LogoFinal.jpg',
                        fit: BoxFit.fill),
                  )),
                  Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: defaultColorGreen,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      controller: emailController,
                      labelText: 'Email',
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: Icons.lock,
                        suffixIcon: LoginCubit.get(context).suffixIcon,
                        controller: passwordController,
                        labelText: 'Password',
                        obscureText: LoginCubit.get(context).isPassword,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                        },
                        suffixPressed: () {
                          LoginCubit.get(context).visiblePassword();
                        }),

                  const SizedBox(
                    height: 20,
                  ),
                  state is LoginLoadingState
                      ? const Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()))
                      : defaultElevatedButton(
                          borderRadius: 15,
                          width: double.infinity,
                          text: 'LOGIN',
                          colorText: defaultColorGray,
                          backGroundColor: defaultColorGreen,
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              await LoginCubit.get(context)
                                  .login(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((bool isSuccess) => isSuccess
                                      ? {
                                          LoginCubit.get(context)
                                              .storeUserSignInState(true),
                                          LoginCubit.get(context)
                                              .getUserInfo(
                                                  context: context),
                                        }
                                      : null);

                              // navigateToAndRemoveUntil(context, AdminLayout());
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
