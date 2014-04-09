import 'package:tiel/el.dart';
import 'package:tiel/element.dart';

class TiNode {

  String _name;
  Map _attributes;
  List<TiNode> _children;

  TiNode(String name) {
    _name = name;
    _children = new List<TiNode>();
    _attributes = new Map();
  }

  void setAttribute(name, value) {
    _attributes[name] = value;
  }

  void append(TiNode child) {
    _children.add(child);
  }

  Element generate(Map context) {
    Element myel = el(_name);
    
    _attributes.forEach(function (key, value) {
      myel.attr(key, value);
    });

    _children.forEach(function (child) {
      Element childEl = child.generate(context);
      myel.append(childEl);
    });

    return myel;
  }

}