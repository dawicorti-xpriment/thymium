import '../lib/thymium.dart' as thymium;
import '../lib/src/tinode.dart';

void toto(TiNode root) {
  root.generate({});
}

void main() {
  thymium.compileString('<window><view id="myView"><button></button></view></window>', toto);
}