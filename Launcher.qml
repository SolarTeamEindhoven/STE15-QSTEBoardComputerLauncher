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
import QtGraphicalEffects 1.0

import nl.solarteameindhoven.sdk 1.0

BCVehicleLauncher {
    id: launcher
    anchors.fill: parent

    // App manager
    BCAppManager {
        id: appManager

        onAvailableAppsChanged: {
            for (var i = 0; i < availableApps.length; i++)
            {
                if (availableApps[i].category === "navigation") {
                    navigationAppViewer.app = getApp(availableApps[i]);
                } else if (availableApps[i].category === "audio") {
                    audioAppViewer.app = getApp(availableApps[i]);
                } else if (availableApps[i].category === "configuration") {
                    configAppViewer.app = getApp(availableApps[i]);
                } else if (availableApps[i].category === "info") {
                    infoAppViewer.app = getApp(availableApps[i]);
                }
            }
        }
    }

    // Header / info display
    Rectangle {
        id: infoRegion
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 50
        color: "#000"

        // Date & time display
        Rectangle {
            anchors.right: parent.right
            id: dateTimeRegion
            Text {
                id: timeRegion
                color: "#FFF"
                anchors.top: parent.top
                anchors.right: parent.right
                text: Qt.formatDateTime(new Date(), "hh:mm");
            }
            Text {
                id: dateRegion
                color: "#FFF"
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                text: Qt.formatDateTime(new Date(), "MMM dd");
            }
            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: timeRegion.text = Qt.formatDateTime(new Date(), "hh:mm")
            }
        }
    }

    // Application content
    Rectangle {
        id: appRegion
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: infoRegion.bottom
        color: "#aaa"

        BCVehicleAppContainer {
            id: navigationAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            anchors.topMargin: 10

            height: parent.height / 4
        }

        BCVehicleAppContainer {
            id: audioAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: navigationAppViewer.bottom

            anchors.topMargin: 10

            height: parent.height / 4
        }

        BCVehicleAppContainer {
            id: configAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: audioAppViewer.bottom

            anchors.topMargin: 10

            height: parent.height / 4
        }

        BCVehicleAppContainer {
            id: infoAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: configAppViewer.bottom
            anchors.bottom: parent.bottom

            anchors.topMargin: 10

            height: parent.height / 4
        }
    }

    // Control bar
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

