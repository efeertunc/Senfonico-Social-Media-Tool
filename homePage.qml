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
                    placeholderText: "Giriş yapılacak hesabın kullanıcı adını giriniz. "
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
                    placeholderText: "Giriş yapılacak hesabın şifresini giriniz. "
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
                    placeholderText: "Kullanıcı adını giriniz."
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
                        text: "Story İndir"
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
                        text: qsTr("Kullanmadan önce:\n\n Uygulamanın alt menülerinde Instagram Story ve diğer sosyal medya \n platformları için link çekme seçenekleri mevcuttur. Kullanıcı adını girip \n\" Story İndir \"butonuna bastığınız anda masaüstünüzde otomatik olarak\n \"Senfonico Linkler\" klasörü oluşturulacaktır. Story ve link içeriklerinin hepsi\n bu klasörde toplanacaktır. Butona bastıktan sonra işlem yaptığınız tarih ve saat \n adında (Ör: 2021-7-22 (Story)) klasör açılıp ekranınıza yansıyacaktır. Ayrıca \n birden fazla hesap için günün story'lerini indirmek isterseniz her kullanıcı adından \n sonra araya boşluk bırakmadan tire \"-\" koymanız yeterlidir. \n ÖRNEK:redbulltr-bekoturkiye-netflixturkiye \n Video formatında olan storyler .mp4, fotoğraf formatında olan storyler .jpg \n formatında indirilecektir. \n\n * Bu işlemler internet hızınıza ve bilgisayar performansınıza göre değişkenlik \n gösterecek olup butona tıkladıktan sonra en az 30 saniye ilk klasörün açılmasını \n bekleyin. Eğer uygulama kendinden kapanırsa lütfen hesap değiştirip tekrar deneyin. \n\n * Lütfen kullanıcı adını büyük-küçük harf durumunu dikkate alarak yazın. ")
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
