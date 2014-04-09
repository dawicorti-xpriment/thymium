import 'generator.dart';
import 'tinode.dart';
import 'package:xmlstream/xmlstream.dart';

class Compiler {

  TiNode _root = null;
  List<TiNode> _stack;
  dynamic _callback = (){};


  Compiler() {
    _stack = new List<TiNode>();
  }

  void onEvent(event) {
    if (event.state == XmlState.Open) return onTagOpen(event);
    if (event.state == XmlState.Closed) return onTagClosed(event);
    if (event.state == XmlState.Attribute) return onTagAttributeSet(event);
    if (event.state == XmlState.EndDocument) {
      try {
        _callback(_root);
      } catch (e) {
        print('Failed to call compiler callback');
      }
    }
  }

  void onTagOpen(event) {
    var node = new TiNode(event.value);

    if (_root == null) _root = node;
    if (_stack.length > 0) _stack.last.append(node);

    _stack.add(node);
  }

  void onTagClosed(event) {
    _stack.removeLast();
  }

  void onTagAttributeSet(event) {
    if (_stack.length > 0) _stack.last.setAttribute(event.key, event.value);
  }


  void compile(String raw, [callback]) {
    if (callback != null) _callback = callback;

    XmlStreamer xmlStreamer = new XmlStreamer(raw);
    xmlStreamer.read().listen(onEvent);
  }

}