import 'package:bloc_login/features/screens/production/screens/production_report.dart';
import 'package:flutter/material.dart';

const Color kPrimaryColor = Colors.blue;
const Color kAppBarTextColor = Colors.white;
const Color kCardBackgroundColor = Colors.white;
const Color kLightGreyBorderColor = Color(0xFFF5F5F5);

const Color kOrangeAccent = Colors.orange;
const Color kPurpleAccent = Colors.purple;

const TextStyle kAppBarTitleStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: kAppBarTextColor,
);

const TextStyle kAppBarSubtitleStyle = TextStyle(
  fontSize: 15,
  color: kAppBarTextColor,
);

const TextStyle kCardTitleStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const TextStyle kCardSubtitleStyle = TextStyle(
  color: Colors.grey,
);

const double kDefaultPadding = 10.0;
const double kCardIconContainerPadding = 10.0;
const double kCardArrowIconContainerPadding = 7.0;
const double kCardItemSpacing = 15.0;

class LeadReport extends StatefulWidget {
  const LeadReport({super.key});

  @override
  State<LeadReport> createState() => _LeadReportState();
}

class _LeadReportState extends State<LeadReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: kAppBarTextColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.sticky_note_2_outlined,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(width: kDefaultPadding),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Report", style: kAppBarTitleStyle),
                  Text('Lead reports', style: kAppBarSubtitleStyle)
                ],
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            children: [
              ReportCardItem(
                iconData: Icons.trending_up,
                iconColor: kOrangeAccent,
                iconBackgroundColor: kOrangeAccent.withOpacity(0.3),
                title: 'Lead Report',
                subtitle: 'To see your load report',
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProductionReport(),),);
                },
              ),
              ReportCardItem(
                iconData: Icons.person_2_sharp,
                iconColor: kPurpleAccent,
                iconBackgroundColor: kPurpleAccent.withOpacity(0.3),
                title: 'Employee Specific Report',
                subtitle:
                    'To see reports for a particular employee generated lead reports',
                onTap: () {
                  //
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportCardItem extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ReportCardItem({
    super.key,
    required this.iconData,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(kCardItemSpacing),
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: kCardBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kLightGreyBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(kCardIconContainerPadding),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: iconColor.withOpacity(0.7),
                ),
              ),
              child: Icon(
                iconData,
                color: iconColor,
              ),
            ),
            const SizedBox(width: kCardItemSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: kCardTitleStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kCardSubtitleStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(kCardArrowIconContainerPadding),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: iconColor.withOpacity(0.7),
                ),
              ),
              child: Icon(Icons.arrow_forward_ios, color: iconColor, size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
