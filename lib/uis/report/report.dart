import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:clipboard/clipboard.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  String _markdownData = """
# Markdown Example
Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.

## Titles

Setext-style

```
This is an H1
=============

This is an H2
-------------
```

Atx-style

```
# This is an H1

## This is an H2

###### This is an H6
```

Select the valid headers:

- [x] `# hello`
- [ ] `#hello`

## Links

[Link para pasta do grupo](https://drive.google.com/drive/folders/1oogMDQbY8JRyMw-iZvcE4Cz6cfp0S0kR?usp=sharing)

[Link para foto do grupo](https://drive.google.com/file/d/1KbZnacybfkBAiq_8tVrxx3eTAgKDsS_0/view?usp=sharing)

[google](https://www.google.com)
```
[inline-style](https://www.google.com)

[reference-style][Google]
```

## Images
ola
<iframe src="https://drive.google.com/file/d/1KbZnacybfkBAiq_8tVrxx3eTAgKDsS_0/preview" width="340" height="280"></iframe>

![Foto em servidor](https://t1.uc.ltmcdn.com/pt/images/3/7/6/img_o_que_significa_pagar_o_pato_23673_orig.jpg)

## Tables

|Syntax                                 |Result                               |
|---------------------------------------|-------------------------------------|
|`*italic 1*`                           |*italic 1*                           |
|`_italic 2_`                           | _italic 2_                          |
|`**bold 1**`                           |**bold 1**                           |
|`__bold 2__`                           |__bold 2__                           |
|`This is a ~~strikethrough~~`          |This is a ~~strikethrough~~          |
|`***italic bold 1***`                  |***italic bold 1***                  |
|`___italic bold 2___`                  |___italic bold 2___                  |
|`***~~italic bold strikethrough 1~~***`|***~~italic bold strikethrough 1~~***|
|`~~***italic bold strikethrough 2***~~`|~~***italic bold strikethrough 2***~~|

## Styling
Style text as _italic_, __bold__, ~~strikethrough~~, or `inline code`.

- Use bulleted lists
- To better clarify
- Your points

## Code blocks
Formatted Dart code looks really pretty too:

```
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Markdown(data: markdownData),
    ),
  ));
}
```

## Center Title

###### ※ ※ ※

_* How to implement it see main.dart#L129 in example._

## Custom Syntax

NaOH + Al_2O_3 = NaAlO_2 + H_2O

C_4H_10 = C_2H_6 + C_2H_4

## Markdown widget

This is an example of how to create your own Markdown widget:

    Markdown(data: 'Hello _world_!');

Enjoy!

[Google]: https://www.google.com/

## Line Breaks

This is an example of how to create line breaks (tab or two whitespaces):

line 1
  
   
line 2
  
  
  
line 3
""";

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Report'),
        actions: [
          IconButton(
            icon: Icon(Icons.content_paste),
            tooltip: 'Copiar relatório. Fazer um CTRL-c.',
            onPressed: () {
              FlutterClipboard.copy(_markdownData).then((value) {
                print('copied');
                scaffoldState.currentState.showSnackBar(SnackBar(
                    content: Text('Relatório copiado. CTRL-c concluído.')));
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Markdown(
          controller: controller,
          selectable: true,
          data: _markdownData,
          imageDirectory: 'https://raw.githubusercontent.com',
          builders: {
            'h6': CenteredHeaderBuilder(),
            'sub': SubscriptBuilder(),
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () => controller.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }
}

class CenteredHeaderBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle preferredStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text.text, style: preferredStyle),
      ],
    );
  }
}

class SubscriptBuilder extends MarkdownElementBuilder {
  static const List<String> _subscripts = [
    '₀',
    '₁',
    '₂',
    '₃',
    '₄',
    '₅',
    '₆',
    '₇',
    '₈',
    '₉'
  ];

  @override
  Widget visitElementAfter(md.Element element, TextStyle preferredStyle) {
    // We don't currently have a way to control the vertical alignment of text spans.
    // See https://github.com/flutter/flutter/issues/10906#issuecomment-385723664
    String textContent = element.textContent;
    String text = '';
    for (int i = 0; i < textContent.length; i++) {
      text += _subscripts[int.parse(textContent[i])];
    }
    return SelectableText.rich(TextSpan(text: text));
  }
}

class SubscriptSyntax extends md.InlineSyntax {
  static final _pattern = r'_([0-9]+)';

  SubscriptSyntax() : super(_pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('sub', match[1]));
    return true;
  }
}
