import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  Map<String, dynamic>? aiResult;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          "سامانه هوشمند دام و طیور",
        ),
      ),

      drawer: _buildDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildKpiRow(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF161B22),
      child: ListView(
        children: [
          const DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.agriculture,
                  color: Colors.greenAccent,
                  size: 48,
                ),
                SizedBox(height: 10),
                Text(
                  "ایران پروتئین",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          _menuItem(Icons.dashboard, "داشبورد", 0),
          _menuItem(Icons.pets, "مدیریت دام", 1),
          _menuItem(Icons.smart_toy, "هوش مصنوعی", 2),
          _menuItem(Icons.analytics, "گزارش‌ها", 3),
        ],
      ),
    );
  }

  Widget _menuItem(
    IconData icon,
    String title,
    int index,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      selected: selectedIndex == index,
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        Navigator.pop(context);
      },
    );
  }

  Widget _buildKpiRow() {
    return Row(
      children: const [
        Expanded(
          child: KpiCard(
            title: "بهره‌وری خوراک",
            value: "87%",
          ),
        ),

        SizedBox(width: 10),

        Expanded(
          child: KpiCard(
            title: "مزارع فعال",
            value: "12",
          ),
        ),

        SizedBox(width: 10),

        Expanded(
          child: KpiCard(
            title: "دقت هوش مصنوعی",
            value: "94%",
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IndexedStack(
        index: selectedIndex,
        children: [
          _dashboardPage(),
          _livestockPage(),
          _aiPage(),
          _reportsPage(),
        ],
      ),
    );
  }

  Widget _dashboardPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "روند بهره‌وری خوراک",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),

        SizedBox(height: 20),

        SizedBox(
          height: 220,
          child: FeedEfficiencyChart(),
        ),

        SizedBox(height: 20),

        Text(
          "وضعیت سامانه: فعال",
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _livestockPage() {
    return const Center(
      child: Text(
        "پنل مدیریت دام و طیور",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _aiPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });

              try {
                final result =
                    await ApiService.optimizeRation(
                  animal: "chicken",
                  age: 25,
                  goal: "growth",
                  available: ["soybean_meal"],
                );

                setState(() {
                  aiResult = result;
                });
              } catch (e) {
                setState(() {
                  aiResult = {
                    "خطا": e.toString()
                  };
                });
              }

              setState(() {
                loading = false;
              });
            },
            child: loading
                ? const CircularProgressIndicator()
                : const Text(
                    "اجرای تحلیل هوش مصنوعی",
                  ),
          ),

          const SizedBox(height: 20),

          if (aiResult != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Text(
                aiResult.toString(),
                style: const TextStyle(
                  color: Colors.greenAccent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _reportsPage() {
    return FutureBuilder(
      future: ApiService.getHistory(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final data =
            snapshot.data as List<dynamic>;

        if (data.isEmpty) {
          return const Center(
            child: Text(
              "هنوز گزارشی ثبت نشده است",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {

            final item = data[index];

            return Container(
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    const Color(0xFF0D1117),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "حیوان: ${item["animal"]}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "امتیاز: ${item["score"]}",
                    style: const TextStyle(
                      color:
                          Colors.greenAccent,
                    ),
                  ),
                  Text(
                    "هدف: ${item["goal"]}",
                    style: const TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                  Text(
                    "زمان: ${item["timestamp"]}",
                    style: const TextStyle(
                      color:
                          Colors.white38,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class KpiCard extends StatelessWidget {
  final String title;
  final String value;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
