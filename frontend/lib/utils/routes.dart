import 'package:flutter/material.dart';
import 'package:loginuicolors/Components/renternavbar.dart';
import 'package:loginuicolors/Components/tenentbottombar.dart';
import 'package:loginuicolors/login.dart';
import 'package:loginuicolors/register.dart';
import 'package:loginuicolors/screen/Tenantpages/Tenant_view.dart';
import 'package:loginuicolors/utils/route_names.dart';
import '../screen/Tenantpages/aboutus.dart';
import '../screen/Tenantpages/postlisting.dart';
import '../screen/Tenantpages/search.dart';
import '../screen/Tenantpages/setting.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        {
          return MaterialPageRoute(
            builder: (context) => MyLogin(),
          );
        }
      case RouteName.register:
        {
          return MaterialPageRoute(
            builder: (context) => MyRegister(),
          );
        }
      // case RouteName.renter:
      //   {
      //     return MaterialPageRoute(
      //       builder: (context) => RenterViewPage(),
      //     );
      //   }
      case RouteName.tenant:
        {
          return MaterialPageRoute(
            builder: (context) => TenantViewPage(),
          );
        }
      case RouteName.setting:
        {
          return MaterialPageRoute(
            builder: (context) => Setting(),
          );
        }
      case RouteName.listing:
        {
          return MaterialPageRoute(
            builder: (context) => PostListing(),
          );
        }
      case RouteName.search:
        {
          return MaterialPageRoute(
            builder: (context) => Search(),
          );
        }
      case RouteName.aboutus:
        {
          return MaterialPageRoute(
            builder: (context) => AboutUs(),
          );
        }
      case RouteName.tenantbottomnav:
        {
          return MaterialPageRoute(
            builder: (context) => TenantBottombar(),
          );
        }
      case RouteName.renterbottomnav:
        {
          return MaterialPageRoute(
            builder: (context) => OwnerBottomBar(),
          );
        }
      // case RouteName.postview:
      //   {
      //     return MaterialPageRoute(
      //       builder: (context) => PostPageView(),
      //     );
      //   }
      default:
        {
          return MaterialPageRoute(
            builder: (context) {
              return const Scaffold(
                body: Text("DedEND"),
              );
            },
          );
        }
    }
  }
}
