import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'add_denetim_dialog.dart';

class DenetimCard extends StatelessWidget {
  const DenetimCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  'Denetim',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 100,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 28,
                    margin: EdgeInsets.only(right: 60),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5), // Temadan alınan renk ile güncellendi
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
                        width: 1.5,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              height: 300,
                              child: Center(
                                child: Text(
                                  'Detaylı denetim bilgisi',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.50, // Replace with dynamic value if needed
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
                              ),
                              minHeight: 28,
                            ),
                          ),
                          Text(
                            'Güncel',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 70,
                child: GestureDetector(
                  onTap: () {
                    // Define desired action here
                  },
                  child: Container(
                    height: 28,
                    margin: EdgeInsets.only(right: 60),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), // Temadan alınan renk ile güncellendi
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Tümü(152)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 12.0,
                  percent: 0.75,
                  center: Text(
                    "75",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
                    ),
                  ),
                  progressColor: Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
                  backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), // Temadan alınan renk ile güncellendi
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), // Temadan alınan renk ile güncellendi
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                      color: Colors.transparent,
                      shape: CircleBorder(),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        splashColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), // Temadan alınan renk ile güncellendi
                        highlightColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1), // Temadan alınan renk ile güncellendi
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddDenetimDialog();
                          },                     );
                      },
                      child: Ink(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary, // Background color remains primary
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_outlined,
                          size: 40,
                          color: Theme.of(context).colorScheme.onPrimary, // Temadan alınan renk ile güncellendi
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
    );
  }
}
