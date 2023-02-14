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




# Pokemon Form Data(must be a master record for pokemon)
# [header]
# number, pokemon_id, form_id
# [output example]
# 0808,MELTAN,MELTAN
# 0809,MELMETAL,MELMETAL
# 0862,OBSTAGOON,OBSTAGOON_NORMAL
# 0862,OBSTAGOON,OBSTAGOON_SHADOW
# 0862,OBSTAGOON,OBSTAGOON_PURIFIED
# [note]
# need special handling for #201 UNOWN and #327 SPINDA
# drop "costume" form except Armered MewTwo 

FORM_FILE="${OUTPUTDIR}/form.tsv"
echo "Pokemon Form definition: ${FORM_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | select(.templateId | test("^FORMS_V[0-9]+_POKEMON_")) |
(.templateId | capture("^FORMS_V(?<number>[0-9]+)_POKEMON_").number) as $number |
(
    .data.formSettings.pokemon | 
    if $number == "0029" then ( . | sub("_FEMALE"; "_F"))
    elif $number == "0032" then ( . | sub("_MALE"; "_M"))
    else .
    end
)as $pokemon |
if .data.formSettings.forms[0].form == null or $pokemon == "UNOWN" or $pokemon == "SPINDA" then
    [$number, $pokemon, $pokemon]
else
    .data.formSettings.forms[] | 
    select(has("isCostume") == true and $pokemon != "MEWTWO" | not) |
    (
        .form | 
        if $number == "0029" then ( . | sub("NIDORAN"; "NIDORAN_F"))
        elif $number == "0032" then ( . | sub("NIDORAN"; "NIDORAN_M"))
        else .
        end
    ) as $form |
    [$number, $pokemon, $form]
end
|@tsv' | sed -E 's/"//g' > ${FORM_FILE}



# Pokemon data
# [header]
# pokemon_id(number),form,type_1,type_2(may be null),base_attack,base_defense,base_stamina,shadow_available
POKEMON_FILE="${OUTPUTDIR}/pokemon.tsv"
echo "Pokemon base stats: ${POKEMON_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^V[0-9]+_POKEMON_")) | 
select(.templateId | test("_REVERSION") | not) |
(.templateId | capture("^V(?<number>[0-9]+)").number) as $number |
(.templateId | capture("_POKEMON_(?<form>.+)$").form | 
    if $number == "0029" then ( . | sub("NIDORAN"; "NIDORAN_F"))
    elif $number == "0032" then ( . | sub("NIDORAN"; "NIDORAN_M"))
    else .
    end
) as $form |
.data | 
[
    $number,
#    .pokemonSettings.uniqueId,
    $form,
    (.pokemonSettings.type | capture("POKEMON_TYPE_(?<type>.+)").type), 
    (if .pokemonSettings.type2 !=null then (.pokemonSettings.type2 | capture("POKEMON_TYPE_(?<type>.+)").type) else "" end), 
    .pokemonSettings.stats.baseAttack,
    .pokemonSettings.stats.baseDefense,
    .pokemonSettings.stats.baseStamina,
    .pokemonSettings.shadow != null
]
|@tsv' | sed -E 's/"//g' > ${POKEMON_FILE}






# Pokemon->Quickmove data(current)
# [header]
# pokemon_id,move_id,legacy_flag
POKEMON_TO_FASTMOVE_FILE="${OUTPUTDIR}/pokemon_fastmove.tsv"
echo "Pokemon to Fastmove(current): ${POKEMON_TO_FASTMOVE_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^V[0-9]+_POKEMON_")) | 
select(.templateId | test("_REVERSION") | not) |
(.templateId | capture("^V(?<number>[0-9]+)").number) as $number |
(.templateId | capture("_POKEMON_(?<form>.+)$").form | 
    if $number == "0029" then ( . | sub("NIDORAN"; "NIDORAN_F"))
    elif $number == "0032" then ( . | sub("NIDORAN"; "NIDORAN_M"))
    else .
    end
) as $form |
.data.pokemonSettings.quickMoves[]? | 
[
    $number,
    $form,
    .,
    false
]
|@tsv' | sed -E 's/"//g' > ${POKEMON_TO_FASTMOVE_FILE}

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^V[0-9]+_POKEMON_")) | 
select(.templateId | test("_REVERSION") | not) |
(.templateId | capture("^V(?<number>[0-9]+)").number) as $number |
(.templateId | capture("_POKEMON_(?<form>.+)$").form | 
    if $number == "0029" then ( . | sub("NIDORAN"; "NIDORAN_F"))
    elif $number == "0032" then ( . | sub("NIDORAN"; "NIDORAN_M"))
    else .
    end
) as $form |
.data.pokemonSettings.eliteQuickMove[]? | 
[
    $number,
    $form,
    .,
    true
]
|@tsv' | sed -E 's/"//g' >> ${POKEMON_TO_FASTMOVE_FILE}


# Pokemon->Chargemove data(current)
# [header]
# pokemon_id,move_id,legacy_flag
POKEMON_TO_CHARGEMOVE_FILE="${OUTPUTDIR}/pokemon_chargemove.tsv"
echo "Pokemon to Chargemove(current): ${POKEMON_TO_CHARGEMOVE_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^V[0-9]+_POKEMON_")) | 
select(.templateId | test("_REVERSION") | not) |
(.templateId | capture("^V(?<number>[0-9]+)").number) as $number |
(.templateId | capture("_POKEMON_(?<form>.+)$").form | 
    if $number == "0029" then ( . | sub("NIDORAN"; "NIDORAN_F"))
    elif $number == "0032" then ( . | sub("NIDORAN"; "NIDORAN_M"))
    else .
    end
) as $form |
.data.pokemonSettings.cinematicMoves[]? | 
[
    $number,
    $form,
    .,
    false
]
|@tsv' | sed -E 's/"//g' > ${POKEMON_TO_CHARGEMOVE_FILE}

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^V[0-9]+_POKEMON_")) | 
select(.templateId | test("_REVERSION") | not) |
(.templateId | capture("^V(?<number>[0-9]+)").number) as $number |
(.templateId | capture("_POKEMON_(?<form>.+)$").form | 
    if $number == "0029" then ( . | sub("NIDORAN"; "NIDORAN_F"))
    elif $number == "0032" then ( . | sub("NIDORAN"; "NIDORAN_M"))
    else .
    end
) as $form |
.data.pokemonSettings.eliteCinematicMove[]? | 
[
    $number,
    $form,
    .,
    true
]
|@tsv' | sed -E 's/"//g' >> ${POKEMON_TO_CHARGEMOVE_FILE}




# shadow/purified moves
SHADOW_MOVE_FILE="${OUTPUTDIR}/shadow_purified_move.tsv"
echo "Shadow&Purified moves: ${SHADOW_MOVE_FILE}"
cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^V[0-9]+_POKEMON_")) | 
select(.templateId | test("_REVERSION") | not) |
(.templateId | capture("^V(?<number>[0-9]+)").number) as $number |
(.templateId | capture("_POKEMON_(?<form>.+)$").form | 
    if $number == "0029" then ( . | sub("NIDORAN"; "NIDORAN_F"))
    elif $number == "0032" then ( . | sub("NIDORAN"; "NIDORAN_M"))
    else .
    end
) as $form |
[
    $number,
    $form,
    .data.pokemonSettings.shadow.shadowChargeMove,
    .data.pokemonSettings.shadow.purifiedChargeMove
]
|@tsv' | sed -E 's/"//g' >> ${SHADOW_MOVE_FILE}




# Move data
# [header]
# move_id,codename,move_type,power,duration,energy,damage_window_start,damage_window_end
# [note]
# special treat for "STRUGGLE" (set energy as 33 = 3 bar move) -> still be required??
# exclude _BLASTOISE moves and WRAP_GREEN, WRAP_PINK
# .energyDelta // -33 は「わるあがき」対策のため（energyDeltaが空だが、実際には3ゲージ技）
MOVE_FILE="${OUTPUTDIR}/move.tsv"
echo "Move: ${MOVE_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^V[0-9]+_MOVE_")) |
select(.templateId | test("_BLASTOISE$") | not) |  
select(.templateId | test("_GREEN$") | not) |  
select(.templateId | test("_PINK$") | not) |  
(.templateId | capture("^V(?<number>[0-9]+)").number) as $number |
.data.moveSettings | 
[
    $number,
    .movementId,
    (.pokemonType | capture("POKEMON_TYPE_(?<type>.+)").type),
    .power // 0,
    .durationMs // 0,
    .energyDelta // -33,
    .damageWindowStartMs // 0,
    .damageWindowEndMs // 0
]
|@tsv' | sed -E 's/"//g' > ${MOVE_FILE}


# Combat move data
# [header]
# move_id,codename,move_type,power,energy_delta,durationTurns, buff(x5)
# [note]
# exclude _BLASTOISE moves and WRAP_GREEN, WRAP_PINK
MOVE_COMBAT_FILE="${OUTPUTDIR}/move_combat.tsv"
echo "Move(combat): ${MOVE_COMBAT_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^COMBAT_V[0-9]+_MOVE_")) |
select(.templateId | test("_BLASTOISE$") | not) |  
select(.templateId | test("_GREEN$") | not) |  
select(.templateId | test("_PINK$") | not) |  
(.templateId | capture("^COMBAT_V(?<number>[0-9]+)").number) as $number |
.data.combatMove | 
[
    $number,
    .uniqueId,
    (.type | capture("POKEMON_TYPE_(?<type>.+)").type),
    .power // 0,
    .durationTurns // 0,
    .energyDelta // 0,
    .buffs.buffActivationChance // 0,
    .buffs.targetAttackStatStageChange // 0,
    .buffs.targetDefenseStatStageChange // 0,
    .buffs.attackerAttackStatStageChange // 0,
    .buffs.attackerDefenseStatStageChange // 0
]
|@tsv' | sed -E 's/"//g' > ${MOVE_COMBAT_FILE}





# Type data
# [header]
# type_id,codename
#TYPE_FILE="${OUTPUTDIR}/type.tsv"
#echo "Type: ${TYPE_FILE}"
#
#cat ${LOCALFILE} |
#jq -c '.item_templates[] | select(.template_id | test("^POKEMON_TYPE_")) |
#[
#    .type_effective.attack_type,
#    (.template_id | capture("^POKEMON_TYPE_(?<name>.+)$").name)
#]' | sed -E 's/^\[//g' | sed -E 's/\]$//g' > ${TYPE_FILE}


# Type effectiveness data
# [header]
# type_id_offense, type_id_defense, multiplier
# [source] attackScalar order: NORMAL,FIGHTING,FLYING,POISON,GROUND,ROCK,BUG,GHOST,STEEL,FIRE,WATER,GRASS,ELECTRIC,PSYCHIC,ICE,DRAGON,DARK,FAIRY
#    "data": {
#      "templateId": "POKEMON_TYPE_BUG",
#      "typeEffective": {
#        "attackScalar": [1.0, 0.625, 0.625, 0.625, 1.0, 1.0, 1.0, 0.625, 0.625, 0.625, 1.0, 1.6, 1.0, 1.6, 1.0, 1.0, 1.6, 0.625],
#        "attackType": "POKEMON_TYPE_BUG"
#      }
#    }
EFFECTIVENESS_FILE="${OUTPUTDIR}/type_effectiveness.tsv"
echo "Type effectiveness: ${EFFECTIVENESS_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^POKEMON_TYPE_")) | 
(.data.typeEffective.attackType | capture("POKEMON_TYPE_(?<type>.+)").type) as $attackType |
.data.typeEffective.attackScalar | to_entries[] |
[
    $attackType,
    (.key as $index | ["NORMAL","FIGHTING","FLYING","POISON","GROUND","ROCK","BUG","GHOST","STEEL","FIRE","WATER","GRASS","ELECTRIC","PSYCHIC","ICE","DRAGON","DARK","FAIRY"] | .[$index]),
    .value
]
|@tsv' | sed -E 's/"//g' > ${EFFECTIVENESS_FILE}



# CP multiplier
# [header]
# lv,multiplier
CP_MULTIPLIER_FILE="${OUTPUTDIR}/cp_multiplier.tsv"
echo "CP_Multiplier: ${CP_MULTIPLIER_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^PLAYER_LEVEL_SETTINGS")) | 
.data.playerLevel.cpMultiplier | to_entries[] | 
[
    .key+1, 
    .value
]
|@tsv' | sed -E 's/"//g' > ${CP_MULTIPLIER_FILE}



#   Battle settings
#   [header]
#   key, value
BATTLE_SETTINGS_FILE="${OUTPUTDIR}/battle_settings.tsv"
echo "Battle settings: ${BATTLE_SETTINGS_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^BATTLE_SETTINGS$")) | 
.data.battleSettings | to_entries[] |
[.key, .value]
|@tsv' | sed -E 's/"//g' > ${BATTLE_SETTINGS_FILE}

#   Combat settings
#   [header]
#   key, value
COMBAT_SETTINGS_FILE="${OUTPUTDIR}/combat_settings.tsv"
echo "Combat settings: ${COMBAT_SETTINGS_FILE}"

cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^COMBAT_SETTINGS$")) | 
.data.combatSettings | to_entries[] |
if (.value | type) == "number" 
    then [.key, .value] 
    else [.key, 0]
end
|@tsv' | sed -E 's/"//g' > ${COMBAT_SETTINGS_FILE}


#   Stardust and candy
#   [header]
#   lv,stardust,candy,candy_xl
STARDUST_CANDY_FILE="${OUTPUTDIR}/stardust_candy.tsv"
echo "Stardust and candy: ${STARDUST_CANDY_FILE}"
cat ${LOCALFILE} |
jq -r -c '.[] | 
select(.templateId | test("^POKEMON_UPGRADE_SETTINGS")) | 
.data.pokemonUpgrades | 
.stardustCost as $stardust |
.candyCost as $candy |
([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] + .xlCandyCost) as $xlCandy |
0 | [while(.<49; .+0.5)] | .[] |
[
    .+1,
    $stardust[.|floor],
    $candy[.|floor],
    $xlCandy[.|floor]
]
|@tsv' | sed -E 's/"//g' > ${STARDUST_CANDY_FILE}




exit;
