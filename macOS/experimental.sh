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
