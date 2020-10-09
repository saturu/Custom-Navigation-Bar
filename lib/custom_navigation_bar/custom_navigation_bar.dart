import 'package:flutter/material.dart';

import 'custom_navigation_bar_item.dart';
class CustomNavigationBar extends StatefulWidget {
  final BuildContext context;
  final List<CustomNavigationBarItem> items;
  final Color backgroundColor;
  final Color indicatorColor;
  final Function onChanged;

  CustomNavigationBar(this.context,
      this.items,
      {
    this.indicatorColor = Colors.black,
    this.backgroundColor = Colors.white,
        this.onChanged
  });

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> with SingleTickerProviderStateMixin{


  AnimationController _animationController;
  Animation _animation;
  Animation _animation2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0.0,end: 1.0).animate(_animationController);
    _animation2 = Tween<double>(begin: 1.0,end: 1.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {


      });
    });
    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        oldPosition = destination ;
      }

    });
    var size = MediaQuery.of(widget.context).size;
    double result = (size.width -(75*widget.items.length)) / (widget.items.length+1) ;
    oldPosition = result;
    _animation = Tween<double>(begin: oldPosition,end: 1.0).animate(_animationController);;

  }
  double destination = 0;
  double oldPosition = 0;
  int selectedIndex = 0;



  void move(int index){
    widget.onChanged(index);
    var size = MediaQuery.of(context).size;
    double result = (size.width -(75*widget.items.length)) / (widget.items.length+1) ;

      destination =  (index+1)*result + (index )* 75;

      _animation = Tween<double>(begin: oldPosition,end: destination).animate(_animationController);;
      _animation2 = Tween<double>(begin: 0 ,end: 1).animate(_animationController);;

      _animationController.forward(from: 0);

    selectedIndex = index;

  }




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      elevation: 5,
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.08,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: _animation.value,
              child: Container(height: size.height* 0.06,width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))
                  ,color: widget.indicatorColor
              ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for(int i = 0 ; i < widget.items.length;i++)
                InkWell(
                  onTap: (){
                    if(widget.items[i].function != null )
                    widget.items[i].function();

                    move(i);

                  },
                  child: Container(
                    width: 75,

                    height: size.height* 0.06,
                      child:Stack(
                        children: [

                          Container(
                            transform:
                            i == selectedIndex ?
                            Matrix4.translationValues(-22*_animation2.value , 0, 0) : null,
                            alignment: Alignment.center,
                            child: Icon(widget.items[i].icon,color: selectedIndex == i ? Colors.white : Colors.black,),

                          ),

                          Opacity(
                            opacity: i == selectedIndex ? _animation2.value : 1 - _animation2.value,
                            child: Container(
                              transform:
                              i == selectedIndex ?
                              Matrix4.translationValues(22 - 25*_animation2.value , 0, 0) : Matrix4.translationValues(15, 0, 0),

                            alignment: Alignment.centerRight,child: Text("${widget.items[i].title}",style: TextStyle(color: Colors.white,fontSize: 12),)),
                          )

                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
