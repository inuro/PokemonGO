#!/bin/bash
# Extract GAME_MASTER.json(converted from Protobuf binary) into.tsv file for SQL import
#
# [usage]
# $ extract_game_master_v3.sh <GAME_MASTER_JSON> <OUTPUTDIR>
# $ ./extract_game_master_v3.sh game_master_latest.json masterfiles
# [notes]
#   

LOCALFILE=$1
VERSION=$2
#OUTPUTDIR=$2

[ $# -ne 2 ] && echo "[usage] $ extract_game_master.sh <game_master.json> <outputdir>" && exit 1

OUTPUTDIR="./${VERSION}"
if [ -e $OUTPUTDIR ]; then
  rm -r $OUTPUTDIR
fi
mkdir $OUTPUTDIR

echo "Source file: ${LOCALFILE}"
echo "Output dir: ${OUTPUTDIR}"

#   Combat settings
#   [header]
#   key, value
COMBAT_SETTINGS_FILE="${OUTPUTDIR}/combat_settings.tsv"
echo "Combat settings: ${COMBAT_SETTINGS_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^COMBAT_SETTINGS$")) | 
.data.combatSettings | to_entries[] |
if .value | type != "array" then [.key, .value] end
|@tsv' | sed -E 's/"//g' > ${COMBAT_SETTINGS_FILE}




exit;
