
//Validation check for Password
bool isDigit(String s, int idx) =>
    "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;

String? passwordCheck(String value)
{
  bool hasUppercase  = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  var character='';
  var i=0;
  if(value.isEmpty)
    {
      return "Password can't be empty!";
    }
  if ( value.isNotEmpty) {
    // Check if valid special characters are present
    hasSpecialCharacters = value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    while (i < value.length){
      character = value.substring(i,i+1);
      // print(character);

      if (isDigit(character , 0)){
        hasDigits=true;
      }else{

        if (character == character.toUpperCase()) {
          hasUppercase=true;
        }
        if (character == character.toLowerCase()){
          hasLowercase=true;
        }
      }
      i++;
    }
  }
  if(!hasUppercase)
    {
      return "Uppercase missing!";
    }
  else if(!hasLowercase)
  {
    return "Lowercase missing!";
  }
  else if(!hasDigits)
  {
    return "Numeric value missing!";
  }
  else if(!hasSpecialCharacters)
    {
      return "Special character missing!";
    }
  else if(value.length<8)
  {
    return "Password length should be more than 8";
  }
  else{
    return null;
  }
}

//Validation Check For Email
String? emailCheck(String value)
{
  if(value.isEmpty)
    {
      return "Email can't be empty!";
    }
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

  if(!emailValid)
    {
      return "Enter a valid email!";
    }
  else
    {
      return null;
    }
}


//Validation for Phone Number
String? phoneCheck(String value)
{
  if(value.isEmpty)
    {
      return "Phone number can't be empty";
    }
  var i =0;
  bool isAllnum = false;
  while(i<value.length)
    {
      if (isDigit(value[i] , 0))
        {
          isAllnum = true;
        }
      i++;
    }

    if(!isAllnum)
      {
        return "Must be numeric values only!";
      }
    else if(!(value.length==10))
      {
        return "Must be of 10 characters";
      }
    else{
      return null;
    }
}


//Validation For Name
String? nameCheck(String value)
{
  if(value.isEmpty)
    {
      return "Name can't be empty!";
    }
  if(value.length<3)
    {
      return "Must be At least 3 characters";
    }
  else{
    return null;
  }
}


//Validation For description
String? descCheck(String value)
{
  if(value.isEmpty)
    {
      return "Description can't be empty!";
    }
  else{
    return null;
  }
}
