import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_driver/constants.dart';
import 'package:foodie_driver/main.dart';
import 'package:foodie_driver/model/CurrencyModel.dart';
import 'package:foodie_driver/services/FirebaseHelper.dart';
import 'package:foodie_driver/services/helper.dart';
import 'package:foodie_driver/ui/ordersScreen/OrdersScreen.dart';
import 'package:foodie_driver/ui/profile/ProfileScreen.dart';
import 'package:foodie_driver/ui/wallet/walletScreen.dart';
import 'package:location/location.dart';
import 'model/User.dart';

class BottomBar extends StatefulWidget {
  final int? selectedTab;
  final User? user;

  const BottomBar({Key? key, this.selectedTab, this.user}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectIndex = 0;


  @override
  void initState() {
    super.initState();
    setCurrency();
    updateCurrentLocation();

    /// On iOS, we request notification permissions, Does nothing and returns null on Android
    FireStoreUtils.firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    getplaceholderimage();
    if (widget.selectedTab != null) {
      selectIndex = widget.selectedTab!;
    }

    setState(() {});
  }
  Location location = Location();

  Future<String?> getplaceholderimage() async {
    var collection = FirebaseFirestore.instance.collection(Setting);
    var docSnapshot = await collection.doc('placeHolderImage').get();
    Map<String, dynamic>? data = docSnapshot.data();
    var value = data?['image'];
    placeholderImage = value;
    return placeholderImage;
  }

  setCurrency() async {
    await FireStoreUtils().getCurrency().then((value) {
      if (value != null) {
        currencyModel = value;
      } else {
        currencyModel = CurrencyModel(id: "", code: "USD", decimal: 2, isactive: true, name: "US Dollar", symbol: "\$", symbolatright: false);
      }
      setState(() {});
    });

    await FireStoreUtils().getRazorPayDemo();
    await FireStoreUtils.getPaypalSettingData();
    await FireStoreUtils.getStripeSettingData();
    await FireStoreUtils.getPayStackSettingData();
    await FireStoreUtils.getFlutterWaveSettingData();
    await FireStoreUtils.getPaytmSettingData();
    await FireStoreUtils.getWalletSettingData();
    await FireStoreUtils.getPayFastSettingData();
    await FireStoreUtils.getMercadoPagoSettingData();
    await FireStoreUtils.getReferralAmount();
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      OrdersScreen(),
      WalletScreen(),
      OrdersScreen(),
      ProfileScreen(user: widget.user),
    ];
    return Scaffold(
      body: Center(child: _pages.elementAt(selectIndex)),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(19),
          topLeft: Radius.circular(10),
        ),
        child:  Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                // spreadRadius: 200
              ),
            ],
          ),
          child:  Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(

              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              backgroundColor:  isDarkMode(context) ? Colors.black : Colors.white,
              currentIndex: selectIndex,
              onTap: _onItemTapped,
              showUnselectedLabels: true,
              selectedItemColor: Color(COLOR_PRIMARY),
              unselectedItemColor: Color(0XFFC0C0C0),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectIndex == 0 ? Color(COLOR_PRIMARY) : Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        ImageIcon(
                          Image.asset(
                            "assets/images/home (1).png",
                          ).image,
                          size: 24,
                        ),
                      ],
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectIndex == 1 ? Color(COLOR_PRIMARY) : Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Icon(Icons.account_balance_wallet_sharp)
                      ],
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectIndex == 2 ? Color(COLOR_PRIMARY) : Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        ImageIcon(
                          Image.asset(
                            "assets/images/bottom3.png",
                          ).image,
                          size: 24,
                        ),
                      ],
                    ),
                    label: ""),
/*
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectIndex == 3 ? Color(COLOR_PRIMARY) : Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        ImageIcon(
                          Image.asset(
                            "assets/images/bottom4.png",
                          ).image,
                          size: 24,
                        ),
                      ],
                    ),
                    label: ""),
*/
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectIndex == 4 ? Color(COLOR_PRIMARY) : Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        ImageIcon(
                          Image.asset(
                            "assets/images/bottom5.png",
                          ).image,
                          size: 24,
                        ),
                      ],
                    ),
                    label: ""),
              ],
            ),
          ),
        ),
      ),
    );
  }
  updateCurrentLocation() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      location.enableBackgroundMode(enable: true);
      location.changeSettings(accuracy: LocationAccuracy.navigation, distanceFilter: 3);
      location.onLocationChanged.listen((locationData) async {
        locationDataFinal = locationData;
        await FireStoreUtils.getCurrentUser(MyAppState.currentUser!.userID).then((value) {
          if (value != null) {
            User driverUserModel = value;
            if (driverUserModel.isActive == true) {
              driverUserModel.location = UserLocation(latitude: locationData.latitude ?? 0.0, longitude: locationData.longitude ?? 0.0);
              driverUserModel.rotation = locationData.heading;
              FireStoreUtils.updateCurrentUser(driverUserModel);
            }
          }
        });
      });
    } else {
      location.requestPermission().then((permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          location.enableBackgroundMode(enable: true);
          location.changeSettings(accuracy: LocationAccuracy.navigation, distanceFilter: 3);
          location.onLocationChanged.listen((locationData) async {
            locationDataFinal = locationData;
            await FireStoreUtils.getCurrentUser(MyAppState.currentUser!.userID).then((value) {
              if (value != null) {
                User driverUserModel = value;
                if (driverUserModel.isActive == true) {
                  driverUserModel.location = UserLocation(latitude: locationData.latitude ?? 0.0, longitude: locationData.longitude ?? 0.0);
                  driverUserModel.rotation = locationData.heading;
                  FireStoreUtils.updateCurrentUser(driverUserModel);
                }
              }
            });
          });
        }
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
