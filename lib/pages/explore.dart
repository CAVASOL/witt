import 'package:flutter/material.dart';
import 'package:login_auth/components/info_card.dart';
import 'package:login_auth/widgets/search_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.clear_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(0);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const SafeArea(
                child: Center(
                  child: KeySearchBar(),
                ),
              ),
              const SizedBox(
                height: 56,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 32,
                ),
                child: Text(
                  "사진 속에 무엇이 있을까?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detect',
                                );
                              },
                              child: const InfoCard(
                                text: "동물",
                                bgColor: Colors.white,
                                textColor: Color(0xFF292929),
                                borderColor: Colors.grey,
                              ),
                            ),
                            const InfoCard(
                              text: "꽃",
                              bgColor: Colors.white,
                              textColor: Color(0xFF292929),
                              borderColor: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Row(
                          children: [
                            InfoCard(
                              text: "과일",
                              bgColor: Colors.white,
                              textColor: Color(0xFF292929),
                              borderColor: Colors.grey,
                            ),
                            InfoCard(
                              text: "공룡",
                              bgColor: Colors.white,
                              textColor: Color(0xFF292929),
                              borderColor: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Row(
                          children: [
                            InfoCard(
                              text: "재활용품",
                              bgColor: Colors.white,
                              textColor: Color(0xFF292929),
                              borderColor: Colors.grey,
                            ),
                            InfoCard(
                              text: "해파리",
                              bgColor: Colors.white,
                              textColor: Color(0xFF292929),
                              borderColor: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
