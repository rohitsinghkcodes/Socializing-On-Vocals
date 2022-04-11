import 'package:flutter/material.dart';
import 'package:socializing_on_vocals/helper/colors.dart';
import 'package:socializing_on_vocals/helper/constants.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  static const id = "terms_and_conditions_screen";

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
    Center(child:  Text('Terms',style:  TextStyle(color: Colors.deepPurple,fontSize: 18,fontWeight: FontWeight.bold),)),
    Center(child:  Text(' & ',style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
    Center(child:  Text('Conditions',style:  TextStyle(color: Colors.deepPurple,fontSize: 18,fontWeight: FontWeight.bold),)),
    ],),
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
                child: Text("These terms and conditions (“Agreement”) set forth the general terms and conditions of your "
                    "use of the “SOV” mobile application (“Mobile Application” or “Service”) and any of its related "
                    "products and services (collectively, “Services”). This Agreement is legally binding between you "
                    "(“User”, “you” or “your”) and this Mobile Application developer (“Operator”, “we”, “us” or “our”). "
                    "If you are entering into this agreement on behalf of a business or other legal entity, you represent "
                    "that you have the authority to bind such entity to this agreement, in which case the terms “User”, "
                    "“you” or “your” shall refer to such entity. If you do not have such authority, or if you do not "
                    "agree with the terms of this agreement, you must not accept this agreement and may not access and "
                    "use the Mobile Application and Services. By accessing and using the Mobile Application and Services, "
                    "you acknowledge that you have read, understood, and agree to be bound by the terms of this Agreement."
                    " You acknowledge that this Agreement is a contract between you and the Operator, even though it "
                    "is electronic and is not physically signed by you, and it governs your use of the Mobile "
                    "Application and Services.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Accounts and Membership", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("You must be at least 13 years of age to use the Mobile Application and Services. "
                    "By using the Mobile Application and Services and by agreeing to this Agreement you "
                    "warrant and represent that you are at least 13 years of age. If you create an account "
                    "in the Mobile Application, you are responsible for maintaining the security of your "
                    "account and you are fully responsible for all activities that occur under the account "
                    "and any other actions taken in connection with it. We may, but have no obligation to, "
                    "monitor and review new accounts before you may sign in and start using the Services. "
                    "Providing false contact information of any kind may result in the termination of your "
                    "account. You must immediately notify us of any unauthorized uses of your account or "
                    "any other breaches of security. We will not be liable for any acts or omissions by "
                    "you, including any damages of any kind incurred as a result of such acts or omissions. "
                    "We may suspend, disable, or delete your account (or any part thereof) if we determine "
                    "that you have violated any provision of this Agreement or that your conduct or content"
                    " would tend to damage our reputation and goodwill. If we delete your account for the "
                    "foregoing reasons, you may not re-register for our Services. We may block your email "
                    "address and Internet protocol address to prevent further registration.", style: content),
              ),
              const SizedBox(height: 15),
              Text("User Content", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("We do not own any data, information or material (collectively, “Content”) "
                    "that you submit in the Mobile Application in the course of using the Service. "
                    "You shall have sole responsibility for the accuracy, quality, integrity, "
                    "legality, reliability, appropriateness, and intellectual property ownership "
                    "or right to use of all submitted Content. We may, but have no obligation to, monitor "
                    "and review the Content in the Mobile Application submitted or created using our "
                    "Services by you. You grant us permission to access, copy, distribute, store, "
                    "transmit, reformat, display and perform the Content of your user account solely "
                    "as required for the purpose of providing the Services to you. Without limiting "
                    "any of those representations or warranties, we have the right, though not the "
                    "obligation, to, in our own sole discretion, refuse or remove any Content that,"
                    " in our reasonable opinion, violates any of our policies or is in any way "
                    "harmful or objectionable. You also grant us the license to use, reproduce, "
                    "adapt, modify, publish or distribute the Content created by you or stored in "
                    "your user account for commercial, marketing or any similar purpose.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Backups", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("We perform regular backups of the Content, however, these backups are for "
                    "our own administrative purposes only and are in no way guaranteed. You are "
                    "responsible for maintaining your own backups of your data. We do not provide"
                    " any sort of compensation for lost or incomplete data in the event that "
                    "backups do not function properly. We will do our best to ensure complete "
                    "and accurate backups, but assume no responsibility for this duty.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Links to Other Resources", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Although the Mobile Application and Services may link to other resources "
                    "(such as websites, mobile applications, etc.), we are not, directly or "
                    "indirectly, implying any approval, association, sponsorship, endorsement, "
                    "or affiliation with any linked resource, unless specifically stated herein."
                    " We are not responsible for examining or evaluating, and we do not warrant "
                    "the offerings of, any businesses or individuals or the content of their "
                    "resources. We do not assume any responsibility or liability for the actions, "
                    "products, services, and content of any other third parties. You should carefully "
                    "review the legal statements and other conditions of use of any resource which "
                    "you access through a link in the Mobile Application. Your linking to any other "
                    "off-site resources is at your own risk.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Intellectual Property Rights", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("“Intellectual Property Rights” means all present and future rights conferred "
                    "by statute, common law or equity in or in relation to any copyright and related"
                    " rights, trademarks, designs, patents, inventions, goodwill and the right to "
                    "sue for passing off, rights to inventions, rights to use, and all other "
                    "intellectual property rights, in each case whether registered or unregistered "
                    "and including all applications and rights to apply for and be granted, rights "
                    "to claim priority from, such rights and all similar or equivalent rights or "
                    "forms of protection and any other results of intellectual activity which "
                    "subsist or will subsist now or in the future in any part of the world. This "
                    "Agreement does not transfer to you any intellectual property owned by the "
                    "Operator or third parties, and all rights, titles, and interests in and to "
                    "such property will remain (as between the parties) solely with the Operator. "
                    "All trademarks, service marks, graphics and logos used in connection with "
                    "the Mobile Application and Services, are trademarks or registered trademarks "
                    "of the Operator or its licensors. Other trademarks, service marks, graphics "
                    "and logos used in connection with the Mobile Application and Services may be "
                    "the trademarks of other third parties. Your use of the Mobile Application and "
                    "Services grants you no right or license to reproduce or otherwise use any of "
                    "the Operator or third party trademarks.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Indemnification", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("You agree to indemnify and hold the Operator and its affiliates, "
                    "directors, officers, employees, agents, suppliers and licensors "
                    "harmless from and against any liabilities, losses, damages or costs, "
                    "including reasonable attorneys’ fees, incurred in connection with or "
                    "arising from any third party allegations, claims, actions, disputes, "
                    "or demands asserted against any of them as a result of or relating to"
                    " your Content, your use of the Mobile Application and Services or any"
                    " willful misconduct on your part.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Dispute Resolution", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("The formation, interpretation, and performance of this Agreement and any "
                    "disputes arising out of it shall be governed by the substantive and procedural "
                    "laws of Uttar Pradesh, India without regard to its rules on conflicts or choice"
                    " of law and, to the extent applicable, the laws of India. The exclusive "
                    "jurisdiction and venue for actions related to the subject matter hereof shall "
                    "be the courts located in Uttar Pradesh, India, and you hereby submit to the "
                    "personal jurisdiction of such courts. You hereby waive any right to a jury trial"
                    " in any proceeding arising out of or related to this Agreement. The United "
                    "Nations Convention on Contracts for the International Sale of Goods does not "
                    "apply to this Agreement.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Changes and Amendments", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("We reserve the right to modify this Agreement or its terms related to the "
                    "Mobile Application and Services at any time at our discretion. When we do, "
                    "we will revise the updated date at the bottom of this page. We may also provide"
                    " notice to you in other ways at our discretion, such as through the contact "
                    "information you have provided.", style: content),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("An updated version of this Agreement will be effective immediately upon the posting "
                    "of the revised Agreement unless otherwise specified. Your continued use of the Mobile"
                    " Application and Services after the effective date of the revised Agreement (or such "
                    "other act specified at that time) will constitute your consent to those changes.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Acceptance of these Terms", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("You acknowledge that you have read this Agreement and agree to all its terms and conditions."
                    " By accessing and using the Mobile Application and Services you agree to be bound by this "
                    "Agreement. If you do not agree to abide by the terms of this Agreement, you are not authorized "
                    "to access or use the Mobile Application and Services.  This terms and conditions policy was created"
                    " with the terms and conditions generator.", style: content),
              ),
              const SizedBox(height: 15),
              Text("Contacting Us", style: headingStyle),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("If you have any questions, concerns, or complaints regarding this Agreement, "
                    "we encourage you to contact us at: socializing.on.vocals@gmail.com", style: content),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("This document was last updated on March 8, 2022", style: content),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
