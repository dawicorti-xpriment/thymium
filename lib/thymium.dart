import './src/compiler.dart';
import './src/generator.dart';
import 'package:xmlstream/xmlstream.dart';

void compileString(String raw, [callback]) {
  var compiler = new Compiler();
  return compiler.compile(raw, callback);
}