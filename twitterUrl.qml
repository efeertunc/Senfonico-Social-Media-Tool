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
                        sourceSize.height: 25
                        sourceSize.width: 25
                        anchors.leftMargin: 35
                        anchors.topMargin: 70
                        visible: true
                        anchors.left: parent.left
                        anchors.top: parent.top
                        source: "twitter_link.png"
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
                    id: username
                    implicitWidth: 175
                    x:30
                    y:448
                    placeholderText: "Kullan??c?? ad??n?? giriniz. "
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {
                    }
                    Keys.onReturnPressed: {
                    backend.toGetTwitterLink(username.text,startDate.text,endDate.text)
                    }
                }


                    CustomTextField{
                    id: endDate
                    x:30
                    y:400
                    placeholderText: "Biti?? tarihini giriniz. ??r: 2021-07-29 "
                    Layout.fillWidth: true

                    Keys.onEnterPressed: {


                    }
                    Keys.onReturnPressed: {

                    }
                }

                    CustomTextField{
                    id: startDate
                    x:30
                    y:352
                    placeholderText: "Ba??lang???? tarihini giriniz. ??r: 2021-06-19 "
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {

                    }
                    Keys.onReturnPressed: {

                    }
                }

                    CustomButton {
                        x: 227
                        y: 150
                        width: 108
                        height: 37
                        text: "Link ??ndir"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 15
                        colorMouseOver: "#40405f"
                        colorPressed: "#55aaff"
                        colorDefault: "#33334c"
                        anchors.bottomMargin: 14
                        onClicked: {
                        //progress.indeterminate = false
                        backend.toGetTwitterLink(username.text,startDate.text,endDate.text)


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
                        wrapMode: Text.Wrap
                        color: "#ffffff"
                        text: qsTr("Kullanmadan ??nce:\n\n Kullan??c?? ad??n??, linkleri indirmek istedi??iniz tarih aral??????n?? girip \" Link ??ndir \"butonuna \n bast??????n??z anda masa??st??n??zde otomatik olarak \"Senfonico Linkler\" klas??r?? \n olu??turulacakt??r. Link i??eriklerinin hepsi bu klas??rde toplanacakt??r. Butona bast??ktan sonra \n i??lem yapt??????n??z tarih ve saat ad??nda (??r: 2021-7-22 (Twitter)) klas??r a????l??p \n ekran??n??za yans??yacakt??r. Ayr??ca birden fazla hesap i??in linkleri indirmek isterseniz \n her kullan??c?? ad??ndan  sonra araya bo??luk b??rakmadan tire \"-\" koyman??z yeterlidir. \n ??RNEK:lolespor-netflixturkiye \n NOT: Ba??lang???? ve biti?? tarihleri \" YIL-AY-G??N\" olarak ayarlanm????t??r. L??tfen farkl?? formatta \n tarih giri??i yapmay??n??z. Ayr??ca tarih bilgisini girerken araya \" /, .,_,\"\n gibi i??aretler koymay??n ve sadece tire \"-\" i??aretini kullan??n. Almak istedi??iniz linkler dosya \n boyutunu minimize etmek i??in .txt dosyas??nda saklanacakt??r. \n\n * Bu i??lemler internet h??z??n??za ve bilgisayar performans??n??za g??re de??i??kenlik \n g??sterecek olup butona t??klad??ktan sonra en az 30 saniye ilk klas??r??n a????lmas??n?? \n bekleyin. E??er uygulama kendinden kapan??rsa l??tfen geli??tiriciye bu durumu bildiirin. \n\n * L??tfen kullan??c?? ad??n?? b??y??k-k??????k harf durumunu dikkate alarak yaz??n. ")
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pointSize: 13
                        font.bold: false
                        font.family: "Segoe UI"
                        visible:  showValue
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
}}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#c0c0c0";height:800;width:800}D{i:65;property:"anchors.leftMargin";target:"greenBar"}
D{i:69;property:"opacity";target:"greenBar"}D{i:73;property:"anchors.leftMargin";target:"greenBar1"}
D{i:77;property:"opacity";target:"greenBar1"}D{i:58}
}
##^##*/
