import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:cardcreditflutter/Src/Constant.dart';

class MainPage extends StatefulWidget {
  final List<CreditCardData> cardsData;
  final double space;

  const MainPage({
    Key? key,
    this.cardsData = const[],
    this.space = kSpaceBetweenCard,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? selectedCardIndex;
  late final List<CreditCard> creditCards;

  @override
  void initState(){
    super.initState();
    creditCards = widget.cardsData.map((data){
      return CreditCard(
        backgroundColor: data.backgroundColor,
      );
    }).toList();
  }

  int toUnselectedCardPositionIndex(int indexInAllList){
    if(selectedCardIndex != null){
      if(indexInAllList < selectedCardIndex!){
        return indexInAllList;
      }else{
        return indexInAllList - 1;
      }
    }else{
      throw 'Wrong Usage';
    }
  }

  double _getCardTopPositioned(int index,isSelected){
    if(selectedCardIndex != null){
      if(isSelected){
        return widget.space;
      }else{
        return kSpaceUnselectedCardToTop + toUnselectedCardPositionIndex(index) * kSpaceBetweenUnselectCard;
      }
    }else{
      return widget.space + index * kCardHeight + index * widget.space;
    }
  }

  double _getCardScale(int index,isSelected){
    if(selectedCardIndex != null){
      if(isSelected){
        return 1.0;
      }else{
        int totalUnselectCard = creditCards.length - 1;
        return 1.0 - (totalUnselectCard - toUnselectedCardPositionIndex(index) - 1) * 0.05;
      }
    }else{
      return 1.0;
    }
  }

  void unSelectedCard(){
    setState((){
      selectedCardIndex = null;
    });
  }

  double totalHeightTotalCard(){
    if(selectedCardIndex == null){
      final totalCard = creditCards.length;
      return widget.space * (totalCard + 1) + kCardHeight * totalCard;
    }else{
      return kSpaceUnselectedCardToTop + kCardHeight + (creditCards.length - 2) * kSpaceBetweenUnselectCard + kSpaceBetweenCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pick A Card'
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AnimatedContainer(
                duration: kAnimationDuration,
                height: totalHeightTotalCard(),
                width: mediaQuery.size.width,
              ),
              for(int i = 0; i<creditCards.length; i++)
                AnimatedPositioned(
                  top: _getCardTopPositioned(i, i == selectedCardIndex),
                  duration: kAnimationDuration,
                  child: AnimatedScale(
                    scale: _getCardScale(i, i == selectedCardIndex),
                    duration: kAnimationDuration,
                    child: GestureDetector(
                      onTap: (){
                        setState((){
                          selectedCardIndex = i;
                        });
                      },
                      child: creditCards[i],
                    ),
                  ),
                ),
              if(selectedCardIndex != null)
                Positioned.fill(
                  child: GestureDetector(
                    onVerticalDragEnd: (_){
                      unSelectedCard();
                    },
                    onVerticalDragStart: (_){
                      unSelectedCard();
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  final Color backgroundColor;
  const CreditCard({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CreditCardWidget(
        cardNumber: '123456789012345',
        expiryDate: '07/2022',
        cardHolderName: 'r3nyah',
        cvvCode: '999',
        isChipVisible: false,
        showBackView: false,
        width: kCardWidth,
        height: kCardHeight,
        cardBgColor: backgroundColor,
        onCreditCardWidgetChange: (_){},
      ),
    );
  }
}
