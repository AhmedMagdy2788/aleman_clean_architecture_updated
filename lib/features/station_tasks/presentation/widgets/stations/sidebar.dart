import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../bloc/station_tasks_bloc.dart';
import '../../pages/station_page.dart';

class Sidebar extends StatefulWidget {
  // final Function(PagesName selectedPage) updateSelectedPage;
  // final StationTasksState state;
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isCollapsed = false;
  int _selectedSideItem = 0;
  late final ScrollController sideBarScrollControler;
  int lastOpen = 0;
  List<bool> expansionPanalIsOpen = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final List<bool> _sideItemsSelection = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  /*
   * This is the first method called when the widget is created 
   * (after the class constructor, of course.)

   * initState is called once and only once. It must also call super.initState().

   * This @override method is the best time to:

   * 1- Initialize data that relies on the specific BuildContext for the created 
   *    instance of the widget.
   * 2- Initialize properties that rely on this widgets 'parent' in the tree.
   * 3- Subscribe to Streams, ChangeNotifiers, or any other object that could 
   *    change the data on this widget.
  */
  @override
  void initState() {
    super.initState();
    sideBarScrollControler = ScrollController();
  }

  /*
   * The didChangeDependencies method is called immediately after initState on 
   * the first time the widget is built.

   * It will also be called whenever an object that this widget depends on data 
   * from is called. For example, if it relies on an InheritedWidget, which updates.

   * build is always called after didChangeDependencies is called, so this is 
   * rarely needed. However, this method is the first change you have to call 
   * BuildContext.inheritFromWidgetOfExactType. This essentially would make this
   *  State 'listen' to changes on a Widget it's inheriting data from.

   * The docs also suggest that it could be useful if you need to do network calls 
   * (or any other expensive action) when an InheritedWidget updates.
   */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // jsonProvider = Provider.of<JsonProvider>(context, listen: false);
  }

  /*
   * didUpdateWidget() is called if the parent widget changes and has to rebuild 
   * this widget (because it needs to give it different data), but it's being 
   * rebuilt with the same runtimeType, then this method is called.

   * This is because Flutter is re-using the state, which is long lived. In this
   *  case, required is to initialize some data again, as one would in initState().

   * If the state's build() method relies on a Stream or other object that can change,
   *  unsubscribe from the old object and re-subscribe to the new instance in didUpdateWidget().

   * tip: This method is basically the replacement for 'initState()' if it is 
   * expected the Widget associated with the widgets's state nrrds to to be rebuilt!

   * Flutter always called build() after this, so any subsequent further calls 
   * to setState is redundant.
   */
  @override
  void didUpdateWidget(covariant Sidebar oldWidget) {
    // ignore: todo
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  /*
   * This is rarely used.

   * 'deactivate()' is called when State is removed from the tree, but it might 
   * be reinserted before the current frame change is finished. This method exists
   *  basically because State objects can be moved from one point in a tree to another.
   */
  @override
  void deactivate() {
    // ignore: todo
    // TODO: implement deactivate
    super.deactivate();
  }

  /*
   * 'dispose()' is called when the State object is removed, which is permanent.

   * This method is where to unsubscribe and cancel all animations, streams, etc.
   */
  @override
  void dispose() {
    sideBarScrollControler.dispose();
    super.dispose();
  }

  /*
   * This method is called often (think fps + render). It is a required, 
   * @override and must return a Widget.

   * Remember that in Flutter all gui is a widget with a child or children, 
   * even 'Padding', 'Center'.
   */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: _isCollapsed ? 60 : 275,
        // height: double.infinity,
        // padding: _isCollapsed ? null : const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            SidebarHeader(
                isCollapsed: _isCollapsed,
                callback: () {
                  setState(() {
                    _isCollapsed = !_isCollapsed;
                  });
                }),
            const SizedBox(height: 25),
            InfoCard(
              user: const UserEntity(
                  id: 1,
                  name: "Admin",
                  password: "1234",
                  profession: "Administrator"),
              isCollapsed: _isCollapsed,
            ),
            const SizedBox(height: 8),
            SidebarItem(
              icon: Icons.home_outlined,
              callback: () {
                setState(() {
                  _sideItemsSelection[_selectedSideItem] = false;
                  _sideItemsSelection[0] = true;
                  _selectedSideItem = 0;
                  BlocProvider.of<StationTasksBloc>(context)
                      .add(ShowDashboardEvent(context));
                  // widget.updateSelectedPage(LoadDashboardEvent(context));
                });
                log("Dashbord tapped...");
              },
              isCollapsed: _isCollapsed,
              title: "Dashboard",
              isSelected: _sideItemsSelection[0],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _isCollapsed
                        ? LayoutBuilder(
                            builder: (context, constrains) {
                              return Column(
                                children: [...popupMenusBuilder(context)],
                              );
                            },
                          )
                        : ExpansionPanelList(
                            expandedHeaderPadding: const EdgeInsets.all(7),
                            elevation: 3,
                            dividerColor: Colors.white,
                            children: [
                              ...expansionPanalsBuilder(context),
                            ],
                            expansionCallback: (index, isopen) {
                              setState(() {
                                expansionPanalIsOpen[lastOpen] = false;
                                expansionPanalIsOpen[index] = !isopen;
                                lastOpen = index;
                              });
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void callback(int index, StationTasksEvent event, String logStr) {
    setState(() {
      _sideItemsSelection[_selectedSideItem] = false;
      _sideItemsSelection[index] = true;
      _selectedSideItem = index;
      BlocProvider.of<StationTasksBloc>(context).add(event);
      // widget.updateSelectedPage(pagesName);
    });

    log(logStr);
  }

  Widget getExpansionPanelHeaderWidget(BuildContext context, IconData icon,
      String title, int index, bool isopen) {
    return ListTile(
      selected: expansionPanalIsOpen[index],
      // selectedTileColor: Theme.of(context).canvasColor,
      // selectedColor: Theme.of(context).highlightColor,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        setState(() {
          expansionPanalIsOpen[index] = !isopen;
        });
      },
    );
  }

  List<CustPopupMenu> popupMenusBuilder(BuildContext context) {
    return [
      CustPopupMenu(
        menuList: [
          buildPopupMenuItem(
              1, "Add Customer", LoadAddCustomerEvent(context), Icons.add_box),
          buildPopupMenuItem(2, "Customer Details", ShowDashboardEvent(context),
              Icons.account_tree_outlined),
          const PopupMenuDivider(),
          buildPopupMenuItem(3, "All Customers",
              LoadStationCustomersEvent(context), Icons.grid_3x3_rounded),
          buildPopupMenuItem(4, "Customers Trade Summary",
              ShowDashboardEvent(context), Icons.read_more),
          buildPopupMenuItem(5, "Customer Trade Details",
              ShowDashboardEvent(context), Icons.traffic),
        ],
        icon: Icon(
          Icons.people,
          color: (_selectedSideItem >= 1 && _selectedSideItem <= 5)
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).iconTheme.color,
        ),
      ),
      CustPopupMenu(
        menuList: [
          buildPopupMenuItem(6, "SubCopanies", LoadSubCompaniesEvent(context),
              Icons.factory_outlined),
          buildPopupMenuItem(7, "Marketing Companies",
              LoadMarketingCompaniesEvent(context), Icons.factory),
          const PopupMenuDivider(),
          buildPopupMenuItem(8, "Stations", LoadStationsEvent(context),
              Icons.grid_3x3_rounded),
        ],
        icon: Icon(
          Icons.home_work_rounded,
          color: (_selectedSideItem >= 6 && _selectedSideItem <= 8)
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).iconTheme.color,
        ),
      ),
    ];
  }

  PopupMenuItem buildPopupMenuItem(
      int index, String title, StationTasksEvent event, IconData icon) {
    return PopupMenuItem(
      value: index,
      onTap: () => callback(index, event, "$title tapped..."),
      child: Container(
        decoration: BoxDecoration(
          color:
              _sideItemsSelection[index] ? Theme.of(context).canvasColor : null,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          // RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(16.0))
        ),
        child: ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(title),
        ),
      ),
    );
  }

  List<ExpansionPanel> expansionPanalsBuilder(BuildContext context) {
    return [
      /* 
      * General 
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(
              context, Icons.maps_home_work, "General", 0, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarItem(
              icon: Icons.factory_outlined,
              title: "SubCompanies",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  1, LoadSubCompaniesEvent(context), "SubCompanies tapped..."),
              isSelected: _sideItemsSelection[1],
            ),
            SidebarItem(
              icon: Icons.factory,
              title: "Marketing Companies",
              isCollapsed: _isCollapsed,
              callback: () => callback(2, LoadMarketingCompaniesEvent(context),
                  "Marketing Companies tapped..."),
              isSelected: _sideItemsSelection[2],
            ),
            const Divider(),
            SidebarItem(
              icon: Icons.storage,
              title: "Stations",
              isCollapsed: _isCollapsed,
              callback: () =>
                  callback(3, LoadStationsEvent(context), "Stations tapped..."),
              isSelected: _sideItemsSelection[3],
            ),
            SidebarItem(
              icon: Icons.storage,
              title: "Stations internal Exchanges",
              isCollapsed: _isCollapsed,
              callback: () => callback(4, ShowDashboardEvent(context),
                  "Stations internal Exchanges tapped..."),
              isSelected: _sideItemsSelection[4],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[0],
      ),
      /* 
      * Daily Actions 
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(
              context, Icons.people, "Daily Actions", 1, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: "Edit",
            ),
            SidebarItem(
              icon: Icons.add_box_rounded,
              title: "Daily Quick Insert",
              isCollapsed: _isCollapsed,
              callback: () => callback(1 + 5, LoadStationsEvent(context),
                  "Daily Quick Insert tapped..."),
              isSelected: _sideItemsSelection[1 + 5],
            ),
            SidebarItem(
              icon: Icons.details_outlined,
              title: "Daily Incoming Cash",
              isCollapsed: _isCollapsed,
              callback: () => callback(2 + 5, ShowDashboardEvent(context),
                  "Daily Incoming Cash tapped..."),
              isSelected: _sideItemsSelection[2 + 5],
            ),
            const Divider(),
            const SectionTitle(
              title: "Reports",
            ),
            SidebarItem(
              icon: Icons.read_more,
              title: "Daily Report",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                3 + 5,
                ShowDailyReportPageEvent(context,
                    reportDate: StationPage.of(context)!.initDate,
                    station: StationPage.of(context)!.station),
                "Daily Report tapped...",
              ),
              isSelected: _sideItemsSelection[3 + 5],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[1],
      ),
      /* 
      * Tanks 
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(
              context, Icons.maps_home_work, "Tanks", 2, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarItem(
              icon: Icons.edit,
              title: "Tanks Editing",
              isCollapsed: _isCollapsed,
              callback: () => callback(5 + 10, LoadTanksEditingEvent(context),
                  "Tanks Editing tapped..."),
              isSelected: _sideItemsSelection[5 + 10],
            ),
            const Divider(),
            SidebarItem(
              icon: Icons.factory_outlined,
              title: "Tanks Details",
              isCollapsed: _isCollapsed,
              callback: () => callback(1 + 10, LoadTanksDetailsEvent(context),
                  "Tanks Details tapped..."),
              isSelected: _sideItemsSelection[1 + 10],
            ),
            SidebarItem(
              icon: Icons.factory,
              title: "Daily Measurements",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  2 + 10,
                  LoadTanksDailyMeasurementEvent(context),
                  "Tanks Daily Measurements tapped..."),
              isSelected: _sideItemsSelection[2 + 10],
            ),
            const Divider(),
            SidebarItem(
              icon: Icons.storage,
              title: "Tanks Equilibrium",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  3 + 10,
                  LoadTanksEquilibriumEvent(context),
                  "Tanks Equilibrium tapped..."),
              isSelected: _sideItemsSelection[3 + 10],
            ),
            SidebarItem(
              icon: Icons.storage,
              title: "Daily Station stock",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  4 + 10,
                  LoadDailyStationStockEvent(context),
                  "Daily Station stock tapped..."),
              isSelected: _sideItemsSelection[4 + 10],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[2],
      ),
      /* 
      *Counters & Pumps 
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(
              context, Icons.maps_home_work, "Counters & Pumps", 3, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarItem(
              icon: Icons.factory_outlined,
              title: "Pumps & Counters Details",
              isCollapsed: _isCollapsed,
              callback: () => callback(1 + 15, ShowDashboardEvent(context),
                  "Pumps & Counters Details tapped..."),
              isSelected: _sideItemsSelection[1 + 15],
            ),
            SidebarItem(
              icon: Icons.factory,
              title: "Counters Measurements",
              isCollapsed: _isCollapsed,
              callback: () => callback(2 + 15, ShowDashboardEvent(context),
                  "Tanks Daily Measurements tapped..."),
              isSelected: _sideItemsSelection[2 + 15],
            ),
            const Divider(),
            SidebarItem(
              icon: Icons.storage,
              title: "Counters Feedback Percentage",
              isCollapsed: _isCollapsed,
              callback: () => callback(3 + 15, ShowDashboardEvent(context),
                  "Counters Feedback Percentage tapped..."),
              isSelected: _sideItemsSelection[3 + 15],
            ),
            SidebarItem(
              icon: Icons.storage,
              title: "Calibration Amounts",
              isCollapsed: _isCollapsed,
              callback: () => callback(4 + 15, ShowDashboardEvent(context),
                  "Calibration Amounts tapped..."),
              isSelected: _sideItemsSelection[4 + 15],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[3],
      ),

      /* 
      *Expenses
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(
              context, Icons.maps_home_work, "Expenses", 4, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarItem(
              icon: Icons.factory_outlined,
              title: "Expenses Records",
              isCollapsed: _isCollapsed,
              callback: () => callback(1 + 20, ShowDashboardEvent(context),
                  "Expenses Records tapped..."),
              isSelected: _sideItemsSelection[1 + 20],
            ),
            SidebarItem(
              icon: Icons.factory,
              title: "Expenses Reports",
              isCollapsed: _isCollapsed,
              callback: () => callback(2 + 20, ShowDashboardEvent(context),
                  "Expenses Reports tapped..."),
              isSelected: _sideItemsSelection[2 + 20],
            ),
            const Divider(),
            SidebarItem(
              icon: Icons.storage,
              title: "Expenses Data",
              isCollapsed: _isCollapsed,
              callback: () => callback(3 + 20, ShowDashboardEvent(context),
                  "Expenses Data tapped..."),
              isSelected: _sideItemsSelection[3 + 20],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[4],
      ),

      /* 
      *Products
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(
              context, Icons.maps_home_work, "Products", 5, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarItem(
              icon: Icons.production_quantity_limits,
              title: "All Products",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  1 + 25, ShowProductsEvent(context), "All Products tapped..."),
              isSelected: _sideItemsSelection[1 + 25],
            ),
            SidebarItem(
              icon: Icons.money,
              title: "products Prices",
              isCollapsed: _isCollapsed,
              callback: () => callback(2 + 25, ShowProductsPricesEvent(context),
                  "products Prices tapped..."),
              isSelected: _sideItemsSelection[2 + 25],
            ),
            SidebarItem(
              icon: Icons.storage,
              title: "products Stroges",
              isCollapsed: _isCollapsed,
              callback: () => callback(3 + 25, ShowDashboardEvent(context),
                  "products Stroges tapped..."),
              isSelected: _sideItemsSelection[3 + 25],
            ),
            SidebarItem(
              icon: Icons.more,
              title: "products Reports",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  4 + 25,
                  ShowProductsCommissionEvent(context),
                  "products Reports tapped..."),
              isSelected: _sideItemsSelection[4 + 25],
            ),
            const Divider(),
            SidebarItem(
              icon: Icons.edit,
              title: "Products Edit",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  5 + 25,
                  ProvideProductsEditingNeedsEvent(context),
                  "Products Edit tapped..."),
              isSelected: _sideItemsSelection[5 + 25],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[5],
      ),

      /* 
      *Marketing Companies Accounts
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(context, Icons.maps_home_work,
              "Marketing Companies Accounts", 6, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarItem(
              icon: Icons.factory_outlined,
              title: "Incoming Products",
              isCollapsed: _isCollapsed,
              callback: () => callback(1 + 30, ShowDashboardEvent(context),
                  "Incoming Products tapped..."),
              isSelected: _sideItemsSelection[1 + 30],
            ),
            SidebarItem(
              icon: Icons.factory,
              title: "Deposits",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  2 + 30, ShowDashboardEvent(context), "Deposits tapped..."),
              isSelected: _sideItemsSelection[2 + 30],
            ),
            SidebarItem(
              icon: Icons.storage,
              title: "Balance Adjustments",
              isCollapsed: _isCollapsed,
              callback: () => callback(3 + 30, ShowDashboardEvent(context),
                  "Balance Adjustments tapped..."),
              isSelected: _sideItemsSelection[3 + 30],
            ),
            const Divider(),
            SidebarItem(
              icon: Icons.storage,
              title: "Report",
              isCollapsed: _isCollapsed,
              callback: () => callback(4 + 30, ShowDashboardEvent(context),
                  "Marketing Companies report tapped..."),
              isSelected: _sideItemsSelection[4 + 30],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[6],
      ),

      /* 
      *Customers
      */
      ExpansionPanel(
        headerBuilder: (ctx, isopen) {
          return getExpansionPanelHeaderWidget(
              context, Icons.people, "Customers", 7, isopen);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: "Edit",
            ),
            SidebarItem(
              icon: Icons.add_box_rounded,
              title: "All Customers",
              isCollapsed: _isCollapsed,
              callback: () => callback(
                  1 + 35,
                  LoadStationCustomersEvent(context),
                  "All Cusotmers tapped..."),
              isSelected: _sideItemsSelection[1 + 35],
            ),
            SidebarItem(
              icon: Icons.details_outlined,
              title: "Customers Withdroawals",
              isCollapsed: _isCollapsed,
              callback: () => callback(2 + 35, ShowDashboardEvent(context),
                  "Customers Withdroawals tapped..."),
              isSelected: _sideItemsSelection[2 + 35],
            ),
            SidebarItem(
              icon: Icons.grid_3x3_rounded,
              title: "Customers Payments",
              isCollapsed: _isCollapsed,
              callback: () => callback(3 + 35, ShowDashboardEvent(context),
                  "Customers Payments tapped..."),
              isSelected: _sideItemsSelection[3 + 35],
            ),
            const Divider(),
            const SectionTitle(
              title: "Reports",
            ),
            SidebarItem(
              icon: Icons.read_more,
              title: "Customers Trade Summary",
              isCollapsed: _isCollapsed,
              callback: () => callback(4 + 35, ShowDashboardEvent(context),
                  "Customers Trade Summary tapped..."),
              isSelected: _sideItemsSelection[4 + 35],
            ),
            SidebarItem(
              icon: Icons.traffic,
              title: "Customer Trade Details",
              isCollapsed: _isCollapsed,
              callback: () => callback(5 + 35, ShowDashboardEvent(context),
                  "Customer Trade Details tapped..."),
              isSelected: _sideItemsSelection[5 + 35],
            ),
          ],
        ),
        isExpanded: expansionPanalIsOpen[7],
      ),
    ];
  }
}

class SidebarHeader extends StatelessWidget {
  final bool isCollapsed;
  final Function callback;
  const SidebarHeader(
      {Key? key, required this.isCollapsed, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCollapsed
        ? IconButton(
            onPressed: () => callback(),
            icon: const Icon(Icons.menu_outlined),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FlutterLogo(size: 38),
              const Text("Station Dash"),
              IconButton(
                onPressed: () => callback(),
                icon: const Icon(Icons.menu_outlined),
              )
            ],
          );
  }
}

class InfoCard extends StatelessWidget {
  final UserEntity user;
  final bool isCollapsed;
  const InfoCard({Key? key, required this.user, required this.isCollapsed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCollapsed
        ? const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              CupertinoIcons.person,
              color: Colors.white,
            ),
          )
        : ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white24,
              backgroundImage: (user.imageLink != null)
                  ? AssetImage(
                      user.imageLink ?? "",
                    )
                  : null,
              child: (user.imageLink == null)
                  ? const Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    )
                  : null,
            ),
            title: Text(
              user.name,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              user.profession,
              style: const TextStyle(color: Color(0xff4cceac)),
            ),
          );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final bool isCollapsed;
  final Function callback;
  const SidebarItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isCollapsed,
    required this.callback,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isSelected
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).iconTheme.color!;
    return isCollapsed
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: IconButton(
              onPressed: () => callback(),
              icon: Icon(
                icon,
                color: color,
              ),
            ),
          )
        : InkWell(
            onTap: () => callback(),
            child: Container(
              color: isSelected ? Theme.of(context).canvasColor : null,
              padding: const EdgeInsets.only(
                left: 30,
                top: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: color,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: color)),
                ],
              ),
            ),
          );
  }
}

class CustPopupMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const CustPopupMenu({Key? key, required this.menuList, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
