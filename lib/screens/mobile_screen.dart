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

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
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
                    vertical: 20,
                    horizontal: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/png/zetstron-logo.png', height: 30),
                      PopupMenuButton(
                        color: Color(0xffFAFAFA),
                        icon: Icon(Icons.menu_outlined),

                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                child: Text(
                                  'Home',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  setState(() => title = 'Home');
                                  scrollToSection(globalKey);
                                },
                              ),
                              PopupMenuItem(
                                child: Text(
                                  'About Us',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  setState(() => title = 'About Us');
                                  scrollToSection(globalKey);
                                },
                              ),
                              PopupMenuItem(
                                child: Text(
                                  'Our Products',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  setState(() => title = 'Our Products');
                                  scrollToSection(globalKey);
                                },
                              ),
                              PopupMenuItem(
                                child: Text(
                                  'Services',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  setState(() => title = 'Services');
                                  scrollToSection(globalKey);
                                },
                              ),
                              PopupMenuItem(
                                child: Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                                ),

                                onTap: () {
                                  setState(() => title = 'Contact Us');
                                  scrollToSection(globalKey);
                                },
                              ),
                            ],
                      ),
                      // Row(
                      //   children: [
                      //     appBarText(
                      //       title: 'Home',
                      //       isActive: title,
                      //       onTap: () {
                      //         setState(() => title = 'Home');
                      //         scrollToSection(globalKey);
                      //       },
                      //     ),
                      //     appBarText(
                      //       title: 'About Us',
                      //       isActive: title,
                      //       onTap: () {
                      //         setState(() => title = 'About Us');
                      //         scrollToSection(globalKey);
                      //       },
                      //     ),
                      //     appBarText(
                      //       title: 'Our Products',
                      //       isActive: title,
                      //       onTap: () {
                      //         setState(() => title = 'Our Products');
                      //         scrollToSection(globalKey);
                      //       },
                      //     ),
                      //     appBarText(
                      //       title: 'Services',
                      //       isActive: title,
                      //       onTap: () {
                      //         setState(() => title = 'Services');
                      //         scrollToSection(globalKey);
                      //       },
                      //     ),
                      //     appBarText(
                      //       title: 'Contact Us',
                      //       isActive: title,
                      //       onTap: () {
                      //         setState(() => title = 'Contact Us');
                      //         scrollToSection(globalKey);
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      key: globalKey,
                      children: [
                        Stack(
                          alignment:
                              Alignment.center, // centers children by default
                          children: [
                            // Background image
                            Image.asset('assets/png/z-logo.png', height: 250),

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
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Products ',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
                                                  color: Color(0xffFE6225),
                                                ),
                                          ),
                                          TextSpan(
                                            text:
                                                'to Power\nYour Digital Journey.',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
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
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Services ',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
                                                  color: Color(0xffFE6225),
                                                ),
                                          ),
                                          TextSpan(
                                            text:
                                                'to Power\nYour Digital Journey.',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
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
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Zetstron',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
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
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Zetstron',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 34,
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
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 28,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Digital\nTransformation ',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 28,
                                                  color: Color(0xffFE6225),
                                                ),
                                          ),
                                          TextSpan(
                                            text:
                                                'with AI, Cloud\n& Product Innovation',
                                            style:
                                                AppTextStyle.headingTextStyle(
                                                  letterSpacing: -2,
                                                  fontSize: 28,
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
                        (title == 'Home' || title == 'About Us')
                            ? SizedBox(height: 20)
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: AutoSizeText(
                            (title == 'Our Products' ||
                                    title == 'Services' ||
                                    title == 'Contact Us')
                                ? ''
                                : title == 'About Us'
                                ? 'Zetstron is a technology partner driving business transformation with Agentic AI, Cloud, and Product Engineering. We help enterprises and SaaS vendors innovate faster, scale smarter, and deliver with confidence. Our flexible engagement models — from dedicated teams to SLA-driven delivery — ensure predictable outcomes and sustainable growth.'
                                : 'We, Zetstron, a lean and agile technology partner powered by our AI-driven platform. By combining lean operations with intelligent automation, we position our clients ahead of the competition — enabling them to scale with confidence and clarity.',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.contentTextStyle(
                              fontSize: 14,
                              color: Color(0xff3A3A3A),
                            ),
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
                                    onTap: () {
                                      setState(() => title = 'Contact Us');
                                      scrollToSection(globalKey);
                                    },
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        // SizedBox(height: 160),
                        // AutoSizeText.rich(
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
                            : SizedBox(height: 100),

                        (title == 'About Us' ||
                                title == 'Our Products' ||
                                title == 'Services' ||
                                title == 'Contact Us')
                            ? SizedBox()
                            : AutoSizeText.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '        ZETSTRON\n',

                                    style: AppTextStyle.headingTextStyle(
                                      letterSpacing: -1,
                                      fontSize: 36,
                                      color: Color(0xffFE6225),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Engagement Models ',
                                    style: AppTextStyle.headingTextStyle(
                                      letterSpacing: -1,
                                      fontSize: 36,
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
                            : SizedBox(height: 50),
                        Column(
                          children: [
                            (title == 'About Us' ||
                                    title == 'Our Products' ||
                                    title == 'Services' ||
                                    title == 'Contact Us')
                                ? SizedBox()
                                : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Column(
                                    spacing: 20,
                                    children: [
                                      CustomContainer(
                                        width: fullWidth / 1.2,
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
                                          spacing: 30,
                                          children: [
                                            Image.asset(
                                              'assets/png/team.png',
                                              height: 200,
                                            ),
                                            AutoSizeText(
                                              'Dedicated Offshore Team (Staff Augmentation)',
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTextStyle.containerTextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white,
                                                  ),
                                            ),

                                            AutoSizeText(
                                              'Access top-tier developers, architects, QA, and project managers — seamlessly integrated into your workflows',
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTextStyle.container1TextStyle(
                                                    color: Color(0xffE9E9E9),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      CustomContainer(
                                        width: fullWidth / 1.2,
                                        padding: EdgeInsets.only(
                                          top: 24,
                                          left: 24,
                                          right: 24,
                                          bottom: 24,
                                        ),
                                        color: Color(0xffF0F0F0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: Image.asset(
                                                'assets/png/price.png',
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20.0,
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
                                                          fontSize: 24,
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  AutoSizeText(
                                                    'Get results quickly with a short, fixed-price project covering key features,migrations, or proof-of-concepts.',
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

                                      CustomContainer(
                                        width: fullWidth / 1.2,
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
                                            Center(
                                              child: Image.asset(
                                                'assets/png/time.png',
                                                height: 200,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            AutoSizeText(
                                              'Managed Delivery',
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTextStyle.containerTextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                            SizedBox(height: 10),
                                            AutoSizeText(
                                              'Guaranteed outcomes with SLAs, proactive monitoring, and 24/7 support.',
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTextStyle.container1TextStyle(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      CustomContainer(
                                        width: fullWidth / 1.2,
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
                                          spacing: 30,
                                          children: [
                                            Image.asset(
                                              'assets/png/laptop.png',
                                              height: 200,
                                            ),
                                            AutoSizeText(
                                              'White-Label Product Engineering)',
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTextStyle.containerTextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white,
                                                  ),
                                            ),

                                            AutoSizeText(
                                              'End-to-end product development under your brand — scale SaaS without scaling headcount.',
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
                                ? SizedBox(height: 80)
                                : SizedBox(),
                            (title == 'Contact Us')
                                ? Container(
                                  width: fullWidth / 1.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xffEDE7E5),
                                    ),
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
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AutoSizeText.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Ready ',
                                                  style:
                                                      AppTextStyle.communityTextStyle(
                                                        height: -1,
                                                        letterSpacing: -1,
                                                        fontSize: 45,
                                                        color: Color(
                                                          0xffFE6225,
                                                        ),
                                                      ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      'to start your journey with us?',
                                                  style:
                                                      AppTextStyle.communityTextStyle(
                                                        height: -1,
                                                        letterSpacing: -1,
                                                        fontSize: 45,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          AutoSizeText(
                                            'Address: ',
                                            style:
                                                AppTextStyle.contactTextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          SizedBox(height: 12),
                                          AutoSizeText(
                                            'E-101 Palm Riviera, Tmvm Main Road,\nSIPCOT Industrial Area, Thirumudivakkam,\nChennai -600044, Tamil Nadu',
                                            style:
                                                AppTextStyle.contactDetailsTextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xff323131),
                                                ),
                                          ),
                                          SizedBox(height: 20),
                                          AutoSizeText(
                                            'Contact Us',
                                            style:
                                                AppTextStyle.contactTextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          SizedBox(height: 6),
                                          AutoSizeText.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Mob No :',
                                                  style:
                                                      AppTextStyle.contactDetailsTextStyle(
                                                        fontSize: 13,
                                                        color: Color(
                                                          0xff646464,
                                                        ),
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: '+91 9894815480',
                                                  style:
                                                      AppTextStyle.contactDetailsTextStyle(
                                                        fontSize: 13,
                                                        color: Color(
                                                          0xff323131,
                                                        ),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Column(
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
                                                    return 'Please enter contact number';
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
                                        ],
                                      ),
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
                                : AutoSizeText.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Our Services to Power\n',

                                        style: AppTextStyle.headingTextStyle(
                                          letterSpacing: -1,
                                          fontSize: 32,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Your ',
                                        style: AppTextStyle.headingTextStyle(
                                          letterSpacing: -1,
                                          fontSize: 32,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Digital Journey.',
                                        style: AppTextStyle.headingTextStyle(
                                          letterSpacing: -1,
                                          fontSize: 32,
                                          color: Color(0xffFE6225),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    horizontal: 20,
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
                                            mainAxisExtent: 485,
                                          ),
                                      physics: NeverScrollableScrollPhysics(),
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
                                            //          [
                                            //           BoxShadow(
                                            //             blurStyle:
                                            //                 BlurStyle.outer,
                                            //             color: Color(
                                            //               0xffFE6225,
                                            //             ),
                                            //             blurRadius: ,
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
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                        GoogleFonts.manrope()
                                                            .fontFamily,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                                AutoSizeText(
                                                  services[index]['description'],
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        GoogleFonts.manrope()
                                                            .fontFamily,
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
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            GoogleFonts.manrope()
                                                                .fontFamily,
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
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            GoogleFonts.manrope()
                                                                .fontFamily,
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
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            GoogleFonts.manrope()
                                                                .fontFamily,
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
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            GoogleFonts.manrope()
                                                                .fontFamily,
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
                                : AutoSizeText.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'z',
                                        style: AppTextStyle.headingTextStyle(
                                          fontSize: 35,
                                          color: Color(0xffFE6225),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Astral',
                                        style: AppTextStyle.headingTextStyle(
                                          letterSpacing: -1,
                                          fontSize: 36,
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
                            (title == 'About Us' ||
                                    title == 'Services' ||
                                    title == 'Contact Us')
                                ? SizedBox()
                                : Image.asset('assets/png/zastral.png'),
                            (title == 'About Us')
                                ? SizedBox(height: 80)
                                : SizedBox(height: 50),
                            (title == 'About Us')
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Image.asset(
                                    'assets/png/vision-mission.png',
                                    // height: 800,
                                    fit: BoxFit.contain,
                                  ),
                                )
                                : SizedBox(),

                            (title == 'About Us')
                                ? SizedBox(height: 100)
                                : SizedBox(),
                            (title == 'About Us')
                                ? Container(
                                  width: fullWidth,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFAF2EF),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 40,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'We ',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'Build ',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Color(0xffFE6225),
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'With ',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'Care',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Color(0xffFE6225),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AutoSizeText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'We ',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'Scale ',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Color(0xffFE6225),
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'With ',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'Clarity',
                                                style:
                                                    AppTextStyle.headingTextStyle(
                                                      letterSpacing: -2,
                                                      fontSize: 30,
                                                      color: Color(0xffFE6225),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 24),
                                        AutoSizeText(
                                          'Partnering with enterprises worldwide to drive transformation, foster innovation, and help them scale and thrive through Agentic AI, cloud, and modern engineering.',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.manrope()
                                                    .fontFamily,
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(height: 30),
                                        AutoSizeText(
                                          '- Vijay Ganesh CEO',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.manrope()
                                                    .fontFamily,
                                            color: Color(0xffFE6225),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : SizedBox(),
                            (title == 'Home' || title == 'About Us')
                                ? SizedBox(height: 50)
                                : SizedBox(),

                            (title == 'Home' || title == 'Our Products')
                                ? AutoSizeText.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'z',
                                        style: AppTextStyle.headingTextStyle(
                                          fontSize: 30,
                                          color: Color(0xffFE6225),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Astral Products',
                                        style: AppTextStyle.headingTextStyle(
                                          letterSpacing: -1,
                                          fontSize: 36,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : SizedBox(),
                            (title == 'Home' || title == 'Our Products')
                                ? SizedBox(height: 60)
                                : SizedBox(),

                            (title == 'About Us' ||
                                    title == 'Services' ||
                                    title == 'Contact Us')
                                ? SizedBox()
                                : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: SizedBox(
                                    height: 1900,
                                    child: GridView.builder(
                                      itemCount: product.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            mainAxisExtent: 300,
                                          ),
                                      physics: NeverScrollableScrollPhysics(),
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
                                                AutoSizeText.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            index ==
                                                                    product.length -
                                                                        1
                                                                ? 'AI '
                                                                : 'z',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              GoogleFonts.manrope()
                                                                  .fontFamily,
                                                          color: Color(
                                                            0xffFE6225,
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            product[index]['title'],
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              GoogleFonts.manrope()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                                AutoSizeText(
                                                  product[index]['description'],
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        GoogleFonts.manrope()
                                                            .fontFamily,
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

                            // Image.asset(
                            //   'assets/png/bottom-gradient.png',
                            //   fit: BoxFit.contain,
                            //   width: double.infinity,
                            // ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Join ',
                                            style:
                                                AppTextStyle.communityTextStyle(
                                                  letterSpacing: -1,
                                                  fontSize: 36,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Our ',
                                            style:
                                                AppTextStyle.communityTextStyle(
                                                  letterSpacing: -1,
                                                  fontSize: 36,
                                                  color: AppTheme.buttonColor,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Community',
                                            style:
                                                AppTextStyle.communityTextStyle(
                                                  letterSpacing: -1,
                                                  fontSize: 36,
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: AutoSizeText(
                                    'Be part of a unified space where people, projects, and operations thrive with AI-powered efficiency',

                                    style: AppTextStyle.communityTextTextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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
                            SizedBox(height: 50),
                            Container(
                              width: fullWidth,
                              decoration: BoxDecoration(
                                color: Color(0xff000000),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 40.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/png/zetstron-logo.png',
                                          height: 30,
                                        ),
                                        SizedBox(height: 40),
                                        AutoSizeText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'With ',
                                                style:
                                                    AppTextStyle.communityTextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'Zetstron',
                                                style:
                                                    AppTextStyle.communityTextStyle(
                                                      fontSize: 17,
                                                      color:
                                                          AppTheme.buttonColor,
                                                    ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ', you’re not just\na client — you’re a partner',
                                                style:
                                                    AppTextStyle.communityTextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 50),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              'Address:',
                                              style:
                                                  AppTextStyle.containerTextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            SizedBox(height: 10),
                                            AutoSizeText(
                                              'E-101 Palm Riviera, Tmvm Main Road, SIPCOT Industrial Area, Thirumudivakkam, Chennai -600044, Tamil Nadu',
                                              style:
                                                  AppTextStyle.containerTextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff8A8889),
                                                  ),
                                            ),
                                            SizedBox(height: 20),
                                            AutoSizeText(
                                              'Contact Us',
                                              style:
                                                  AppTextStyle.containerTextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            SizedBox(height: 10),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  'Mob No:',
                                                  style:
                                                      AppTextStyle.containerTextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                                AutoSizeText(
                                                  ' +91 9894815480',
                                                  style:
                                                      AppTextStyle.containerTextStyle(
                                                        fontSize: 12,
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
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
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
                                              horizontal: 20.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AutoSizeText(
                                                  '@2025 | Zetstron',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.manrope()
                                                            .fontFamily,
                                                    fontSize: 8,
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
                                                    fontSize: 8,
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
                                              horizontal: 20.0,
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
              ),
            ],
          ),
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
        fontSize: 14,
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
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xffC6C6C6)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 237, 37, 23)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 237, 37, 23)),
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
      child: Image.asset('assets/png/$mediaName.png', height: 40),
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
          padding: const EdgeInsets.symmetric(vertical: 11.5, horizontal: 37.5),
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
