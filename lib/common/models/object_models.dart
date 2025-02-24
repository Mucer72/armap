import 'package:ar_flutter_plugin_updated/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart';

class ArrowNode extends ARNode {
  ArrowNode(Vector3 position, Vector3 angle)
      : super(
          type: NodeType.localGLTF2,
          uri: 'arrow.glb',
          scale: Vector3(1, 1, 1),
          position: position,
          rotation: Vector4(0.1, 0, 0.0, 0.0),
          eulerAngles: angle,
        );
}