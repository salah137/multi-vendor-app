import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendors_ecommerse_app/screens/MarketScreen.dart';
import '/layouts/HomeLayout.dart';
import '/screens/Sign Up and Sin In/RegisterScreen.dart';
import '/shared/cubit/AppCubit.dart';
import '/shared/cubit/AppStates.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (ctx, state) {
        AppCubit cubit = BlocProvider.of(ctx);
        return Scaffold(
          body: Form(
            key: formkey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.amber,
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    height: 550,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 80),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'email',
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (v) {
                            if (!(v!.contains("@") && v.contains(".com"))) {
                              return 'Entre The Right Form Of Emails';
                            } else if (v.isEmpty || v == null) {
                              return 'Return Your Email';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "password",
                          ),
                          validator: (v) {
                            if (v!.isEmpty || v == null) {
                              return 'Return Your password';
                            }
                            return null;
                          },
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: MaterialButton(
                              onPressed: () {
                                if (formkey.currentState!.validate())
                                  cubit.signIn(email.text, password.text).then(
                                    (value) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (ctx) => MarketScreen()),
                                          (route) => false);
                                    },
                                  );
                              },
                              child: ConditionalBuilder(
                                condition: state is SigninLoadingState,
                                builder: (ctx) {
                                  return CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                },
                                fallback: (ctx) => Text(
                                  "Done",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You Have Not Any Account ! ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => RegisterScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                'Register Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 15,
                                      color: Colors.indigo,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (ctx, state) {},
    );
  }
}
