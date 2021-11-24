import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tododev/views/create_todo_view.dart';
import 'package:tododev/views/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedItem = 'todo';
  final List<Map<String, dynamic>> _unCompleteData = [];
  final List<Map<String, dynamic>> _completeData = [];

  final List<Map<String, dynamic>> data = [
    {
      'title': 'Vestibulum neque ligula, commodo vel iaculis eu.',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum neque ligula, commodo vel iaculis eu, lacinia sit amet felis. Phasellus ultrices porta mauris vel fermentum. In hac habitasse platea dictumst. Vivamus sollicitudin tincidunt quam, sit amet aliquam orci sagittis id. Nunc tempus mollis mi, sed varius est accumsan in. Integer efficitur sem porta nulla consectetur, vel blandit sem bibendum. Sed sit amet tempor orci, eu porta lacus. Praesent at nisl vitae quam consequat gravida at sed quam. Nunc interdum hendrerit pulvinar. Phasellus bibendum, urna sit amet cursus efficitur, justo ante scelerisque orci, ac posuere elit neque in metus.',
      'date_time': 'Yesterday',
      'status': true,
    },
    {
      'title': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum neque ligula, commodo vel iaculis eu, lacinia sit amet felis. Phasellus ultrices porta mauris vel fermentum. In hac habitasse platea dictumst. Vivamus sollicitudin tincidunt quam, sit amet aliquam orci sagittis id. Nunc tempus mollis mi, sed varius est accumsan in. Integer efficitur sem porta nulla consectetur, vel blandit sem bibendum. Sed sit amet tempor orci, eu porta lacus. Praesent at nisl vitae quam consequat gravida at sed quam. Nunc interdum hendrerit pulvinar. Phasellus bibendum, urna sit amet cursus efficitur, justo ante scelerisque orci, ac posuere elit neque in metus.',
      'date_time': 'Today',
      'status': true,
    },
    {
      'title': 'Suspendisse non fermentum magna.',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum neque ligula, commodo vel iaculis eu, lacinia sit amet felis. Phasellus ultrices porta mauris vel fermentum. In hac habitasse platea dictumst. Vivamus sollicitudin tincidunt quam, sit amet aliquam orci sagittis id. Nunc tempus mollis mi, sed varius est accumsan in. Integer efficitur sem porta nulla consectetur, vel blandit sem bibendum. Sed sit amet tempor orci, eu porta lacus. Praesent at nisl vitae quam consequat gravida at sed quam. Nunc interdum hendrerit pulvinar. Phasellus bibendum, urna sit amet cursus efficitur, justo ante scelerisque orci, ac posuere elit neque in metus.',
      'date_time': 'Tomorrow',
      'status': false,
    },
    {
      'title': 'Donec vestibulum egestas dapibus.',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum neque ligula, commodo vel iaculis eu, lacinia sit amet felis. Phasellus ultrices porta mauris vel fermentum. In hac habitasse platea dictumst. Vivamus sollicitudin tincidunt quam, sit amet aliquam orci sagittis id. Nunc tempus mollis mi, sed varius est accumsan in. Integer efficitur sem porta nulla consectetur, vel blandit sem bibendum. Sed sit amet tempor orci, eu porta lacus. Praesent at nisl vitae quam consequat gravida at sed quam. Nunc interdum hendrerit pulvinar. Phasellus bibendum, urna sit amet cursus efficitur, justo ante scelerisque orci, ac posuere elit neque in metus.',
      'date_time': 'Today',
      'status': false,
    },
    {
      'title':
          'Nullam viverra nisi vitae risus rhoncus, in ultrices leo tempor.',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum neque ligula, commodo vel iaculis eu, lacinia sit amet felis. Phasellus ultrices porta mauris vel fermentum. In hac habitasse platea dictumst. Vivamus sollicitudin tincidunt quam, sit amet aliquam orci sagittis id. Nunc tempus mollis mi, sed varius est accumsan in. Integer efficitur sem porta nulla consectetur, vel blandit sem bibendum. Sed sit amet tempor orci, eu porta lacus. Praesent at nisl vitae quam consequat gravida at sed quam. Nunc interdum hendrerit pulvinar. Phasellus bibendum, urna sit amet cursus efficitur, justo ante scelerisque orci, ac posuere elit neque in metus.',
      'date_time': 'Mon. 15 Nov',
      'status': false,
    }
  ];

  @override
  void initState() {
    for (Map<String, dynamic> element in data) {
      if (!element['status']) {
        _unCompleteData.add(element);
      } else {
        _completeData.add(element);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'My Task',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
          leading: const Center(
            child: FlutterLogo(
              size: 40,
            ),
          ),
          actions: [
            PopupMenuButton<String>(
                icon: const Icon(Icons.menu),
                onSelected: (value) {
                  setState(() {
                    //
                    if (selectedItem == 'Todo') {
                      selectedItem = 'Todo';
                    }
                  });
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Todo'),
                      value: 'Todo',
                    ),
                    const PopupMenuItem(
                      child: Text('Completed'),
                      value: 'Completed',
                    )
                  ];
                }),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreateTodoView();
            }));
          },
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return TaskCardWidget(
                  title: selectedItem == 'todo'
                      ? _unCompleteData[index]['title']
                      : _completeData[index]['title'],
                  description: selectedItem == 'todo'
                      ? _unCompleteData[index]['description']
                      : _completeData[index]['description'],
                  dateTime: selectedItem == 'todo'
                      ? _unCompleteData[index]['date_time']
                      : _completeData[index]['date_time'],
                  myStatus: selectedItem == 'todo'
                      ? _unCompleteData[index]['status']
                      : _completeData[index]['status']);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemCount: selectedItem == 'todo'
                ? _unCompleteData.length
                : _completeData.length),
        bottomNavigationBar: SafeArea(
            child: InkWell(
          onTap: () {
            showBarModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        return TaskCardWidget(
                          title: _completeData[index]['title'],
                          description: _completeData[index]['description'],
                          dateTime: _completeData[index]['date_time'],
                          myStatus: _completeData[index]['status'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: _completeData.length);
                });
          },
          child: Material(
            color: const Color.fromRGBO(37, 43, 103, 1),
            borderRadius: BorderRadius.circular(0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Complete',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${_completeData.length}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.myStatus,
  }) : super(key: key);
  final String title;
  final String description;
  final String dateTime;
  final bool myStatus;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.check_circle_outline_outlined,
            //     )),
            Icon(
              myStatus
                  ? Icons.check_circle_rounded
                  : Icons.check_circle_outline_outlined,
              size: 30,
              color: Colors.pink,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(37, 43, 103, 1)),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Row(
              children: [
                Icon(Icons.notifications_outlined,
                    color: customColor(date: dateTime)),
                Text(
                  dateTime,
                  style: const TextStyle(color: Colors.pink),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
