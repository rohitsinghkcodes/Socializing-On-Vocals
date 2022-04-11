import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/helper/constants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);
  static const id = "privacy_policy_screen";

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF000000),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(child:  Text('Privacy  ',style:  TextStyle(color: Colors.deepPurple,fontSize: 18,fontWeight: FontWeight.bold),)),
              Center(child:  Text('Policy',style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            ],
          ),
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.ac_unit_rounded)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "SOV Team built the SOV app as a Free app. This SERVICE is provided by SOV Team at no cost and"
                        " is intended for use as is. This page is used to inform visitors regarding our policies with the"
                        " collection, use, and disclosure of Personal Information if anyone decided to use our Service."
                        " If you choose to use our Service, then you agree to the collection and use of information in "
                        "relation to this policy. The Personal Information that we collect is used for providing and "
                        "improving the Service. We will not use or share your information with anyone except as "
                        "described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings "
                        "as in our Terms and Conditions, which are accessible at SOV unless otherwise defined in "
                        "this Privacy Policy.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Information Collection and Use", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                    "For a better experience, while using our Service, we may require you to provide us with "
                        "certain personally identifiable information, including but not limited to username, password,"
                        " phone number, name. The information that we request will be retained on your device and is "
                        "not collected by us in any way. The app does use third-party services that may collect "
                        "information used to identify you.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Log Data", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "We want to inform you that whenever you use our Service, in a case of an error in the app "
                        "We collect data and information (through third-party products) on your phone called Log "
                        "Data. This Log Data may include information such as your device Internet Protocol (“IP”)"
                        " address, device name, operating system version, the configuration of the app when "
                        "utilizing our Service, the time and date of your use of the Service, and other "
                        "statistics.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Cookies", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "Cookies are files with a small amount of data that are commonly used as anonymous unique "
                        "identifiers. These are sent to your browser from the websites that you visit and are "
                        "stored on your device's internal memory.\n\nThis Service does not use these “cookies” "
                        "explicitly. However, the app may use third-party code and libraries that use “cookies”"
                        " to collect information and improve their services. You have the option to either "
                        "accept or refuse these cookies and know when a cookie is being sent to your device. \n\n"
                        "If you choose to refuse our cookies, you may not be able to use some portions of "
                        "this Service.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Service Providers", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "We may employ third-party companies and individuals due to the following reasons:\n\n"
                        "1. To facilitate our Service;\n"
                        "2. To provide the Service on our behalf;\n"
                        "3. To perform Service-related services; or\n"
                        "4. To assist us in analyzing how our Service is used.\n\n"
                        "We want to inform users of this Service that these third parties have access to "
                        "their Personal Information. The reason is to perform the tasks assigned to them "
                        "on our behalf. However, they are obligated not to disclose or use the information "
                        "for any other purpose.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Security", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "We value your trust in providing us your Personal Information, thus we are striving to"
                        " use commercially acceptable means of protecting it. But remember that no method of "
                        "transmission over the internet, or method of electronic storage is 100% secure and "
                        "reliable, and We cannot guarantee its absolute security.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Links to Other Sites", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "This Service may contain links to other sites. If you click on a third-party link, "
                        "you will be directed to that site. Note that these external sites are not operated "
                        "by us. Therefore, We strongly advise you to review the Privacy Policy of these websites."
                        " We have no control over and assume no responsibility for the content, privacy policies,"
                        " or practices of any third-party sites or services.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Children’s Privacy", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "These Services do not address anyone under the age of 13. We do not knowingly collect "
                        "personally identifiable information from children under 13 years of age. In the case "
                        "We discover that a child under 13 has provided us with personal information, we immediately"
                        " delete this from our servers. If you are a parent or guardian and you are aware that "
                        "your child has provided us with personal information, please contact us so that We will "
                        "be able to do the necessary actions.",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Changes to This Privacy Policy", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "We may update our Privacy Policy from time to time. Thus, you are advised to review this"
                        " page periodically for any changes. We will notify you of any changes by posting the "
                        "new Privacy Policy on this page.\n\n"
                        "This policy is effective as of 2022-03-12",
                    style: content),
              ),
              const SizedBox(height: 15),
              Text("Contact Us", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    "If you have any questions or suggestions about our Privacy Policy, do not hesitate "
                        "to contact us at : socializing.on.vocals@gmail.com.\n",
                    style: content),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
