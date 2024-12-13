// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import Kalkulator

Window {
    width: Constants.width
    height: Constants.height

    visible: true
    title: "Kalkulator"

    StandardCalc {
        id: mainScreen
        anchors.fill: parent

    }

}

