#!/bin/bash
DMG_NAME='mydmg'
VOLUME_NAME'myvolume'
FOLDER_TO_CONVERT_TO_DMG='/path/to/the/folder/you/want/to/create'

hdiutil create -volname $VOLUME_NAME -srcfolder $FOLDER_TO_CONVERT_TO_DMG -ov -format UDZO $DMG_NAME.dmg