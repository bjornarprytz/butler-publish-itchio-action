#!/bin/sh
set -e

# Install Butler with specified version (default to LATEST)
BUTLER_VERSION=${BUTLER_VERSION:-LATEST}
echo "Installing butler version: $BUTLER_VERSION"
curl -L -o /tmp/butler.zip https://broth.itch.zone/butler/linux-amd64/${BUTLER_VERSION}/archive/default
unzip -q /tmp/butler.zip -d /tmp
cp /tmp/butler /usr/bin/butler
chmod +x /usr/bin/butler
rm -f /tmp/butler.zip /tmp/butler

export BUTLER_API_KEY=$BUTLER_CREDENTIALS

versionArgument=""

if [ "$VERSION" != "" ]
then
    versionArgument="--userversion ${VERSION}"
elif [ "$VERSION_FILE" != "" ]
then
    versionArgument="--userversion-file ${VERSION_FILE}"
fi

echo "butler push \"$PACKAGE\" $ITCH_USER/$ITCH_GAME:$CHANNEL ${versionArgument}"
butler push "$PACKAGE" $ITCH_USER/$ITCH_GAME:$CHANNEL ${versionArgument}
