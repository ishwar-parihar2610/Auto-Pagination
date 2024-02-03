import 'package:common_paggination_package/api/api.dart';
import 'package:common_paggination_package/custom_package/custom_paggination.dart';
import 'package:common_paggination_package/model/user_api_model.dart';
import 'package:flutter/material.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final ScrollController _controller = ScrollController();
  bool isLoader = true;

  @override
  void initState() {
    getUserDetails(0, init: true);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoader = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(children: [
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: userListNotifier,
              builder: (context, value, child) {
                return AutoPagination<Users>(
                    loader: isLoader,
                    scrollDirection: Axis.vertical,
                    loaderBuilder: () {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                    placeHolderBuilder: () {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    },
                    hight: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    totalRecords: userListNotifier.value?.totalUsers ?? 0,
                    scrollController: _controller,
                    onMaxScroll: (nextPageIndex, callAgain) {
                      int nextPageOffset = (value?.offset ?? 0) + 10;

                      if (callAgain) {
                        getUserDetails(nextPageOffset);
                      } else {
                        print("limit exceed");
                      }
                    },
                    itemBulder: (item, index) {
                      return _userListView(item, index);
                    },
                    itemList: userListNotifier.value?.users ?? []);
              }),
        )
      ]),
    );
  }

  _userListView(Users users, int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          child: ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    users.profilePicture ?? "",
                  ),
                ),
              ),
            ),
            title: Text(
              users.firstName ?? "",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              users.email ?? "",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          )),
    );
  }
}
