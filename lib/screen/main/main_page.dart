import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/EngineerService.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/login/login_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/main/main_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/manager/adapter/engineer_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/manager/manager_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/engine/engineer_page.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/edit/profile_page.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PagingController<int, Engineer> _pagingController =
      PagingController(firstPageKey: 0);
  final TextEditingController _searchController = TextEditingController();
  final MainViewModel _viewModel =
      MainViewModel(service: getIt<EngineerService>());

  final LoadingControl _loadingControl = LoadingControl();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _viewModel.getEngineers(pageKey).then((value) {
        if (value.isNotEmpty) {
          _pagingController.appendPage(value, pageKey + 1);
        } else {
          _pagingController.appendLastPage(value);
        }

        if (_loadingControl.isShowing) _loadingControl.close();
      });
    });
    _viewModel.addLoadingListener(() {
      if (_loadingControl.isShowing) {
        _loadingControl.close();
      } else {
        showDialog(
            context: context,
            builder: (_) => _loadingControl.create(),
            barrierDismissible: false);
      }
    });
    _viewModel.addListener((items) {
      if (!_viewModel.showSearch) return;
      _pagingController.itemList = items;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidade Engenheiros de Software - MVP'),
        actions: [
          Observer(
            builder: (_) {
              if (_viewModel.showSearch) {
                return IconButton(
                  onPressed: () {
                    _viewModel.showSearch = false;
                    _pagingController.refresh();
                  },
                  icon: const Icon(Icons.search_off),
                );
              }
              return IconButton(
                onPressed: () {
                  _viewModel.showSearch = true;
                },
                icon: const Icon(Icons.search),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await _viewModel.logout();
              navigator.pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()));
            },
            mini: true,
            heroTag: null,
            backgroundColor: AppColor.primaryColorDark,
            child: const Icon(Icons.logout),
          ),
          FutureBuilder<bool>(
            builder: (_, snapshot) => Visibility(
              visible: snapshot.data ?? false,
              child: FloatingActionButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ManagerPage())),
                mini: true,
                heroTag: null,
                backgroundColor: AppColor.primaryColorDark,
                child: const Icon(Icons.manage_accounts),
              ),
            ),
            initialData: false,
            future: _viewModel.isADM(),
          ),
          FloatingActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfilePage())),
            heroTag: null,
            backgroundColor: AppColor.primaryColorDark,
            child: const Icon(Icons.person),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Observer(
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: _viewModel.showSearch,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        hintText: 'Search',
                      ),
                      onChanged: (text) {
                        _viewModel.search(text);
                      },
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: PagedListView<int, Engineer>(
                pagingController: _pagingController,
                physics: const BouncingScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, data, index) => EngineerItem(
                    engineer: data,
                    onClick: (item) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => EngineerPage(engineer: item)));
                    },
                    showSecondButton: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
