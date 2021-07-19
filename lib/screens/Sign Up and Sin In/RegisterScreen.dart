import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendors_ecommerse_app/screens/MarketScreen.dart';
import '/layouts/HomeLayout.dart';
import '/screens/Sign Up and Sin In/LoginScreen.dart';
import '/shared/cubit/AppCubit.dart';
import '/shared/cubit/AppStates.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
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
                    height: 700,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize:  74),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'email',
                          ),
                          validator: (v) {
                            if (!(v!.contains("@") && v.contains(".com"))) {
                              return 'Entre The Right Form Of Emails';
                            } else if (v.isEmpty || v == null) {
                              return 'Return Your Email';
                            }
                            if(!cubit.checkEmail(v)){
                              return 'This email is already used';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "password",
                          ),
                          validator: (v) {
                            if (v!.isEmpty || v == null) {
                              return 'Geve Me Your Password';
                            }
                            if (v.length < 8) {
                              return "Your Password is very short";
                            }
                            if (v.length > 15){
                              return 'Your Password is very long';
                            }

                            return null;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: username,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.supervised_user_circle_rounded),
                            hintText: "user name",
                          ),
                          validator: (v) {
                            if (v!.isEmpty || v == null) {
                              return 'Geve Me Your user Name';
                            }

                            if(!cubit.checkNames(v)){
                              return 'This name is already used';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: MaterialButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate())
                                {print(username);
                                await   cubit
                                      .signUp(
                                    email.text,
                                    password.text,
                                    username.text,
                                  )
                                      .then(
                                    (value) {
                                      print(state.toString());
                                      print(state is SignUpState);

                                      if(!(state is SignUpErrorState))
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (ctx) => HomePage()),
                                          (route) => false);
                                    },
                                  );
                              }},
                              child: ConditionalBuilder(
                                condition: state is SignUpLoadingState,
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
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You Have An Account ! ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (builder) => LoginScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                'Sign In Now',
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
