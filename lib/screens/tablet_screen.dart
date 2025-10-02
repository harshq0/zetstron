import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:zetstron/themes/app_text_style.dart';
import 'package:zetstron/themes/app_theme.dart';
import 'package:zetstron/utils/constant.dart';
import 'package:zetstron/widgets/custom_button.dart';
import 'package:zetstron/widgets/custom_container.dart';
import 'package:zetstron/widgets/custom_service_container.dart';

class TabletScreen extends StatefulWidget {
  const TabletScreen({super.key});

  @override
  State<TabletScreen> createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen> {
  String title = 'Home';
  bool isHovering = false;
  int isServiceHover = -1;
  final GlobalKey globalKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  List<Map<String, dynamic>> services = [
    {
      'imagePath': 'assets/png/AI.png',
      'title': 'Business Transformation using Agentic AI',
      'description':
          'Seamless AI adoption and transformation with the power of GenAI and NLP and transforming businesses with Agentic AI that goes beyond automation.',
      'point1': 'AI-Powered Process Automation',
      'point2': 'Intelligent Data Insights',
      'point3': 'GenAI-Driven Customer Experience',
      'point4': 'Scalable Business Transformation',
    },
    {
      'imagePath': 'assets/png/ui-ux.png',
      'title': 'UI Design & UX Research',
      'description':
          'Design engaging, responsive, and user-friendly web solutions with a strong focus on usability.',
      'point1': 'Responsive Design',
      'point2': 'Prototyping & Wireframes',
      'point3': 'SEO Optimization',
      'point4': 'Performance Tuning',
    },
    {
      'imagePath': 'assets/png/mobile-icon.png',
      'title': 'Mobile Application Development',
      'description':
          'Build high-performance native and cross-platform mobile apps for iOS and Android.',
      'point1': 'iOS Development',
      'point2': 'Android Development',
      'point3': 'Cross-Platform Apps',
      'point4': 'App Store Optimization',
    },
    {
      'imagePath': 'assets/png/quality.png',
      'title': 'Quality Assurance & Test Automation',
      'description':
          'Ensure reliability and performance with manual and automated testing solutions.',
      'point1': 'Functional Testing',
      'point2': 'Automated Test Suites',
      'point3': 'Performance Testing',
      'point4': 'Bug Tracking & Reporting',
    },
    {
      'imagePath': 'assets/png/cyber.png',
      'title': 'Cybersecurity & Compliance',
      'description':
          'Protect your business with end-to-end security solutions while ensuring compliance with industry regulations.',
      'point1': 'Threat Monitoring',
      'point2': 'Data Protection',
      'point3': 'Risk Assessments',
      'point4': 'Compliance Audits',
    },
    {
      'imagePath': 'assets/png/devops.png',
      'title': 'DevOps & Infrastructure Automation',
      'description':
          'Accelerate delivery by automating infrastructure, CI/CD, and deployment pipelines.',
      'point1': 'CI/CD Pipelines',
      'point2': 'Cloud Infrastructure',
      'point3': 'Configuration Management',
      'point4': 'Monitoring & Scaling',
    },
    {
      'imagePath': 'assets/png/business.png',
      'title': 'Business Analysis & Product Consulting',
      'description':
          'Bridge business goals with technology through expert consulting and analysis.',
      'point1': 'Requirement Gathering',
      'point2': 'Process Optimization',
      'point3': 'Product Strategy',
      'point4': 'Roadmap Planning',
    },
    {
      'imagePath': 'assets/png/static.png',
      'title': 'Statistics, BI & Advanced Analytics',
      'description':
          'Empower decision-making with data visualization, BI dashboards, and predictive analytics.',
      'point1': 'BI Dashboards',
      'point2': 'Predictive Models',
      'point3': 'Data Visualization',
      'point4': 'Statistical Analysis',
    },
    {
      'imagePath': 'assets/png/data.png',
      'title': 'Data Engineering & ETL Pipelines',
      'description':
          'Turn raw data into usable insights with reliable data pipelines and advanced engineering practices.',
      'point1': 'ETL Development',
      'point2': 'Data Warehousing',
      'point3': 'Real-Time Processing',
      'point4': 'Data Quality Management',
    },
  ];

  List<Map<String, dynamic>> product = [
    {
      'imagePath': 'assets/png/z-product.png',
      'title': 'Tag',
      'description':
          'AI-powered recruitment that simplifies hiring and accelerates onboarding',
    },
    {
      'imagePath': 'assets/png/z-product.png',
      'title': 'Employee',
      'description':
          'Central hub to manage, track, and empower your workforce.',
    },
    {
      'imagePath': 'assets/png/z-product.png',
      'title': 'Projects',
      'description':
          '360° visibility across projects in Telecom, Retail, Banking, and more.',
    },
    {
      'imagePath': 'assets/png/z-product.png',
      'title': 'HR',
      'description':
          'Streamlined HR operations from payroll to performance management.',
    },
    {
      'imagePath': 'assets/png/z-product.png',
      'title': 'Customer',
      'description':
          'Unified client repository to manage relationships and boost engagement.',
    },
    {
      'imagePath': 'assets/png/z-product.png',
      'title': 'Models',
      'description':
          'Seamless integration with AI tools like Copilot and ChatGPT for faster outcomes.',
    },
  ];

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void sendEnquiry() {
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: fullWidth / 1.5,
                maxHeight:
                    MediaQuery.of(context).size.height * 0.9, // ⬅️ limit height
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // shrink to fit
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Let's ",
                            style: TextStyle(
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.buttonColor,
                            ),
                          ),
                          TextSpan(
                            text: "Connect",
                            style: TextStyle(
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    AutoSizeText(
                      "Full Name",
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    contactField(
                      keyboardType: TextInputType.name,
                      hintText: 'Enter Your Name',
                      imagePath: 'assets/png/user.png',
                      controller: nameController,
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Please enter your name'
                                  : null,
                    ),
                    SizedBox(height: 20),
                    AutoSizeText(
                      "Contact Number",
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    contactField(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter Contact Number',
                      imagePath: 'assets/png/call.png',
                      controller: numberController,
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Please enter your contact number'
                                  : null,
                    ),
                    SizedBox(height: 20),
                    AutoSizeText(
                      "Email Id",
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    contactField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter Email ID',
                      imagePath: 'assets/png/mail.png',
                      controller: emailController,
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return 'Please enter your email';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    AutoSizeText(
                      "Description",
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    contactField(
                      maxLines: 3,
                      hintText: 'Enter your message',
                      imagePath: '',
                      controller: descriptionController,
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Please enter your message'
                                  : null,
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          openGmailWeb(
                            toEmail: 'vijayganesh1704@gmail.com',
                            description: descriptionController.text,

                            name: nameController.text,
                            number: numberController.text,
                            email: emailController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffFE6225),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Center(
                          child: AutoSizeText(
                            "Let's Talk",
                            style: TextStyle(
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> openGmailWeb({
    required String toEmail,
    required String description,
    required String name,
    required String number,
    required String email, // sender email
  }) async {
    // Build body with extra details
    final String fullBody = """
Hi Team,

$description

---
Sender Details:
Name   : $name
Number : $number
Email  : $email
""";

    final Uri gmailUrl = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1'
      '&to=$toEmail'
      '&body=${Uri.encodeComponent(fullBody)}',
    );

    if (await canLaunchUrl(gmailUrl)) {
      await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);
      emailController.clear();
      nameController.clear();
      numberController.clear();
      descriptionController.clear();
      bodyController.clear();
    } else {
      throw '❌ Could not open Gmail';
    }
  }

  @override
  void initState() {
    scrollToSection(globalKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fullHeight = MediaQuery.sizeOf(context).height;
    fullWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                toolbarHeight: 100,
                backgroundColor: const Color(0xffFAFAFA),
                surfaceTintColor: Colors.transparent,
                title: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 5,
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/png/zetstron-logo.png', height: 35),
                      SizedBox(width: 120),
                      Row(
                        children: [
                          appBarText(
                            title: 'Home',
                            isActive: title,
                            onTap: () {
                              setState(() => title = 'Home');
                              scrollToSection(globalKey);
                            },
                          ),
                          appBarText(
                            title: 'About Us',
                            isActive: title,
                            onTap: () {
                              setState(() => title = 'About Us');
                              scrollToSection(globalKey);
                            },
                          ),
                          appBarText(
                            title: 'Our Products',
                            isActive: title,
                            onTap: () {
                              setState(() => title = 'Our Products');
                              scrollToSection(globalKey);
                            },
                          ),
                          appBarText(
                            title: 'Services',
                            isActive: title,
                            onTap: () {
                              setState(() => title = 'Services');
                              scrollToSection(globalKey);
                            },
                          ),
                          appBarText(
                            title: 'Contact Us',
                            isActive: title,
                            onTap: () {
                              setState(() => title = 'Contact Us');
                              scrollToSection(globalKey);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Column(
                    key: globalKey,
                    children: [
                      SizedBox(height: 50),
                      Stack(
                        alignment:
                            Alignment.center, // centers children by default
                        children: [
                          // Background image
                          Image.asset('assets/png/z-logo.png', height: 300),

                          // Overlay text in center
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                            ), // optional spacing
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize
                                      .min, // keeps it compact, not full height
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (title == 'Our Products')
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Our ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Products ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Color(0xffFE6225),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'to Power\nYour Digital Journey.',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else if (title == 'Services')
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Our ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Services ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Color(0xffFE6225),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'to Power\nYour Digital Journey.',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else if (title == 'Contact Us')
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Contact ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Zetstron',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Color(0xffFE6225),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else if (title == 'About Us')
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'About ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Zetstron',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Color(0xffFE6225),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Accelerating ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Digital\nTransformation ',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Color(0xffFE6225),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'with AI, Cloud\n& Product Innovation',
                                          style: AppTextStyle.headingTextStyle(
                                            letterSpacing: -2,
                                            fontSize: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AutoSizeText(
                        (title == 'Our Products' ||
                                title == 'Services' ||
                                title == 'Contact Us')
                            ? ''
                            : title == 'About Us'
                            ? 'Zetstron is a technology partner driving business transformation with Agentic AI,\nCloud, and Product Engineering. We help enterprises and SaaS vendors\ninnovate faster, scale smarter, and deliver with confidence. Our flexible engagement\nmodels — from dedicated teams to SLA-driven delivery — ensure predictable\noutcomes and sustainable growth.'
                            : 'We, Zetstron, a lean and agile technology partner powered by our\nAI-driven platform. By combining lean operations with intelligent\nautomation, we position our clients ahead of the competition —\nenabling them to scale with confidence and clarity.',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.contentTextStyle(
                          fontSize: 16,
                          color: Color(0xff3A3A3A),
                        ),
                      ),
                      (title == 'About Us' ||
                              title == 'Our Products' ||
                              title == 'Services' ||
                              title == 'Contact Us')
                          ? SizedBox()
                          : SizedBox(height: 40),
                      (title == 'About Us' ||
                              title == 'Our Products' ||
                              title == 'Services' ||
                              title == 'Contact Us')
                          ? SizedBox()
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              // CustomButton(
                              //   height: 48,
                              //   color: Color(0xffFE6225),
                              //   border: Border.all(color: Colors.transparent),
                              //   title: 'Schedule AI Assesment',
                              //   textColor: Colors.white,
                              //   icon: 'assets/svg/arrow-up-right.svg',
                              //   iconColor: Colors.white,
                              //   padding: EdgeInsets.symmetric(horizontal: 15),
                              // ),
                              MouseRegion(
                                onEnter: (event) {
                                  setState(() {
                                    isHovering = true;
                                  });
                                },
                                onExit: (event) {
                                  setState(() {
                                    isHovering = false;
                                  });
                                },

                                child: CustomButton(
                                  onTap: () => sendEnquiry(),
                                  height: 48,
                                  color:
                                      isHovering
                                          ? Color(0xffFE6225)
                                          : Colors.white,
                                  border: Border.all(
                                    color:
                                        isHovering
                                            ? Colors.transparent
                                            : Color(0xffFE6225),
                                  ),
                                  title: 'Send Request for Enquiry',
                                  textColor:
                                      isHovering
                                          ? Colors.white
                                          : Color(0xffFE6225),
                                  icon: 'assets/svg/arrow-up-right.svg',
                                  iconColor:
                                      isHovering
                                          ? Colors.white
                                          : Color(0xffFE6225),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                ),
                              ),
                            ],
                          ),
                      // SizedBox(height: 160),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: 'Trusted by ',
                      //         style: AppTextStyle.clientTextStyle(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: '1000+ ',
                      //         style: AppTextStyle.clientTextStyle(
                      //           color: Color(0xffFE6225),
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: 'Clients across India',
                      //         style: AppTextStyle.clientTextStyle(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      // AutoSizeText(
                      //   'At Zetstron, our support blends efficiency and care to\ndeliver the results you deserve',
                      //   textAlign: TextAlign.center,
                      //   style: AppTextStyle.contentTextStyle(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      (title == 'About Us' ||
                              title == 'Our Products' ||
                              title == 'Services' ||
                              title == 'Contact Us')
                          ? SizedBox()
                          : SizedBox(height: 150),

                      (title == 'About Us' ||
                              title == 'Our Products' ||
                              title == 'Services' ||
                              title == 'Contact Us')
                          ? SizedBox()
                          : RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '        ZETSTRON\n',

                                  style: AppTextStyle.headingTextStyle(
                                    fontSize: 55,

                                    color: Color(0xffFE6225),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Engagement models ',
                                  style: AppTextStyle.headingTextStyle(
                                    fontSize: 55,

                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                      (title == 'About Us' ||
                              title == 'Our Products' ||
                              title == 'Services' ||
                              title == 'Contact Us')
                          ? SizedBox()
                          : SizedBox(height: 80),
                      Column(
                        children: [
                          (title == 'About Us' ||
                                  title == 'Our Products' ||
                                  title == 'Services' ||
                                  title == 'Contact Us')
                              ? SizedBox()
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 80.0,
                                ),
                                child: Column(
                                  children: [
                                    CustomContainer(
                                      width: fullWidth / 1.4,
                                      padding: EdgeInsets.only(
                                        top: 24,
                                        left: 24,
                                        right: 24,
                                        bottom: 24,
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xffFE6225),
                                          Color(0xfffE5E29),
                                          Color(0xffFFA100),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 20,
                                        children: [
                                          AutoSizeText(
                                            'Dedicated Offshore Team\n(Staff Augmentation)',
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextStyle.containerTextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                ),
                                          ),

                                          Image.asset(
                                            'assets/png/team.png',

                                            height: 200,
                                            colorBlendMode: BlendMode.modulate,
                                          ),

                                          AutoSizeText(
                                            'Access top-tier developers, architects, QA,\nand project managers — seamlessly\nintegrated into your workflows',
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextStyle.container1TextStyle(
                                                  color: Color(0xffE9E9E9),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    CustomContainer(
                                      width: fullWidth / 1.4,
                                      padding: EdgeInsets.only(
                                        top: 24,
                                        left: 24,
                                        right: 24,
                                        bottom: 24,
                                      ),
                                      color: Color(0xffF0F0F0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                  'Fixed-Price Project',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      AppTextStyle.containerTextStyle(
                                                        fontSize: 25,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                Image.asset(
                                                  'assets/png/price.png',
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                                AutoSizeText(
                                                  'Get results quickly with a short, fixed-\nprice project covering key features,\nmigrations, or proof-of-concepts.',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      AppTextStyle.container1TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    CustomContainer(
                                      width: fullWidth / 1.4,
                                      padding: EdgeInsets.only(
                                        top: 24,
                                        left: 24,
                                        right: 24,
                                        bottom: 24,
                                      ),
                                      color: Color(0xffF0F0F0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            'Managed Delivery',
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextStyle.containerTextStyle(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          Image.asset(
                                            'assets/png/time.png',
                                            height: 200,
                                          ),
                                          AutoSizeText(
                                            'Guaranteed outcomes with SLAs,\nproactive monitoring, and 24/7 support.',
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextStyle.container1TextStyle(
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    CustomContainer(
                                      width: fullWidth / 1.4,
                                      padding: EdgeInsets.only(
                                        top: 24,
                                        left: 24,
                                        right: 24,
                                        bottom: 24,
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xffFE6225),
                                          Color(0xfffE5E29),
                                          Color(0xffFFA100),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 20,
                                        children: [
                                          AutoSizeText(
                                            'White-Label Product\nEngineering)',
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextStyle.containerTextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          Image.asset(
                                            'assets/png/laptop.png',
                                            height: 200,
                                          ),

                                          AutoSizeText(
                                            'End-to-end product development\nunder your brand — scale SaaS\nwithout scaling headcount.',
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextStyle.container1TextStyle(
                                                  color: Color(0xffE9E9E9),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          (title == 'Contact Us')
                              ? SizedBox(height: 160)
                              : SizedBox(),
                          (title == 'Contact Us')
                              ? Container(
                                width: fullWidth / 1.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Color(0xffEDE7E5)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffFBE4DB).withOpacity(0.4),
                                      Color(0xffFBE4DB).withOpacity(0.3),
                                      Color(0xffFAFAFA).withOpacity(0.2),

                                      Color(0xffFAFAFA).withOpacity(0.1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(60.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Ready ',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    letterSpacing: -2,
                                                    fontSize: 60,
                                                    color: Color(0xffFE6225),
                                                  ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'to start your journey with us?',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    letterSpacing: -2,
                                                    fontSize: 60,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                      AutoSizeText(
                                        'Address: ',
                                        style: AppTextStyle.contactTextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      AutoSizeText(
                                        'E-101 Palm Riviera, Tmvm Main Road,\nSIPCOT Industrial Area, Thirumudivakkam,\nChennai -600044, Tamil Nadu',
                                        style:
                                            AppTextStyle.contactDetailsTextStyle(
                                              fontSize: 16,
                                              color: Color(0xff323131),
                                            ),
                                      ),
                                      SizedBox(height: 20),
                                      AutoSizeText(
                                        'Contact Us',
                                        style: AppTextStyle.contactTextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Mob No :',
                                              style:
                                                  AppTextStyle.contactDetailsTextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff646464),
                                                  ),
                                            ),
                                            TextSpan(
                                              text: '+91 9894815480',
                                              style:
                                                  AppTextStyle.contactDetailsTextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff323131),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                'Full Name',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              contactField(
                                                keyboardType:
                                                    TextInputType.name,
                                                hintText: 'Enter Your Name',
                                                imagePath:
                                                    'assets/png/user.png',
                                                controller: nameController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 20),
                                              AutoSizeText(
                                                'Contact Number',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              contactField(
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText:
                                                    'Enter Contact Number',
                                                imagePath:
                                                    'assets/png/call.png',
                                                controller: numberController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your contact number';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 20),
                                              AutoSizeText(
                                                'Email Id',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              contactField(
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                hintText: 'Enter Email ID',
                                                imagePath:
                                                    'assets/png/mail.png',
                                                controller: emailController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your email';
                                                  } else if (!RegExp(
                                                    r'^[^@]+@[^@]+\.[^@]+',
                                                  ).hasMatch(value)) {
                                                    return 'Please enter a valid email address';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 20),
                                              AutoSizeText(
                                                'Description',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              contactField(
                                                maxLines: 5,
                                                hintText: 'Enter your message',
                                                imagePath: '',
                                                controller:
                                                    descriptionController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your message';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      openGmailWeb(
                                                        email:
                                                            emailController
                                                                .text,
                                                        name:
                                                            nameController.text,
                                                        number:
                                                            numberController
                                                                .text,
                                                        toEmail:
                                                            'vijayganesh1704@gmail.com',
                                                        description:
                                                            descriptionController
                                                                .text,
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  width: fullWidth,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFE6225),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          9,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 15.0,
                                                        ),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        "Let's Talk",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              GoogleFonts.manrope()
                                                                  .fontFamily,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : SizedBox(),
                          (title == 'About Us' ||
                                  title == 'Our Products' ||
                                  title == 'Services' ||
                                  title == 'Contact Us')
                              ? SizedBox()
                              : SizedBox(height: 100),
                          (title == 'About Us' ||
                                  title == 'Our Products' ||
                                  title == 'Services' ||
                                  title == 'Contact Us')
                              ? SizedBox()
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Our Services to Power\n',

                                          style: AppTextStyle.headingTextStyle(
                                            fontSize: 55,

                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Your ',
                                          style: AppTextStyle.headingTextStyle(
                                            fontSize: 55,

                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Digital Journey.',
                                          style: AppTextStyle.headingTextStyle(
                                            fontSize: 55,

                                            color: Color(0xffFE6225),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          (title == 'About Us')
                              ? SizedBox()
                              : SizedBox(height: 100),
                          (title == 'About Us' ||
                                  title == 'Our Products' ||
                                  title == 'Contact Us')
                              ? SizedBox()
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 80,
                                ),
                                child: SizedBox(
                                  height: 4400,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 26,
                                          mainAxisSpacing: 20,
                                          // childAspectRatio: serviceHeight,
                                          mainAxisExtent: 460,
                                        ),
                                    itemCount: services.length,
                                    itemBuilder: (context, index) {
                                      bool isHover = isServiceHover == index;
                                      return MouseRegion(
                                        onEnter: (event) {
                                          setState(() {
                                            isServiceHover = index;
                                          });
                                        },
                                        onExit: (event) {
                                          setState(() {
                                            isServiceHover = -1;
                                          });
                                        },
                                        child: CustomServiceContainer(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          padding: EdgeInsets.all(30),

                                          // boxShadow:
                                          //     isHover
                                          //         ? [
                                          //           BoxShadow(
                                          //             blurStyle:
                                          //                 BlurStyle.outer,
                                          //             color: Colors.black
                                          //                 .withOpacity(0.7),
                                          //             blurRadius: 20,
                                          //             spreadRadius: 0,
                                          //             offset: Offset(-2, 0),
                                          //           ),
                                          //         ]
                                          //         : [],
                                          border: Border.all(
                                            width: 2,
                                            color:
                                                isHover
                                                    ? Color(0xffFE6225)
                                                    : Color(0xffEDE7E5),
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              // Color(0xffFBE4DB).withOpacity(0.9),
                                              // Color(0xffFBE4DB).withOpacity(0.8),
                                              // Color(0xffFBE4DB).withOpacity(0.7),
                                              // Color(0xffFBE4DB).withOpacity(0.6),
                                              // Color(0xffFBE4DB).withOpacity(0.5),
                                              Color(
                                                0xffFBE4DB,
                                              ).withOpacity(0.4),
                                              Color(
                                                0xffFBE4DB,
                                              ).withOpacity(0.3),
                                              Color(
                                                0xffFAFAFA,
                                              ).withOpacity(0.2),

                                              Color(
                                                0xffFAFAFA,
                                              ).withOpacity(0.1),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffFE6225),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    services[index]['imagePath'],
                                                    height: 32,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 38),
                                              AutoSizeText(
                                                services[index]['title'],
                                                style:
                                                    AppTextStyle.serviceTitleTextStyle(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              SizedBox(height: 16),
                                              AutoSizeText(
                                                services[index]['description'],
                                                style:
                                                    AppTextStyle.serviceSubTitleTextStyle(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                spacing: 8,
                                                children: [
                                                  Image.asset(
                                                    'assets/png/pointer.png',
                                                    height: 24,
                                                  ),
                                                  AutoSizeText(
                                                    services[index]['point1'],
                                                    style:
                                                        AppTextStyle.serviceSubTitleTextStyle(
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                spacing: 8,
                                                children: [
                                                  Image.asset(
                                                    'assets/png/pointer.png',
                                                    height: 24,
                                                  ),
                                                  AutoSizeText(
                                                    services[index]['point2'],
                                                    style:
                                                        AppTextStyle.serviceSubTitleTextStyle(
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                spacing: 8,
                                                children: [
                                                  Image.asset(
                                                    'assets/png/pointer.png',
                                                    height: 24,
                                                  ),
                                                  AutoSizeText(
                                                    services[index]['point3'],
                                                    style:
                                                        AppTextStyle.serviceSubTitleTextStyle(
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                spacing: 8,
                                                children: [
                                                  Image.asset(
                                                    'assets/png/pointer.png',
                                                    height: 24,
                                                  ),
                                                  AutoSizeText(
                                                    services[index]['point4'],
                                                    style:
                                                        AppTextStyle.serviceSubTitleTextStyle(
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                          (title == 'About Us' ||
                                  title == 'Our Products' ||
                                  title == 'Services' ||
                                  title == 'Contact Us')
                              ? SizedBox()
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'z',
                                          style: AppTextStyle.headingTextStyle(
                                            fontSize: 55,
                                            color: Color(0xffFE6225),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Astral',
                                          style: AppTextStyle.headingTextStyle(
                                            fontSize: 55,

                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          title == 'Home' ? SizedBox(height: 80) : SizedBox(),
                          (title == 'About Us' ||
                                  title == 'Services' ||
                                  title == 'Contact Us')
                              ? SizedBox()
                              : Image.asset('assets/png/zastral.png'),
                          (title == 'About Us')
                              ? SizedBox(height: 150)
                              : SizedBox(height: 50),
                          (title == 'About Us')
                              ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/png/vision.png',
                                      // height: 800,
                                      fit: BoxFit.contain,
                                      frameBuilder: (
                                        BuildContext context,
                                        Widget child,
                                        int? frame,
                                        bool wasSynchronouslyLoaded,
                                      ) {
                                        if (wasSynchronouslyLoaded) {
                                          return child;
                                        }
                                        if (frame == null) {
                                          // Still loading → show loader
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xffFE6225),
                                            ),
                                          );
                                        } else {
                                          // ✅ Image loaded → fade in
                                          return AnimatedOpacity(
                                            opacity: 1,
                                            duration: const Duration(
                                              seconds: 1,
                                            ), // slow fade
                                            curve: Curves.easeInOut,
                                            child: child,
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    Image.asset(
                                      'assets/png/mission.png',
                                      // height: 800,
                                      fit: BoxFit.contain,
                                      frameBuilder: (
                                        BuildContext context,
                                        Widget child,
                                        int? frame,
                                        bool wasSynchronouslyLoaded,
                                      ) {
                                        if (wasSynchronouslyLoaded) {
                                          return child;
                                        }
                                        if (frame == null) {
                                          // Still loading → show loader
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xffFE6225),
                                            ),
                                          );
                                        } else {
                                          // ✅ Image loaded → fade in
                                          return AnimatedOpacity(
                                            opacity: 1,
                                            duration: const Duration(
                                              seconds: 1,
                                            ), // slow fade
                                            curve: Curves.easeInOut,
                                            child: child,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                              : SizedBox(),

                          (title == 'About Us')
                              ? SizedBox(height: 150)
                              : SizedBox(),
                          (title == 'About Us')
                              ? Container(
                                width: fullWidth,
                                decoration: BoxDecoration(
                                  color: Color(0xffFAF2EF),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 40.0,
                                        horizontal: 20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'We ',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: 'Build ',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Color(
                                                          0xffFE6225,
                                                        ),
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: 'With ',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: 'Care',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Color(
                                                          0xffFE6225,
                                                        ),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'We ',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: 'Scale ',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Color(
                                                          0xffFE6225,
                                                        ),
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: 'With ',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: 'Clarity',
                                                  style:
                                                      AppTextStyle.headingTextStyle(
                                                        letterSpacing: -2,
                                                        fontSize: 40,
                                                        color: Color(
                                                          0xffFE6225,
                                                        ),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          AutoSizeText(
                                            'Partnering with enterprises worldwide to drive transformation,\nfoster innovation, and help them scale and thrive through\nAgentic AI, cloud, and modern engineering.',
                                            style: TextStyle(
                                              fontFamily:
                                                  GoogleFonts.manrope()
                                                      .fontFamily,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 50),
                                          AutoSizeText(
                                            '- Vijay Ganesh CEO',
                                            style: TextStyle(
                                              fontFamily:
                                                  GoogleFonts.manrope()
                                                      .fontFamily,
                                              color: Color(0xffFE6225),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/png/vision-icon.png',
                                      height: 310,
                                    ),
                                  ],
                                ),
                              )
                              : SizedBox(),

                          title == 'Home' ? SizedBox(height: 80) : SizedBox(),

                          (title == 'Home' || title == 'Our Products')
                              ? RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'z',
                                      style: AppTextStyle.headingTextStyle(
                                        fontSize: 55,
                                        color: Color(0xffFE6225),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Astral Products',
                                      style: AppTextStyle.headingTextStyle(
                                        fontSize: 55,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : SizedBox(),
                          title == 'Home' ? SizedBox(height: 80) : SizedBox(),
                          title == 'Our Products'
                              ? SizedBox(height: 80)
                              : SizedBox(),
                          (title == 'About Us' ||
                                  title == 'Services' ||
                                  title == 'Contact Us')
                              ? SizedBox()
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 80,
                                ),
                                child: SizedBox(
                                  height: 2100,
                                  child: GridView.builder(
                                    itemCount: product.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisExtent: 350,
                                        ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 20.0,
                                        ),
                                        child: CustomServiceContainer(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          padding: EdgeInsets.all(30),
                                          border: Border.symmetric(
                                            vertical: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                204,
                                                183,
                                              ).withOpacity(0.2),
                                            ),
                                            horizontal: BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                204,
                                                183,
                                              ).withOpacity(0.2),
                                            ),
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(
                                                0xffFBE4DB,
                                              ).withOpacity(0.4),
                                              Color(
                                                0xffFBE4DB,
                                              ).withOpacity(0.3),
                                              Color(
                                                0xffFAFAFA,
                                              ).withOpacity(0.2),

                                              Color(
                                                0xffFAFAFA,
                                              ).withOpacity(0.1),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    product[index]['imagePath'],
                                                    height: 32,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 24),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          index ==
                                                                  product.length -
                                                                      1
                                                              ? 'AI '
                                                              : 'z',
                                                      style:
                                                          AppTextStyle.serviceTitleTextStyle(
                                                            color: Color(
                                                              0xffFE6225,
                                                            ),
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          product[index]['title'],
                                                      style:
                                                          AppTextStyle.serviceTitleTextStyle(
                                                            color: Colors.black,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              AutoSizeText(
                                                product[index]['description'],
                                                style:
                                                    AppTextStyle.serviceSubTitleTextStyle(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          (title == 'Home' ||
                                  title == 'About Us' ||
                                  title == 'Our Products')
                              ? SizedBox(height: 140)
                              : SizedBox(),
                          Stack(
                            children: [
                              Image.asset(
                                'assets/png/bottom-gradient.png',
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                              Column(
                                children: [
                                  // SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Join ',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    fontSize: 60,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: 'Our ',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    fontSize: 60,
                                                    color: AppTheme.buttonColor,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: 'Community',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    fontSize: 60,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  AutoSizeText(
                                    'Be part of a unified space where people, projects, and\noperations thrive with AI-powered efficiency',
                                    style: AppTextStyle.communityTextTextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 16,
                                    children: [
                                      mediaIcons(
                                        mediaName: 'Instagram',
                                        onTap: () {},
                                      ),
                                      mediaIcons(
                                        mediaName: 'linkedin',
                                        onTap: () {},
                                      ),
                                      mediaIcons(
                                        mediaName: 'Youtube',
                                        onTap: () {},
                                      ),
                                      mediaIcons(
                                        mediaName: 'Telegram',
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: fullWidth,
                            decoration: BoxDecoration(color: Color(0xff000000)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0,
                                    vertical: 40.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/png/zetstron-logo.png',
                                        height: 50,
                                      ),
                                      SizedBox(height: 40),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'With ',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    fontSize: 22,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: 'Zetstron',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    fontSize: 22,
                                                    color: AppTheme.buttonColor,
                                                  ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ', you’re not just\na client — you’re a partner',
                                              style:
                                                  AppTextStyle.communityTextStyle(
                                                    fontSize: 22,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 60),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            'Address:',
                                            style:
                                                AppTextStyle.containerTextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          SizedBox(height: 15),

                                          AutoSizeText(
                                            'E-101 Palm Riviera, Tmvm Main Road,\nSIPCOT Industrial Area, Thirumudivakkam,\nChennai -600044, Tamil Nadu',
                                            style:
                                                AppTextStyle.containerTextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff8A8889),
                                                ),
                                          ),
                                          SizedBox(height: 20),
                                          AutoSizeText(
                                            'Contact Us',
                                            style:
                                                AppTextStyle.containerTextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          SizedBox(height: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    'Mob No:',
                                                    style:
                                                        AppTextStyle.containerTextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  AutoSizeText(
                                                    ' +91 9894815480',
                                                    style:
                                                        AppTextStyle.containerTextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                            0xff8A8889,
                                                          ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0,
                                  ),
                                  child: Divider(
                                    color: Color(0xff221C1A),
                                    thickness: 1,
                                  ),
                                ),

                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 40.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                '@2025 | Zetstron',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffABABAB),
                                                ),
                                              ),
                                              AutoSizeText(
                                                'Copyrights | @2025',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffABABAB),
                                                ),
                                              ),
                                              AutoSizeText(
                                                'CIN : U62011TN2025PTC181804',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffABABAB),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        // Image.asset(
                                        //   'assets/png/z-bottom-gradient.png',
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 150.0,
                                          ),
                                          child: Image.asset(
                                            'assets/png/Zetstron.png',
                                          ),
                                        ),
                                        // SvgPicture.asset(
                                        //   'assets/svg/z-bottom-gradient.svg',
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   bottom: 30,
          //   left: 400,
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           RichText(
          //             text: TextSpan(
          //               children: [
          //                 TextSpan(
          //                   text: 'Join',
          //                   style: AppTextStyle.communityTextStyle(
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //                 TextSpan(
          //                   text: 'Our',
          //                   style: AppTextStyle.communityTextStyle(
          //                     color: AppTheme.buttonColor,
          //                   ),
          //                 ),
          //                 TextSpan(
          //                   text: 'Community',
          //                   style: AppTextStyle.communityTextStyle(
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

          // Positioned(
          //   left: 0,
          //   top: 500,
          //   child: Image.asset('assets/png/left-gradient.png', height: 350),

          //   // Container(
          //   //   height: 210,
          //   //   width: 100,
          //   //   decoration: BoxDecoration(
          //   //     borderRadius: BorderRadius.only(
          //   //       bottomRight: Radius.circular(100),
          //   //       topRight: Radius.circular(100),
          //   //     ),
          //   //     gradient: RadialGradient(
          //   //       radius: 1.3,
          //   //       center: Alignment.centerLeft,
          //   //       colors: [
          //   //         Color(0xffFBE4DB).withOpacity(0.9),
          //   //         Color(0xffFBE4DB).withOpacity(0.8),
          //   //         Color(0xffFBE4DB).withOpacity(0.7),
          //   //         Color(0xffFBE4DB).withOpacity(0.6),
          //   //         Color(0xffFBE4DB).withOpacity(0.5),
          //   //         Color(0xffFBE4DB).withOpacity(0.4),
          //   //         Color(0xffFBE4DB).withOpacity(0.3),
          //   //         Color(0xffFAFAFA).withOpacity(0.2),
          //   //         Color(0xffFAFAFA).withOpacity(0.1),
          //   //         Color(0xffFAFAFA).withOpacity(0.1),
          //   //         Color(0xffFAFAFA).withOpacity(0.1),
          //   //       ],
          //   //     ),
          //   //   ),
          //   // ),
          // ),
          // Positioned(
          //   right: 0,
          //   top: 500,
          //   child: Image.asset('assets/png/right-gradient.png', height: 350),
          //   // Container(
          //   //   height: 210,
          //   //   width: 100,
          //   //   decoration: BoxDecoration(
          //   //     borderRadius: BorderRadius.only(
          //   //       bottomLeft: Radius.circular(100),
          //   //       topLeft: Radius.circular(100),
          //   //     ),
          //   //     gradient: RadialGradient(
          //   //       radius: 1.3,
          //   //       center: Alignment.centerRight,
          //   //       colors: [
          //   //         Color(0xffFBE4DB).withOpacity(0.9),
          //   //         Color(0xffFBE4DB).withOpacity(0.8),
          //   //         Color(0xffFBE4DB).withOpacity(0.7),
          //   //         Color(0xffFBE4DB).withOpacity(0.6),
          //   //         Color(0xffFBE4DB).withOpacity(0.5),
          //   //         Color(0xffFBE4DB).withOpacity(0.4),
          //   //         Color(0xffFBE4DB).withOpacity(0.3),
          //   //         Color(0xffFAFAFA).withOpacity(0.2),
          //   //         Color(0xffFAFAFA).withOpacity(0.1),
          //   //         Color(0xffFAFAFA).withOpacity(0.1),
          //   //         Color(0xffFAFAFA).withOpacity(0.1),
          //   //       ],
          //   //     ),
          //   //   ),
          //   // ),
          // ),
          // Positioned(
          //   right: 0,
          //   top: 0,
          //   child: Image.asset('assets/png/top-gradient.png', height: 300),
          //   // Container(
          //   //   height: 250,
          //   //   width: 250,
          //   //   decoration: BoxDecoration(
          //   //     borderRadius: BorderRadius.only(
          //   //       bottomLeft: Radius.circular(500),
          //   //     ),
          //   //     gradient: RadialGradient(
          //   //       radius: 1.0,
          //   //       center: Alignment.topRight,
          //   //       colors: [
          //   //         Color(0xffFBE4DB).withOpacity(0.9),
          //   //         Color(0xffFBE4DB).withOpacity(0.8),
          //   //         Color(0xffFBE4DB).withOpacity(0.7),
          //   //         Color(0xffFBE4DB).withOpacity(0.6),
          //   //         Color(0xffFBE4DB).withOpacity(0.5),
          //   //         Color(0xffFBE4DB).withOpacity(0.4),
          //   //         Color(0xffFBE4DB).withOpacity(0.3),
          //   //         Color(0xffFAFAFA).withOpacity(0.2),
          //   //         Color(0xffFAFAFA).withOpacity(0.1),
          //   //       ],
          //   //     ),
          //   //   ),
          //   // ),
          // ),
        ],
      ),
    );
  }

  Widget contactField({
    required String hintText,
    required String? imagePath,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int? maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(
        fontFamily: GoogleFonts.manrope().fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        prefixIcon:
            (imagePath != '' || imagePath!.isNotEmpty)
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
                    child: Image.asset(
                      imagePath!,
                      height: 20,
                      color: Color(0xff8D8D8D),
                    ),
                  ),
                )
                : null,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.manrope().fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 237, 37, 23)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 237, 37, 23)),
        ),
        errorStyle: TextStyle(
          color: const Color.fromARGB(255, 237, 37, 23),
          fontFamily: GoogleFonts.manrope().fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xffC6C6C6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff4184E1)),
        ),
      ),
    );
  }

  Widget menu({required String text, required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AutoSizeText(
        text,
        style: AppTextStyle.containerTextStyle(
          fontSize: 16,
          color: Color(0xff8A8889),
        ),
      ),
    );
  }

  // Widget productContainer({required double height, required double width, ti}) {
  //   return Container(
  //     height: height,
  //     width: width,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(9),
  //         topRight: Radius.circular(9),
  //       ),

  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(14.0),
  //       child: Column(children: [
  //         AutoSizeText(data)

  //       ],),
  //     ),
  //   );
  // }

  Widget mediaIcons({
    required void Function()? onTap,
    required String mediaName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/png/$mediaName.png', height: 50),
    );
  }

  Widget appBarText({
    required String title,
    void Function()? onTap,
    required String isActive,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color:
                isActive == title ? AppTheme.buttonColor : Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 20.5),
          child: AutoSizeText(
            title,

            style: AppTextStyle.appBarButtonTextStyle(
              color: isActive == title ? AppTheme.buttonColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
