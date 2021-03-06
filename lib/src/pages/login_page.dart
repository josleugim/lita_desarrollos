import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/forgotten/password_recover.dart';
import 'package:litadesarrollos/src/services/login_service.dart';

import 'package:litadesarrollos/src/theme/theme.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
      ),
      backgroundColor: primaryLita,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: loginProvider.fbkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .05),
                  child: Center(
                    child: Image.asset(
                      'assets/lita.png',
                      width: MediaQuery.of(context).size.width * .25,
                    ),
                  ),
                ),
                loginProvider.error != ''
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .1,
                            vertical: 5),
                        child: Text(
                          '${loginProvider.error}',
                          style: GoogleFonts.sourceSansPro(color: accentLita),
                        ))
                    : Container(),

                /**
                 * Text Field para usuario, email
                 */
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .1,
                      vertical: MediaQuery.of(context).size.height * .04),
                  child: FormBuilderTextField(
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white, fontSize: 16),
                    attribute: "email",
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "Usuario",
                        labelStyle: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        errorStyle: TextStyle(color: accentLita),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                /**
                 * Textfield Password
                 */
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .1,
                      vertical: MediaQuery.of(context).size.height * .04),
                  child: FormBuilderTextField(
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white, fontSize: 16),
                    attribute: "password",
                    textInputAction: TextInputAction.done,
                    obscureText: !loginProvider.pass,
                    cursorColor: Colors.white,
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginProvider.pass == false
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (loginProvider.pass == true) {
                            loginProvider.pass = false;
                          } else {
                            loginProvider.pass = true;
                          }
                        },
                      ),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Contraseña",
                      errorStyle: TextStyle(color: accentLita),
                      labelStyle: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                /**
                 * Olvide mi password
                 */
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .10),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ForgotPassword()));
                    },
                    child: Text(
                      'Olvidé mi contraseña',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: InkWell(
                          onTap: () {
                            loginProvider.rememberUser =
                                !loginProvider.rememberUser;
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: loginProvider.rememberUser == true
                                    ? Colors.white
                                    : primaryLita,
                                border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: loginProvider.rememberUser
                                  ? Icon(
                                      Icons.check,
                                      size: 30.0,
                                      color: primaryLita,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 30.0,
                                      color: Colors.transparent,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Recordar Usuario',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .1),
                  child: MaterialButton(
                    onPressed: () async {
                      if (loginProvider.fbkey.currentState.saveAndValidate()) {
                        loginProvider.email =
                            loginProvider.fbkey.currentState.value['email'];
                        loginProvider.password =
                            loginProvider.fbkey.currentState.value['password'];
                        await loginProvider.loginUser();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: accentLita,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .2),
                      child: loginProvider.isloading == true
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 1,
                            )
                          : Text(
                              'Iniciar Sesión',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
