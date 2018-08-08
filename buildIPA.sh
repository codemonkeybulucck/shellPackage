
# 工程名
APP_NAME="TestUMCOpen"
# 证书
CODE_SIGN_DISTRIBUTION="iPhone Distribution: XXXXXXXXXX"
# info.plist路径
project_infoplist_path="./${APP_NAME}/Info.plist"

#取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")

#取build值
bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")
DATE="$(date +%Y%m%d)"
IPAFOLDER="${APP_NAME}_V${bundleShortVersion}_${DATE}"

#要上传的ipa文件路径
ARCHIVE_PATH="${HOME}/Desktop/archive"
IPA_PATH="$ARCHIVE_PATH/$IPAFOLDER/${APP_NAME}.ipa"
PLIST_PATH="$ARCHIVE_PATH/ADHocExportOptions.plist"
echo ${IPA_PATH}
echo ${PLIST_PATH}

#下面两行是没有Cocopods的用法

xcodebuild clean -project "${APP_NAME}.xcodeproj" -scheme ${APP_NAME}   -configuration 'Release'

xcodebuild archive -project "${APP_NAME}.xcodeproj" -scheme ${APP_NAME} -archivePath "${ARCHIVE_PATH}/${APP_NAME}.xcarchive"

#下面两行是有cocopods的用法
# xcodebuild clean -workspace "${APP_NAME}.xcworkspace" -scheme ${APP_NAME}   -configuration 'Release'

# xcodebuild archive -workspace "${APP_NAME}.xcworkspace" -scheme ${APP_NAME} -archivePath "${ARCHIVE_PATH}/${APP_NAME}.xcarchive"

 
xcodebuild -exportArchive -archivePath "${ARCHIVE_PATH}/${APP_NAME}.xcarchive" -exportPath "${ARCHIVE_PATH}/$IPAFOLDER" -exportOptionsPlist "$PLIST_PATH"

open ${ARCHIVE_PATH}

#上传到蒲公英
uKey="aec42b3cc3229e3afa737cc7084a819c"
#蒲公英上的API Key
apiKey="ba4e62c30dc929fce40a0b8067a87315"
#要上传的ipa文件路径
echo $IPA_PATH
 
#执行上传至蒲公英的命令
echo "++++++++++++++upload+++++++++++++"
curl -F "file=@${IPA_PATH}" -F "uKey=${uKey}" -F "_api_key=${apiKey}" http://www.pgyer.com/apiv1/app/upload