#!/usr/bin/env bash
#
# Generate a new component by:
#   Copy all files in "code" to "new" directory
#   Change "./new/sample" to the provided component name
#   Change the "./new/sample" filenames to the provided component name
#

SCRIPT_DIR=$(cd `dirname $0` && pwd)
CODE_DIR=$SCRIPT_DIR/code
NEW_DIR=$SCRIPT_DIR/new

# Debugging
echo ""
echo "Script directory = " $SCRIPT_DIR
echo "Code directory = " $CODE_DIR
echo "New directory = " $NEW_DIR
echo ""


# Check argument
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters!"
    echo "  Expected utilization:"
    echo "    ./generate_template.sh <New_Component_Name>"
    echo ""
    exit 0
fi
COMPONENT_NAME=$1
COMPONENT_NAME_LOWER=$(echo "$COMPONENT_NAME" | sed -e 's/\(.*\)/\L\1/')
COMPONENT_NAME_FIRST=${COMPONENT_NAME_LOWER^}
COMPONENT_NAME_UPPER=${COMPONENT_NAME_LOWER^^}
echo "New component name = " $COMPONENT_NAME
echo "New component name lower = " $COMPONENT_NAME_LOWER
echo "New component name first = " $COMPONENT_NAME_FIRST
echo "New component name upper = " $COMPONENT_NAME_UPPER
echo ""

echo "Copy all files in ./code to ./new directory"
cp -R ./code ./new
echo ""

echo "Change ./new/sample to the provided component name"
find ./new -type f -exec sed -i "s/SAMPLE/$COMPONENT_NAME_UPPER/g" {} \;
find ./new -type f -exec sed -i "s/Sample/$COMPONENT_NAME_FIRST/g" {} \;
find ./new -type f -exec sed -i "s/sample/$COMPONENT_NAME_LOWER/g" {} \;
echo ""

echo "Change the ./new/sample filenames to the provided component name"
mv ./new/gsw/SAMPLE/cmd_tlm/SAMPLE_CMD.txt ./new/gsw/SAMPLE/cmd_tlm/${COMPONENT_NAME_UPPER}_CMD.txt
mv ./new/gsw/SAMPLE/cmd_tlm/SAMPLE_TLM.txt ./new/gsw/SAMPLE/cmd_tlm/${COMPONENT_NAME_UPPER}_TLM.txt
mv ./new/gsw/SAMPLE ./new/gsw/$COMPONENT_NAME_UPPER
find ./new -type f | sed "p;s/SAMPLE/$COMPONENT_NAME_UPPER/g" | xargs -d '\n' -n 2 mv 2> /dev/null
find ./new -type f | sed "p;s/Sample/$COMPONENT_NAME_FIRST/g" | xargs -d '\n' -n 2 mv 2> /dev/null
find ./new -type f | sed "p;s/sample/$COMPONENT_NAME_LOWER/g" | xargs -d '\n' -n 2 mv 2> /dev/null
echo ""

echo "generate_template.sh complete!"
echo ""
