import QtQuick 2.4
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0
import MeuiKit 1.0 as Meui

Item {
    id: control
    height: 150

    property int value: 0
    property int radius: height * 0.15
    property bool enableAnimation: false

    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: Qt.rgba(57 / 255, 187 / 255, 94 / 255, 0.5)
        radius: control.radius

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: bgRect.width
                height: bgRect.height

                Rectangle {
                    anchors.fill: parent
                    radius: control.radius
                }
            }
        }

        Rectangle {
            id: valueRect
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: control.width * (control.value / 100)
            color: Qt.rgba(57 / 255, 187 / 255, 94 / 255, 1)
            opacity: 1

            Behavior on width {
                SmoothedAnimation {
                    velocity: 1000
                }
            }
        }
    }

    ParticleSystem {
        id: particleSystem
    }

    Emitter {
        id: emitter
        system: particleSystem
        width: parent.width
        height: parent.height
        emitRate: 5
        lifeSpan: 2000
        lifeSpanVariation: 500
        size: 16
        endSize: 32
        enabled: control.enableAnimation

        velocity: AngleDirection {
            angle: 0
            angleVariation: 15
            magnitude: 100
            magnitudeVariation: 50
        }
    }

    ItemParticle {
        system: particleSystem

        delegate: Rectangle {
            id: particleRect
            width: 10
            height: 10
            radius: 10
            color: Qt.rgba(255, 255, 255, 0.3)
        }
    }
}
