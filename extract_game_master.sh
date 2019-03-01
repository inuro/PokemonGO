#!/bin/bash
# Extract GAME_MASTER.json(converted from Protobuf binary) into CSV file for SQL import
#
# [usage]
# $ extract_game_master.sh <GAME_MASTER_JSON> <OUTPUTDIR>
# $ 

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




# Pokemon Form Data(must be a master record for pokemon)
# [header]
# pokemon_id,form_id(may null)
# [note]
# special handling for #201 UNOWN and #327 SPINDA
FORM_FILE="${OUTPUTDIR}/form.csv"
echo "Pokemon Form definition: ${FORM_FILE}"

cat ${LOCALFILE} |
jq --arg version "$VERSION" -r -c '.item_templates[] | select(.template_id | test("^FORMS_V[0-9]+_POKEMON_")) |
.form_settings | 
.pokemon as $id |
if .pokemon == 201 or .pokemon == 327 then [$id,null]
elif .forms then .forms[] | [$id, .form]
else [$id,null]
end
'| sed -E 's/^\[//g' | sed -E 's/\]$//g' | sed -E 's/"//g' > ${FORM_FILE}


# Pokemon data
# [header]
# pokemon_id,codename,type_1,type_2(may null),base_attack,base_defense,base_stamina
POKEMON_FILE="${OUTPUTDIR}/pokemon.csv"
echo "Pokemon base stats: ${POKEMON_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^V[0-9]+_POKEMON_")) |
[
.pokemon_settings.pokemon_id,
.pokemon_settings.form,
(.template_id | capture("^V[0-9]+_POKEMON_(?<name>.+)$").name),
(.pokemon_settings |
   .type,
   .type_2,
   .stats.base_attack,
   .stats.base_defense,
   .stats.base_stamina
)
]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${POKEMON_FILE}



# Pokemon->Quickmove data(current)
# [header]
# pokemon_id,move_id,version(date)
POKEMON_TO_FASTMOVE_FILE="${OUTPUTDIR}/pokemon_fastmove.csv"
echo "Pokemon to Fastmove(current): ${POKEMON_TO_FASTMOVE_FILE}"

cat ${LOCALFILE} |
jq --arg version "$VERSION" -r -c '.item_templates[] | select(.template_id | test("^V[0-9]+_POKEMON_")) |
.pokemon_settings.pokemon_id as $id |
.pokemon_settings.form as $form | 
(.template_id | capture("^V[0-9]+_POKEMON_(?<name>.+)$").name) as $name |
if .pokemon_settings.quick_moves == null then [$id, $form, $name, null, "false"] else .pokemon_settings.quick_moves[] | [$id, $form, $name, ., "false"] end
'| sed -E 's/^\[//g' | sed -E 's/\]$//g' | sed -E 's/"//g' > ${POKEMON_TO_FASTMOVE_FILE}



# Pokemon->Chargemove data(current)
# [header]
# pokemon_id,move_id,version(date)
POKEMON_TO_CHARGEMOVE_FILE="${OUTPUTDIR}/pokemon_chargemove.csv"
echo "Pokemon to Chargemove(current): ${POKEMON_TO_CHARGEMOVE_FILE}"

cat ${LOCALFILE} |
jq --arg version "$VERSION" -r -c '.item_templates[] | select(.template_id | test("^V[0-9]+_POKEMON_")) |
.pokemon_settings.pokemon_id as $id |
.pokemon_settings.form as $form | 
(.template_id | capture("^V[0-9]+_POKEMON_(?<name>.+)$").name) as $name |
if .pokemon_settings.cinematic_moves == null then [$id, $form, $name, null, "false"] else .pokemon_settings.cinematic_moves[] | [$id, $form, $name, ., "false"] end
'| sed -E 's/^\[//g' | sed -E 's/\]$//g' | sed -E 's/"//g' > ${POKEMON_TO_CHARGEMOVE_FILE}



# Fastmove data
# [header]
# move_id,codename,move_type,power,duration,energy,damage_window_start,damage_window_end
# [note]
# ignore BLASTOISE specific records e.g. V0232_MOVE_WATER_GUN_FAST_BLASTOISE
FASTMOVE_FILE="${OUTPUTDIR}/fastmove.csv"
echo "Fastmove: ${FASTMOVE_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^V[0-9]+_MOVE_.+_FAST$")) |
#select(.move_settings.energy_delta > 0 or .move_settings.energy_delta == null) |
[
.move_settings.movement_id,
(.template_id | capture("^V[0-9]+_MOVE_(?<name>.+)_FAST$").name),
.move_settings.pokemon_type,
.move_settings.power,
.move_settings.duration_ms,
.move_settings.energy_delta,
.move_settings.damage_window_start_ms,
.move_settings.damage_window_end_ms
]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${FASTMOVE_FILE}




# Chargemove data
# [header]
# move_id,codename,move_type,power,duration,energy,damage_window_start,damage_window_end
# [note]
# special treat for "STRUGGLE" (set energy as 33 = 3 bar move)
CHARGEMOVE_FILE="${OUTPUTDIR}/chargemove.csv"
echo "Chargemove: ${CHARGEMOVE_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^V[0-9]+_MOVE_")) |
select(.template_id | test("_FAST$") | not) | 
select(.move_settings.energy_delta < 0 or .move_settings.energy_delta == null) |
[
.move_settings.movement_id,
(.template_id | capture("^V[0-9]+_MOVE_(?<name>.+)$").name),
.move_settings.pokemon_type,
.move_settings.power,
.move_settings.duration_ms,
(if .move_settings.energy_delta == null then 33 else .move_settings.energy_delta * -1 end),
.move_settings.damage_window_start_ms,
.move_settings.damage_window_end_ms
]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${CHARGEMOVE_FILE}



# Combat Fastmove data
# [header]
# move_id,codename,move_type,power,duration_turns,energy_delta
# [note]
# ignore BLASTOISE specific records e.g. V0232_MOVE_WATER_GUN_FAST_BLASTOISE
FASTMOVE_COMBAT_FILE="${OUTPUTDIR}/fastmove_combat.csv"
echo "Fastmove(combat): ${FASTMOVE_COMBAT_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^COMBAT_V[0-9]+_MOVE_.+_FAST$")) |
[
.combat_move.unique_id,
(.template_id | capture("^COMBAT_V[0-9]+_MOVE_(?<name>.+)_FAST$").name),
.combat_move.type,
.combat_move.power,
(if .combat_move.duration_turns == null then 0 else .combat_move.duration_turns end),
.combat_move.energy_delta
]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${FASTMOVE_COMBAT_FILE}


# Combat Chargemove data
# [header]
# move_id,codename,move_type,power,energy_delta
# [note]
CHARGEMOVE_COMBAT_FILE="${OUTPUTDIR}/chargemove_combat.csv"
echo "Chargemove(combat): ${CHARGEMOVE_COMBAT_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^COMBAT_V[0-9]+_MOVE_")) |
select(.template_id | test("_FAST$") | not) | 
select(.combat_move.energy_delta < 0) |
[
.combat_move.unique_id,
(.template_id | capture("^COMBAT_V[0-9]+_MOVE_(?<name>.+)$").name),
.combat_move.type,
.combat_move.power,
.combat_move.energy_delta * -1
]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${CHARGEMOVE_COMBAT_FILE}


# Type data
# [header]
# type_id,codename
TYPE_FILE="${OUTPUTDIR}/type.csv"
echo "Type: ${TYPE_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^POKEMON_TYPE_")) |
[
    .type_effective.attack_type,
    (.template_id | capture("^POKEMON_TYPE_(?<name>.+)$").name)
]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${TYPE_FILE}


# Type effectiveness data
# [header]
# type_id_offense, type_id_defense, multiplier
EFFECTIVENESS_FILE="${OUTPUTDIR}/type_effectiveness.csv"
echo "Type effectiveness: ${EFFECTIVENESS_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^POKEMON_TYPE_")) |
.type_effective.attack_type as $id |
.type_effective.attack_scalar | to_entries[] |
[$id, .key+1, .value]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${EFFECTIVENESS_FILE}


# CP multiplier
# [header]
# lv,multiplier
CP_MULTIPLIER_FILE="${OUTPUTDIR}/cp_multiplier.csv"
echo "CP_Multiplier: ${CP_MULTIPLIER_FILE}"

cat ${LOCALFILE} |
jq -c '.item_templates[] | select(.template_id | test("^PLAYER_LEVEL_SETTINGS")) |
.player_level.cp_multiplier | to_entries[] | [.key+1, .value]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${CP_MULTIPLIER_FILE}
