/**************************************************************************
 **
 ** Copyright 2015 Solar Team Eindhoven. All rights reserved.
 **
 ** Licensed under the Apache License, Version 2.0 (the "License");
 ** you may not use this file except in compliance with the License.
 ** You may obtain a copy of the License at
 **
 **   http://www.apache.org/licenses/LICENSE-2.0
 **
 ** Unless required by applicable law or agreed to in writing, software
 ** distributed under the License is distributed on an "AS IS" BASIS,
 ** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ** See the License for the specific language governing permissions and
 ** limitations under the License.
 **
 **************************************************************************/

import QtQuick 2.4
import QtQuick.Window 2.2

import nl.solarteameindhoven.sdk 1.0

BCVehicleLauncher {
    id: launcher
    anchors.fill: parent

    onAppsChanged: {
        if(apps.length > 0)
        {
            navigationAppViewer.app = apps[0]
        }
    }

    Rectangle {
        id: appRegion
        anchors.fill: parent

        color: "#aaa"

        BCVehicleAppContainer {
            id: navigationAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            height: parent.height / 4
        }

        BCVehicleAppContainer {
            id: audioAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: navigationAppViewer.bottom

            height: parent.height / 4
        }

        BCVehicleAppContainer {
            id: configAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: audioAppViewer.bottom

            height: parent.height / 4
        }

        BCVehicleAppContainer {
            id: infoAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: configAppViewer.bottom
            anchors.bottom: parent.bottom
        }
    }


    BCControlBarHardwareInterface {
        id: controlBarHardwareInterface

        topPosition: 0
        bottomPosition: launcher.height
        feedbackPositions: [
            appRegion.y + (height/2) + navigationAppViewer.y + navigationAppViewer.height,
            appRegion.y + (height/2) + audioAppViewer.y      + audioAppViewer.height,
            appRegion.y + (height/2) + configAppViewer.y     + configAppViewer.height,
            appRegion.y + (height/2) + infoAppViewer.y       + infoAppViewer.height,
        ]
    }
}

