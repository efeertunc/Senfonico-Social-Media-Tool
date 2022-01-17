import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Timeline 1.0
import QtQuick.Controls 1.1

Item {

    property bool showValue: true

    Flickable {
        id: flickable
        opacity: 0
        anchors.fill: parent
        contentHeight: gridLayout.height
        clip: true

        GridLayout {
            id: gridLayout
            columns: 1
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            columnSpacing: 10
            rows: 3

            Rectangle{
                id: card
                color: "#27273a"
                height: 520
                width: flickable.width
                radius: 10



                Label {
                        id: textValue_3
                        x:50
                        y:30
                        color: "#ffffff"
                        text: qsTr(" Bu uygulama Python ve Qml kullanılarak geliştirilmiştir. Programı geliştirmek isterseniz GitHub üzerinden kaynak kodlarına \n erişim yetkisi verilecektir. Senfonico Social Media Tool, bilgisayarınızdan hiçbir veri toplamaz ve kaydetmez. \n Herhangi bir konu hakkında destek almak isterseniz : eertunc19@ku.edu.tr  \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                                                                                                                                                           designed by")
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                        font.pointSize: 13
                        font.bold: true
                        font.family: "Segoe UI"
                        visible:  showValue
                    }

                Text {
                        x:928
                        y:467
                        id: textValue_link_designed
                        property string blogUrl: "https://www.linkedin.com/in/efeertunc/"
                        property string title: "@efertunc"
                        wrapMode: Text.Wrap
                        color: "#ffffff"
                        text: "<a href='" + blogUrl + "'>" + title +"</a>"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pointSize: 13
                        font.bold: false
                        font.family: "Segoe UI"
                        visible:  showValue
                        onLinkActivated: Qt.openUrlExternally(blogUrl)

                    }

                Label {
                    id: labelContaInfo
                    y: 140
                    height: 50
                    opacity: 1
                    color: "#b907ff"
                    anchors.left: whiteCard_1.right
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignBottom
                    anchors.rightMargin: 15
                    anchors.bottomMargin: 30
                    anchors.leftMargin: 40
                    font.bold: false
                    font.pointSize: 10
                    font.family: "Segoe UI"
                    font.weight: Font.Normal
                    textFormat: Text.RichText
                    anchors.topMargin: 5
                }

                GridLayout {
                    id: textsFatura
                    x: 402
                    y: 52
                    anchors.left: whiteCard_1.right
                    anchors.right: parent.right
                    anchors.top: greenBar.bottom
                    anchors.topMargin: 10
                    anchors.rightMargin: 15
                    anchors.leftMargin: 40
                    rows: 2
                    columns: 3


                }
            }
        }
        ScrollBar.vertical: ScrollBar {
            id: control
            size: 0.3
            position: 0.2
            orientation: Qt.Vertical
            visible: flickable.moving || flickable.moving

            contentItem: Rectangle {
                implicitWidth: 6
                implicitHeight: 100
                radius: width / 2
                color: control.pressed ? "#55aaff" : "#40405f"
            }
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                running: true
                loops: 1
                duration: 1000
                to: 1000
                from: 0
            }
        ]
        endFrame: 1000
        enabled: true
        startFrame: 0

        KeyframeGroup {
            target: flickable
            property: "opacity"
            Keyframe {
                frame: 550
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: greenBar
            property: "anchors.leftMargin"
            Keyframe {
                easing.bezierCurve: [0.254,0.00129,0.235,0.999,1,1]
                value: 40
                frame: 850
            }

            Keyframe {
                value: 400
                frame: 399
            }

            Keyframe {
                value: 400
                frame: 0
            }
        }

        KeyframeGroup {
            target: greenBar
            property: "opacity"
            Keyframe {
                value: 1
                frame: 650
            }

            Keyframe {
                value: 0
                frame: 399
            }

            Keyframe {
                value: 0
                frame: 0
            }
        }

        KeyframeGroup {
            target: greenBar1
            property: "anchors.leftMargin"
            Keyframe {
                easing.bezierCurve: [0.254,0.00129,0.235,0.999,1,1]
                value: 40
                frame: 998
            }

            Keyframe {
                value: 400
                frame: 548
            }

            Keyframe {
                value: 400
                frame: 0
            }
        }

        KeyframeGroup {
            target: greenBar1
            property: "opacity"
            Keyframe {
                value: 1
                frame: 749
            }

            Keyframe {
                value: 0
                frame: 547
            }

            Keyframe {
                value: 0
                frame: 0
            }
        }
    }

    Connections{
        target: backend

        function onSetName(name){
            textValue_3.text = name
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#c0c0c0";height:800;width:800}D{i:65;property:"anchors.leftMargin";target:"greenBar"}
D{i:69;property:"opacity";target:"greenBar"}D{i:73;property:"anchors.leftMargin";target:"greenBar1"}
D{i:77;property:"opacity";target:"greenBar1"}D{i:58}
}
##^##*/
