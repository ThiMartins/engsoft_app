import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/service/EngineerService.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/manager/adapter/engineer_item.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/manager/manager_view_model.dart';
import 'package:comunidade_de_engenheiros_de_software/screen/profile/engine/engineer_page.dart';
import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:comunidade_de_engenheiros_de_software/util/base/constants.dart';
import 'package:comunidade_de_engenheiros_de_software/util/view/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManagerPage extends StatefulWidget {
  ManagerPage({Key? key}) : super(key: key);

  final ManagerViewModel viewModel =
      ManagerViewModel(service: getIt<EngineerService>());

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  static const _pageSize = 50;

  final PagingController<int, Engineer> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      widget.viewModel.getEngineers(pageKey).then((value) {
        if (!super.mounted) return;
        if (value.isNotEmpty) {
          _pagingController.appendPage(value, pageKey + 1);
        } else {
          _pagingController.appendLastPage(value);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Observer(
                    builder: (_) {
                      return FilterChip(
                        label: const Text('Ativo'),
                        selected: widget.viewModel.filterEnable,
                        onSelected: (isSelected) {
                          widget.viewModel.filterEnable = isSelected;
                          _pagingController.refresh();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Observer(
                    builder: (_) {
                      return FilterChip(
                        label: const Text('Desativado'),
                        selected: widget.viewModel.filterDisable,
                        onSelected: (isSelected) {
                          widget.viewModel.filterDisable = isSelected;
                          _pagingController.refresh();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Observer(
                    builder: (_) {
                      return FilterChip(
                        label: const Text('Aprovar'),
                        selected: widget.viewModel.filterApproved,
                        onSelected: (isSelected) {
                          widget.viewModel.filterApproved = isSelected;
                          _pagingController.refresh();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Observer(
                    builder: (_) {
                      return FilterChip(
                        label: const Text('Desaprovado'),
                        selected: widget.viewModel.filterNotApproved,
                        onSelected: (isSelected) {
                          widget.viewModel.filterNotApproved = isSelected;
                          _pagingController.refresh();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Container(
              color: AppColor.primaryColorDark,
              height: 1,
            ),
            Expanded(
              child: PagedListView<int, Engineer>(
                pagingController: _pagingController,
                physics: const BouncingScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, data, index) => EngineerItem(
                    engineer: data,
                    onClick: (item) async {
                      final Engineer? engineer = await Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (_) => EngineerPage(engineer: item)));
                      if (engineer == null) return;

                      final loading = LoadingControl();
                      showDialog(
                          context: context,
                          builder: (_) => loading.create(),
                          barrierDismissible: false);

                      final newStatus =
                          await widget.viewModel.updateState(engineer);
                      loading.close();

                      if (newStatus != null) {
                        item.isApproved = newStatus;
                        final items = _pagingController.itemList;
                        _pagingController.itemList = [];
                        _pagingController.itemList = items;
                      }
                    },
                    onApprovedChange: (item) async {
                      final loading = LoadingControl();
                      showDialog(
                          context: context,
                          builder: (_) => loading.create(),
                          barrierDismissible: false);
                      final newStatus =
                          await widget.viewModel.updateApproved(item);
                      if (newStatus != null) {
                        item.isApproved = newStatus;
                        final items = _pagingController.itemList;
                        _pagingController.itemList = [];
                        _pagingController.itemList = items;
                      }
                      loading.close();
                    },
                    onClickState: (item) async {
                      final loading = LoadingControl();
                      showDialog(
                          context: context,
                          builder: (_) => loading.create(),
                          barrierDismissible: false);
                      final newStatus =
                          await widget.viewModel.updateState(item);
                      if (newStatus != null) {
                        item.isApproved = newStatus;
                        final items = _pagingController.itemList;
                        _pagingController.itemList = [];
                        _pagingController.itemList = items;
                      }
                      loading.close();
                    },
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
