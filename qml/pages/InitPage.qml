import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog{
    id: initPage
    property Page popPage
    acceptDestinationReplaceTarget: popPage

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: column.height
        property alias gender: gender
        property alias birthday: birthday

        Column {
            id: column
            width: parent.width

            DialogHeader {
                title: qsTr("Baby Infos")
            }

            SectionHeader {
                text: qsTr("Gender")
            }

            Slider {
                id: gender
                value: -1
                minimumValue:-1
                maximumValue:1
                stepSize: 2
                width: parent.width
                valueText: value < 0 ? ( qsTr("Boy") + " 👦" ): ( qsTr("Gril") + " 👧" )
                onValueChanged: console.log(flick.gender.value)
            }

            SectionHeader {
                text: qsTr("Birthday")
            }

            ValueButton {
                id: birthday
                property date selectedDate

                function openDateDialog() {
                    var dialog = pageStack.push(pickerComponent, {
                                                    date: new Date()
                                                })

                    dialog.accepted.connect(function() {
                        value = dialog.dateText
                        selectedDate = dialog.date
                    })
                }

                label: qsTr("Date")
                value: qsTr("Select")
                width: parent.width
                onClicked: openDateDialog()
            }


        }
        VerticalScrollDecorator {}
    }

    Component {
         id: pickerComponent
         DatePickerDialog {}
     }
    onAccepted: {
        config.gender = flick.gender.value;
        config.birthday = flick.birthday.selectedDate;
        config.first = false;
    }
    onRejected: Qt.quit();
}
