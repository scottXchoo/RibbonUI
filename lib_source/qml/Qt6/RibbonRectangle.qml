import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

Item {
    id: control
    property string color
    property int radius: 0
    property int topLeftRadius: radius
    property int topRightRadius: radius
    property int bottomLeftRadius: radius
    property int bottomRightRadius: radius
    property real borderWidth: 0
    property var borderColor: Qt.color("transparent")
    default property alias contentItem: container.data

    Shape {
        id: shape
        anchors.fill: parent
        ShapePath {
            capStyle: ShapePath.RoundCap
            strokeWidth: 0
            strokeColor: "transparent"
            fillColor: control.color
            joinStyle: ShapePath.RoundJoin
            startX: control.topLeftRadius; startY: 0
            PathLine { x: shape.width - control.topRightRadius; y: 0 }
            PathArc { x: shape.width; y: control.topRightRadius; radiusX: control.topRightRadius; radiusY: radiusX }
            PathLine { x: shape.width; y: shape.height - control.bottomRightRadius }
            PathArc { x: shape.width - control.bottomRightRadius; y: shape.height; radiusX: control.bottomRightRadius; radiusY: radiusX }
            PathLine { x: control.bottomLeftRadius; y: shape.height }
            PathArc { x: 0; y: shape.height - control.bottomLeftRadius; radiusX: control.bottomLeftRadius; radiusY: radiusX }
            PathLine { x: 0; y: control.topLeftRadius }
            PathArc { x: control.topLeftRadius; y: 0; radiusX: control.topLeftRadius; radiusY: radiusX }
        }
    }

    Shape {
        id: border
        width: shape.width
        height: shape.height
        anchors.centerIn: parent
        ShapePath {
            capStyle: ShapePath.RoundCap
            strokeWidth: control.borderWidth
            strokeColor: control.borderColor
            fillColor: "transparent"
            joinStyle: ShapePath.RoundJoin
            startX: control.topLeftRadius; startY: 0
            PathLine { x: border.width - control.topRightRadius; y: 0 }
            PathArc { x: border.width; y: control.topRightRadius; radiusX: control.topRightRadius; radiusY: radiusX }
            PathLine { x: border.width; y: border.height - control.bottomRightRadius }
            PathArc { x: border.width - control.bottomRightRadius; y: border.height; radiusX: control.bottomRightRadius; radiusY: radiusX }
            PathLine { x: control.bottomLeftRadius; y: border.height }
            PathArc { x: 0; y: border.height - control.bottomLeftRadius; radiusX: control.bottomLeftRadius; radiusY: radiusX }
            PathLine { x: 0; y: control.topLeftRadius }
            PathArc { x: control.topLeftRadius; y: 0; radiusX: control.topLeftRadius; radiusY: radiusX }
        }
    }

    Item{
        id: container
        anchors.fill: parent
        clip: true
        layer.enabled: true
        layer.effect: OpacityMask {
            implicitHeight: container.height
            implicitWidth: container.width
            maskSource: shape
        }
    }
}
