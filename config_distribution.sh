#chmod 755 config_distribution.sh
#bash config_distribution.sh
# Android app package name
flutter pub run change_app_package_name:main com.bayam.app
# iOS app bundle
sed -i '' "s/com.optasoft.skeleton/com.bayam.app/g" ios/Runner.xcodeproj/project.pbxproj
# App Name
sed -i '' "s/APP NAME/Bayam/g" android/app/src/main/AndroidManifest.xml
sed -i '' "s/APP NAME/Bayam/g" lib/src/localization/app_en.arb
sed -i '' "s/APP NAME/Bayam/g" ios/Runner.xcodeproj/project.pbxproj
