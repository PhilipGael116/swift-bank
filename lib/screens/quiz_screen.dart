import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<int> _selectedAnswers = List.filled(3, -1);
  bool _showResult = false;

  final List<_Question> _questions = const [
    _Question(
      prompt: 'Which habit helps you save more money?',
      options: ['Spending before budgeting', 'Tracking expenses', 'Ignoring bills'],
      correctIndex: 1,
    ),
    _Question(
      prompt: 'What is the safest way to protect your card info?',
      options: ['Share CVV openly', 'Use secure apps only', 'Write PIN on the card'],
      correctIndex: 1,
    ),
    _Question(
      prompt: 'Why is budgeting important?',
      options: ['It reduces surprises', 'It increases debt', 'It removes goals'],
      correctIndex: 0,
    ),
  ];

  int get _score {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctIndex) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: _kBrandBlue,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: _kInkPrimary,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Quiz',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _kInkPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: _kFieldBorder),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Finance Quiz',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: _kInkPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Answer these quick questions to test your money skills.',
                            style: TextStyle(fontSize: 13, color: _kInkMuted),
                          ),
                          const SizedBox(height: 18),
                          for (int i = 0; i < _questions.length; i++)
                            _QuizCard(
                              question: _questions[i],
                              selectedIndex: _selectedAnswers[i],
                              onSelect: (index) {
                                setState(() {
                                  _selectedAnswers[i] = index;
                                  _showResult = false;
                                });
                              },
                            ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FilledButton(
                              onPressed: () => setState(() => _showResult = true),
                              style: FilledButton.styleFrom(
                                backgroundColor: _kBrandBlue,
                                shape: const StadiumBorder(),
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Check answers'),
                            ),
                          ),
                          const SizedBox(height: 18),
                          if (_showResult)
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: _kChipBg,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You scored $_score / ${_questions.length}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: _kInkPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _score == _questions.length
                                        ? 'Excellent! You know your money basics.'
                                        : 'Nice effort. Review the answers and try again.',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: _kInkMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Question {
  const _Question({
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  final String prompt;
  final List<String> options;
  final int correctIndex;
}

class _QuizCard extends StatelessWidget {
  const _QuizCard({
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
  });

  final _Question question;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kChipBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.prompt,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _kInkPrimary,
            ),
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < question.options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => onSelect(i),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: selectedIndex == i ? const Color(0xFFDBEAFE) : Colors.white,
                    border: Border.all(
                      color: selectedIndex == i ? _kBrandBlue : _kFieldBorder,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question.options[i],
                    style: TextStyle(
                      fontSize: 13,
                      color: selectedIndex == i ? _kBrandBlue : _kInkPrimary,
                      fontWeight: selectedIndex == i ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
