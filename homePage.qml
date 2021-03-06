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

                Rectangle {
                    id: whiteCard_1
                    width: 340
                    color: "#ffffff"
                    radius: 10
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10

                    Image {
                        id: iconCart
                        sourceSize.height: 100
                        sourceSize.width: 100
                        anchors.leftMargin: 70
                        visible: false
                        anchors.left: parent.left
                        anchors.top: parent.top
                        source: "senfonico_logo.png"
                        fillMode: Image.PreserveAspectFit
                        antialiasing: false
                    }

                    Image {
                        id: iconCartInsta
                        sourceSize.height: 30
                        sourceSize.width: 30
                        anchors.leftMargin: 35
                        anchors.topMargin: 70
                        visible: true
                        anchors.left: parent.left
                        anchors.top: parent.top
                        source: "instagram_story.png"
                        fillMode: Image.PreserveAspectFit
                        antialiasing: false
                    }

                    ColorOverlay{
                        anchors.fill: iconCart
                        source: iconCart
                        color: "#7f7f7f"
                        antialiasing: false
                    }


                    CustomTextField{
                    id: kullaniciAdi
                    x:30
                    y:110
                    placeholderText: "Giri?? yap??lacak hesab??n kullan??c?? ad??n?? giriniz. "
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {

                    }
                    Keys.onReturnPressed: {

                    }
                }

                    CustomTextField{
                    id: sifre
                    x:30
                    y:160
                    placeholderText: "Giri?? yap??lacak hesab??n ??ifresini giriniz. "
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {

                    }
                    Keys.onReturnPressed: {

                    }
                }


                    CustomTextField{
                    id: username
                    implicitWidth: 175
                    x:30
                    y:448
                    placeholderText: "Kullan??c?? ad??n?? giriniz."
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {
                    }
                    Keys.onReturnPressed: {
                        backend.toGetDownloadStory(username.text, kullaniciAdi.text, sifre.text)

                    }
                }


                    CustomButton {
                        x: 227
                        y: 153
                        width: 108
                        height: 37
                        text: "Story ??ndir"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 15
                        colorMouseOver: "#40405f"
                        colorPressed: "#55aaff"
                        colorDefault: "#33334c"
                        anchors.bottomMargin: 14
                        onClicked: {
                        backend.toGetDownloadStory(username.text, kullaniciAdi.text, sifre.text)
                    }


                    }

                    Rectangle {
                        id: hideValue_1
                        x: 8
                        y: 146
                        width: 187
                        height: 44
                        color: "#ebfcff"
                        radius: 5
                        visible: !showValue
                    }
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

                    anchors.topMargin: 10
                    anchors.rightMargin: 15
                    anchors.leftMargin: 40
                    rows: 2
                    columns: 3





                    Label {
                        id: textValue_3
                        color: "#ffffff"
                        text: qsTr("Kullanmadan ??nce:\n\n Uygulaman??n alt men??lerinde Instagram Story ve di??er sosyal medya \n platformlar?? i??in link ??ekme se??enekleri mevcuttur. Kullan??c?? ad??n?? girip \n\" Story ??ndir \"butonuna bast??????n??z anda masa??st??n??zde otomatik olarak\n \"Senfonico Linkler\" klas??r?? olu??turulacakt??r. Story ve link i??eriklerinin hepsi\n bu klas??rde toplanacakt??r. Butona bast??ktan sonra i??lem yapt??????n??z tarih ve saat \n ad??nda (??r: 2021-7-22 (Story)) klas??r a????l??p ekran??n??za yans??yacakt??r. Ayr??ca \n birden fazla hesap i??in g??n??n story'lerini indirmek isterseniz her kullan??c?? ad??ndan \n sonra araya bo??luk b??rakmadan tire \"-\" koyman??z yeterlidir. \n ??RNEK:redbulltr-bekoturkiye-netflixturkiye \n Video format??nda olan storyler .mp4, foto??raf format??nda olan storyler .jpg \n format??nda indirilecektir. \n\n * Bu i??lemler internet h??z??n??za ve bilgisayar performans??n??za g??re de??i??kenlik \n g??sterecek olup butona t??klad??ktan sonra en az 30 saniye ilk klas??r??n a????lmas??n?? \n bekleyin. E??er uygulama kendinden kapan??rsa l??tfen hesap de??i??tirip tekrar deneyin. \n\n * L??tfen kullan??c?? ad??n?? b??y??k-k??????k harf durumunu dikkate alarak yaz??n. ")
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                        font.pointSize: 13
                        font.bold: false
                        font.family: "Segoe UI"
                        visible:  showValue
                    }
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

    }

    Connections{
        target: backend

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#c0c0c0";height:800;width:800}D{i:65;property:"anchors.leftMargin";target:"greenBar"}
D{i:69;property:"opacity";target:"greenBar"}D{i:73;property:"anchors.leftMargin";target:"greenBar1"}
D{i:77;property:"opacity";target:"greenBar1"}D{i:58}
}
##^##*/
