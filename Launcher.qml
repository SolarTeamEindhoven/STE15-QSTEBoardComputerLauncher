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

VehicleLauncher {
    id: launcher
    width: appRegion.width + 200
    height: appRegion.width + 200

    onAppsChanged: {
        if(apps.length > 0)
        {
            navigationAppViewer.app = apps[0]
        }
    }

    function getAppContainerByLocation(position)
    {
        if( position >= navigationAppViewer.y && position <= (navigationAppViewer.y + navigationAppViewer.height) )
            return navigationAppViewer;

        if( position >= audioAppViewer.y && position <= (audioAppViewer.y + audioAppViewer.height) )
            return audioAppViewer;

        if( position >= configAppViewer.y && position <= (configAppViewer.y + configAppViewer.height) )
            return configAppViewer;

        if( position >= infoAppViewer.y && position <= (infoAppViewer.y + infoAppViewer.height) )
            return infoAppViewer;

        return null;
    }

    Rectangle {
        id: appRegion

        width: 7 * 20 * Screen.pixelDensity //600
        height: 300 * Screen.pixelDensity
        anchors.top: launcher.top
        anchors.left: launcher.left
        anchors.leftMargin: (launcher.width - width) / 2

        color: "#aaa"

        VehicleAppContainer {
            id: navigationAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            height: parent.height / 4
        }

        VehicleAppContainer {
            id: audioAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: navigationAppViewer.bottom

            height: parent.height / 4
        }

        VehicleAppContainer {
            id: configAppViewer
            bccontrolBarHardwareInterface: controlBarHardwareInterface

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: audioAppViewer.bottom

            height: parent.height / 4
        }

        VehicleAppContainer {
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

        anchors.left: appRegion.left
        anchors.right: appRegion.right

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

