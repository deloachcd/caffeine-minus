/*
 * Copyright (C) 2023 by Chandler DeLoach deloach.cdd@gmail.com
 * 
 * Credits to Piotr Markiewicz <p.marki@wp.pl>
 * https://github.com/pmarki/plasmoid-button
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation;
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>
 */
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: root
    property int keypressInterval: Plasmoid.configuration.interval
    
    //Store state of the button
    property bool checked: false
    
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    
    onKeypressIntervalChanged: {
        console.log('* Interval changed: ' + keypressInterval);
        keypressTimer.interval = keypressInterval * 1000;
    }
    
    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: { 
            disconnectSource(sourceName)
        }
        
        function exec(cmd) {
            connectSource(cmd)
        }
    }

    function emulateKeypress() {
        //console.log("Sending " + keyToPress + " signal...")
        executable.exec("~/.local/share/plasma/plasmoids/com.github.deloachcd.caffeine-minus/script/caffeine-worker.sh");
    }
    
    function toggleKeypressTimer() {
        if (checked) {
            keypressTimer.start()
        } else {
            keypressTimer.stop()
        }
    }
    
    function checkStatus() {
        executable.exec(checkStatusScript);
    }
    
    Plasmoid.compactRepresentation: RowLayout {
        id: mainItem
        spacing: 0
        PlasmaCore.IconItem {
            id: icon
            Layout.fillHeight: true
            Layout.fillWidth: true
            source: checked ? plasmoid.configuration.iconOn : plasmoid.configuration.iconOff
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    checked = checked ? false : true
                    toggleKeypressTimer()
                }
            }
        }
    }
    Timer {
        id: keypressTimer
        interval: keypressInterval
        running: false
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            emulateKeypress();
        }
    }
}
