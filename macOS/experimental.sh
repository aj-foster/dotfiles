# Tap to Click
#
defaults write com.apple.AppleMultitouchTrackpad Clicking -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -boolean true

# Three-finger drag
#
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -boolean true

# Do not show recent apps in Dock
#
defaults write com.apple.dock show-recents -boolean false

# Group and sort items in Finder by Name
#
defaults write com.apple.finder FXPreferredGroupBy -string Name
defaults write com.apple.finder StandardViewSettings -dict-add IconViewSettings '{ arrangeBy = name; backgroundColorBlue = 1; backgroundColorGreen = 1; backgroundColorRed = 1; backgroundType = 0; gridOffsetX = 0; gridOffsetY = 0; gridSpacing = 54; iconSize = 64; labelOnBottom = 1; showIconPreview = 1; showItemInfo = 0; textSize = 12; viewOptionsVersion = 1; }'
