import 'package:bmi_calculator/calculatorBrain.dart';
import 'package:bmi_calculator/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/button_bottom.dart';
import '../components/card_content.dart';
import '../components/reuse_container.dart';
import '../components/round_icon_button.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Gender? selectedGender;
  int height = 180;
  int weight = 60;
  int age = 16;

  void weightDecreasement() {
    weight--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReuseContainer(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                      cardChild: CardContent(
                        icon: FontAwesomeIcons.mars,
                        label: 'Male',
                      ),
                      colour: selectedGender == Gender.male
                          ? kActiveCardColour
                          : kInActiveCardColour,
                    ),
                  ),
                  Expanded(
                    child: ReuseContainer(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                      cardChild: CardContent(
                        icon: FontAwesomeIcons.venus,
                        label: 'Female',
                      ),
                      colour: selectedGender == Gender.female
                          ? kActiveCardColour
                          : kInActiveCardColour,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReuseContainer(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          activeTickMarkColor: Color(0xFFEB1555),
                          inactiveTickMarkColor: Color(0xFF8D8E98),
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0)),
                      child: Slider(
                        activeColor: Color(0xFFEB1555),
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          print(newValue);
                          setState(() {
                            height = newValue.toInt();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReuseContainer(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPress: () {
                                  setState(() {
                                    weightDecreasement();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPress: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      colour: kActiveCardColour,
                    ),
                  ),
                  Expanded(
                    child: ReuseContainer(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Age',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                onPress: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                icon: FontAwesomeIcons.minus,
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              RoundIconButton(
                                onPress: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                icon: FontAwesomeIcons.plus,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonBottom(
              buttonTitle: 'CALCULATE',
              onTap: () {
                CalculatorBrain calc =
                    CalculatorBrain(height: height, weight: weight);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultPage(
                              bmiResult: calc.calculateBMI(),
                              resultText: calc.getResult(),
                              interpretation: calc.getInterpretation(),
                            )));
              },
            )
          ],
        ));
  }
}

enum Gender { male, female }
