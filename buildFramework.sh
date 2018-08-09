set -e
# Sets the target folders and the final framework product.
# 如果工程名称和Framework的Target名称不一样的话，要自定义FMKNAME
# 例如: FMK_NAME="MyFramework"
FMK_NAME="TYRZSDK"
# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.

INSTALL_DIR=${HOME}/Desktop/${FMK_NAME}.framework
DEVICE_DIR=${BUILD_DIR}/Release-iphoneos/${FMK_NAME}.framework
SIMULATOR_DIR=${BUILD_DIR}/Release-iphonesimulator/${FMK_NAME}.framework
# -configuration ${CONFIGURATION}
# Clean and Building both architectures.
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphoneos clean build ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" SYMROOT="${SYMROOT}" $ACTION
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphonesimulator clean build ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" SYMROOT="${SYMROOT}" $ACTION
# Cleaning the oldest.
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
mkdir -p "${INSTALL_DIR}"
cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
# Uses the Lipo Tool to merge both binary files (i386 + armv6/armv7) into one Universal final product.
lipo -create "${DEVICE_DIR}/${FMK_NAME}" "${SIMULATOR_DIR}/${FMK_NAME}" -output "${INSTALL_DIR}/${FMK_NAME}"

open "${INSTALL_DIR}"
