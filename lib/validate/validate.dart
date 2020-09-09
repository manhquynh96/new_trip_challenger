String validateName(String val) {
  if (val.isEmpty) {
    return 'Name is not empty';
  }
  return null;
}

String validateEmail(String val) {
  if (val.isEmpty) {
    return 'Email is not empty';
  }
  return null;
}

String validatePass(String val) {
  if (val.length < 8) {
    return 'Password is not empty';
  }
  return null;
}

String validateHeight(String val) {
  if (val.isEmpty) {
    return 'Height is not empty';
  }
  return null;
}

String validateWeight(String val) {
  if (val.isEmpty) {
    return 'Weight is not empty';
  }
  return null;
}

String validateDate(String val) {
  if (val.isEmpty) {
    return 'Date is not empty';
  }
  return null;
}
