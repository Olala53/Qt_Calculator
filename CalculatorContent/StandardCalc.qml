import QtQuick
import QtQuick.Controls
import Kalkulator
import QtQuick.Layouts

Item {

    property string actNumber: ""
    property string currentOperator: "n"
    property double firstNumber: 0
    property double acumulator: 0
    property double memory: 0

    rotation: 0

    SystemPalette {
        id: myPalette
        colorGroup: SystemPalette.Active
    }

    id: rectangle

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    component DButton: RoundButton {
        id: dbutton
        Layout.fillHeight: true
        Layout.fillWidth: true
        radius: 3
        background: Rectangle {
            color: dbutton.pressed ? "#4CAF50" : (dbutton.hovered ? "#555555" : "#333333")
            radius: 3
        }
        contentItem: Item {
            anchors.fill: parent
            Text {
                text: dbutton.text
                font.pixelSize: 18
                font.bold: true
                color: "#ffffff"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        function performoperation(actNumber, operation) {
            firstNumber = parseFloat(actNumber)
            switch (operation){
            case "+":
                acumulator = acumulator + firstNumber
                break;
            case "-":
                acumulator = acumulator - firstNumber
                break;
            case "x":
                acumulator = acumulator * firstNumber
                break;
            case "/":
                acumulator = acumulator / firstNumber
                break;
            case "1/x":
                acumulator = acumulator + 1/firstNumber
                break;
            case "x^2":
                acumulator = firstNumber * firstNumber
                break;
            case "+/-":
                acumulator = -firstNumber
                break;
            case "n":
                acumulator = firstNumber
                break;
            }
        }

        Connections {
            target: dbutton
            onClicked: {

                switch (dbutton.text) {
                case "1":
                case "2":
                case "3":
                case "4":
                case "5":
                case "6":
                case "7":
                case "8":
                case "9":
                    actNumber = actNumber + dbutton.text
                    break
                case "0":
                    if (actNumber != "") {
                        actNumber = actNumber + dbutton.text
                    }
                    break
                case ",":
                    if (actNumber == "") {
                        actNumber = actNumber + "0" + dbutton.text
                    } else if (actNumber.indexOf(".") == -1) {
                        actNumber = actNumber + dbutton.text
                    }
                    break
                case "x^2":
                case "x":
                case "/":
                case "-":
                case "+":
                    if (actNumber != "") {
                        performoperation(actNumber, currentOperator)
                        actNumber = ""
                        currentOperator = dbutton.text
                    }
                    break
                case "1/x":
                    if (actNumber !== "") {
                        var y = parseFloat(actNumber)
                        if (y !== 0) {
                            actNumber = (1 / y).toString()
                        }
                    }
                    break
                case "\u221a(x)":
                    if (actNumber != "") {
                        var x = parseFloat(actNumber)
                        if (x >= 0) {
                            actNumber = Math.sqrt(x).toString()
                        }
                    }
                    break
                case "+/-":
                    if (actNumber.indexOf("-") == -1) {
                        actNumber = "-" + actNumber
                    } else {
                        actNumber = actNumber.substring(1)
                    }
                    break
                case "%":
                    if (actNumber !== "") {
                        let percentValue = parseFloat(actNumber) / 100
                        switch (currentOperator) {
                        case "+":
                        case "-":
                        case "x":
                        case "/":
                            acumulator = acumulator * percentValue
                            break
                        default:
                            acumulator = percentValue
                            break
                        }
                        actNumber = ""
                        currentOperator = "n"
                    }
                    break
                case "=":
                    if (actNumber != "") {
                        performoperation(actNumber, currentOperator)
                        actNumber = ""
                        currentOperator = "n"
                    }
                    break
                case "C":
                    acumulator = 0
                    actNumber = ""
                    break
                case "CE":
                    actNumber = ""
                    break
                case "\u232B":
                    if (actNumber.length > 0) {
                        actNumber = actNumber.slice(0, -1)
                    }
                    break
                case "M":
                    memory = acumulator
                    break
                case "MR":
                    actNumber = memory.toString()
                    break
                case "M+":
                    memory = memory + acumulator
                    break
                case "M-":
                    memory = memory - acumulator
                    break
                case "MS":
                    memory = actNumber
                    break
                case "MC":
                    memory = 0
                    break
                }
            }
        }
    }

    Text {
        color: "#FFFFFF"
        text: rectangle.actNumber == "" ? rectangle.acumulator : rectangle.actNumber
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: przyciskinumeryczne.top
        anchors.leftMargin: 4
        anchors.rightMargin: 4
        anchors.bottomMargin: 25
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.ExtraBold
        font.bold: true
        font.pointSize: 40
    }

    ColumnLayout {
        id: przyciskinumeryczne
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: rectangle.height * 3 / 10
        anchors.bottomMargin: 5

        uniformCellSizes: true

        RowLayout {
            width: 7
            Layout.fillHeight: true
            Layout.fillWidth: true
            uniformCellSizes: true

            DButton {
                text: "MC"
                background: Rectangle {
                    color: "#000000"
                    radius: 3
                }
            }

            DButton {
                text: "MR"
                background: Rectangle {
                    color: "#000000"
                    radius: 3
                }
            }

            DButton {
                text: "M+"
                background: Rectangle {
                    color: "#000000"
                    radius: 3
                }
            }

            DButton {
                text: "M-"
                background: Rectangle {
                    color: "#000000"
                    radius: 3
                }
            }

            DButton {
                text: "MS"
                background: Rectangle {
                    color: "#000000"
                    radius: 3
                }
            }

            DButton {
                text: "M"
                background: Rectangle {
                    color: "#000000"
                    radius: 3
                }
            }
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            uniformCellSizes: true
            DButton {
                text: "%"
            }

            DButton {
                text: "CE"
            }

            DButton {
                text: "C"
            }

            DButton {
                text: "\u232B"
            }
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            uniformCellSizes: true
            DButton {
                text: "1/x"
            }

            DButton {
                text: "x^2"
            }

            DButton {
                text: "\u221a(x)"
            }

            DButton {
                text: "/"
            }
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            uniformCellSizes: true
            DButton {
                text: "7"
            }

            DButton {
                text: "8"
            }

            DButton {
                text: "9"
            }

            DButton {
                text: "x"
            }
        }
        RowLayout {
            uniformCellSizes: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            DButton {
                text: "4"
            }

            DButton {
                text: "5"
            }

            DButton {
                text: "6"
            }

            DButton {
                text: "-"
            }
        }
        RowLayout {
            uniformCellSizes: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            DButton {
                text: "1"
            }

            DButton {
                text: "2"

            }

            DButton {
                text: "3"
            }

            DButton {
                text: "+"
            }
        }
        RowLayout {
            uniformCellSizes: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            DButton {
                text: "+/-"
            }

            DButton {
                text: "0"
            }

            DButton {
                text: ","
            }

            DButton {
                text: "="
                background: Rectangle {
                    color: "#51db45"
                    radius: 3
                }
            }
        }
    }
}

