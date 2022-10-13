import 'package:flutter/material.dart';
import 'package:shop_appliction/Login/login%20screen.dart';
import 'package:shop_appliction/Popular%20Cubit/bloc.dart';
import 'package:shop_appliction/Popular%20Cubit/cashe%20helper.dart';
import 'package:shop_appliction/shared/colors.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}
class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var boardController=PageController();

  List<BoardingModel>boarding=[
    BoardingModel(
      image:'assets/images/dims.jpg',
      title: 'On Board 1 title',
      body: 'On Board 1 body',
    ),
    BoardingModel(
      image:'assets/images/shop.jpg',
      title: 'On Board 2 title',
      body: 'On Board 2 body',
    ),
    BoardingModel(
      image:'assets/images/shop2.jpeg',
      title: 'On Board 3 title',
      body: 'On Board 3 body',
    ),
    BoardingModel(
      image:'assets/images/image.jpg',
      title: 'On Board 4 title',
      body: 'On Board 4 body',
    ),
  ];
  bool islast=false;
  void submit()
  {
    CachHelper.saveData(key:'on boarding', value:true,).then((value){
      if(value)
      {
        navigateandFinish(context,ShopLogin());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   IconButton(onPressed: (){
          AppCubit.get(context).changeappmode();
        }, icon: Icon(
          Icons.brightness_4_outlined,
        ),),
        actions: [
          TextButton(onPressed:submit,
              child: Text(
                'SKIP',
              )),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index)
                {
                  if(index==boarding.length -1)
                  {
                    setState(()
                    {
                      islast=true;
                    });
                  }else
                  {
                    setState(()
                    {
                      islast=false;
                    });
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                    activeDotColor:defaultcolor,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(islast)
                    {
                      submit();
                    }else
                    {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text('${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text('${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );
}
