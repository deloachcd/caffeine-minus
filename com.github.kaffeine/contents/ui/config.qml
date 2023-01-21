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
import QtQuick.Controls 2.2

Item {
    id: configPage

    property alias cfg_updateInterval: updateIntervalSpinBox.value
    property alias cfg_updateIntervalUnit: updateIntervalUnitSpinBox.value
    property string cfg_iconOn: plasmoid.configuration.iconOn
    property string cfg_iconOff: plasmoid.configuration.iconOff
    
    function setInterval() {
        if (updateIntervalUnitSpinBox.value == 1) {
            plasmoid.configuration.interval = updateIntervalSpinBox.value * 60;
        } else if (updateIntervalUnitSpinBox.value == 2) {
            plasmoid.configuration.interval = updateIntervalSpinBox.value * 60 * 60;
        } else {
            plasmoid.configuration.interval = updateIntervalSpinBox.value;   
        }
    }
    
    ColumnLayout {
        GridLayout {
            columns: 2
            Label {
                Layout.row: 0
                Layout.column: 0
                text: i18n("Icon")
            }
            IconPicker {
                Layout.row: 0
                Layout.column: 1
                currentIcon: cfg_iconOn
                defaultIcon: "security-high"
                    onIconChanged: cfg_iconOn = iconName
                    enabled: true
            }
 
            Label {
                Layout.row: 1
                Layout.column: 0
                text: i18n("Icon")
            }
            IconPicker {
                Layout.row: 1
                Layout.column: 1
                currentIcon: cfg_iconOff
                defaultIcon: "security-high"
                    onIconChanged: cfg_iconOff = iconName
                    enabled: true
            }
            
            Label {
                Layout.row: 2
                Layout.column: 0
                text: i18n("Fake keypress every")
            }
            GridLayout {
                columns: 2
                Layout.row: 2
                Layout.column: 1
                SpinBox {
                    Layout.row: 0
                    Layout.column: 0
                    id: updateIntervalSpinBox
                    stepSize: 1
                    from: 1
                    onValueModified: setInterval()
                }
                SpinBox {
                    Layout.row: 0
                    Layout.column: 1
                    id: updateIntervalUnitSpinBox
                    from: 0
                    to: items.length - 1
                    onValueModified: setInterval()
                    
                    property var items: ["s", "min", "h"]
                    
                    validator: RegExpValidator {
                        regExp: new RegExp("(s|min|h)", "i")
                    }
                    
                    textFromValue: function(value) {
                        return items[value];
                    }
                    
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                }
            }
        }   
    }
}
