/**
  decode_game_master.js
  Decode PokemonGO GAME_MASTER Protocol Buffers binary file into JSON file

  [usage]
  $ node decode_game_master.js ${original_game_master_file} > ${output_file}
  $ node decode_game_master.js GAME_MASTER/0000015A62513FDA_GAME_MASTER > game_master_latest.json

  [requiremnt]
  - fs
  - protobufjs  https://github.com/dcodeIO/ProtoBuf.js
  - PokemonGO Protobuf message schemas(.proto) https://github.com/Furtif/POGOProtos
*/

'use strict'

const original_game_master_file = process.argv[2];
console.error(`Parse GAME_MASTER file:${original_game_master_file}`);

/*
const fs = require('fs');
const path = require('path');
const protobuf = require("protobufjs");

protobuf.load({file:"POGOProtos/Networking/Responses/DownloadItemTemplatesResponse.proto", root:path.resolve(".")}, function(err, root) {
  if (err){
    console.log("error");
    console.log(err.message);
    //throw err;
  }else{

    var Message = root.lookupType("POGOProtos.Networking.Responses.DownloadItemTemplatesResponse");
    const data = fs.readFileSync(original_game_master_file);
    const buffer = Buffer.from(data);
    const reader = new protobuf.Reader(buffer);
    const msg = Message.decode(reader);
    const obj = Message.toObject(msg);
    console.log(JSON.stringify(obj, null, 4));
  }
});
*/



const fs = require("fs");
const protobuf = require("protobufjs");

const root = new protobuf.Root().loadSync([
	'POGOProtos/Networking/Responses/DownloadItemTemplatesResponse.proto'
,	'POGOProtos/Data/Avatar/AvatarCustomization.proto'
,	'POGOProtos/Data/Badge/BadgeCaptureReward.proto'
,	'POGOProtos/Data/Combat/CombatMoveBuffs.proto'
,	'POGOProtos/Data/Combat/PokemonCondition.proto'
,	'POGOProtos/Data/Combat/UnlockCondition.proto'
,	'POGOProtos/Data/Combat/WithPlayerLevel.proto'
,	'POGOProtos/Data/Combat/WithPokemonCategory.proto'
,	'POGOProtos/Data/Combat/WithPokemonCpLimit.proto'
,	'POGOProtos/Data/Combat/WithPokemonType.proto'
,	'POGOProtos/Data/NpcPokemon.proto'
,	'POGOProtos/Data/Player/PlayerAvatar.proto'
,	'POGOProtos/Data/Player/PlayerAvatarType.proto'
,	'POGOProtos/Data/PokemonDisplay.proto'
,	'POGOProtos/Enums/BadgeType.proto'
,	'POGOProtos/Enums/BuddySize.proto'
,	'POGOProtos/Enums/CameraInterpolation.proto'
,	'POGOProtos/Enums/CameraTarget.proto'
,	'POGOProtos/Enums/ConditionType.proto'
,	'POGOProtos/Enums/Costume.proto'
,	'POGOProtos/Enums/Form.proto'
,	'POGOProtos/Enums/FriendshipLevelMilestone.proto'
,	'POGOProtos/Enums/Gender.proto'
,	'POGOProtos/Enums/IapItemCategory.proto'
,	'POGOProtos/Enums/ItemCategory.proto'
,	'POGOProtos/Enums/ItemEffect.proto'
,	'POGOProtos/Enums/PokemonFamilyId.proto'
,	'POGOProtos/Enums/PokemonId.proto'
,	'POGOProtos/Enums/PokemonMove.proto'
,	'POGOProtos/Enums/PokemonMovementType.proto'
,	'POGOProtos/Enums/PokemonRarity.proto'
,	'POGOProtos/Enums/PokemonTradingType.proto'
,	'POGOProtos/Enums/PokemonType.proto'
,	'POGOProtos/Enums/QuestType.proto'
,	'POGOProtos/Enums/WeatherCondition.proto'
,	'POGOProtos/Inventory/EggIncubatorType.proto'
,	'POGOProtos/Inventory/InventoryUpgradeType.proto'
,	'POGOProtos/Inventory/Item/ItemId.proto'
,	'POGOProtos/Inventory/Item/ItemType.proto'
,	'POGOProtos/Settings/Master/AvatarCustomizationSettings.proto'
,	'POGOProtos/Settings/Master/BackgroundModeSettings.proto'
,	'POGOProtos/Settings/Master/BadgeSettings.proto'
,	'POGOProtos/Settings/Master/BelugaPokemonWhitelist.proto'
,	'POGOProtos/Settings/Master/CameraSettings.proto'
,	'POGOProtos/Settings/Master/CombatLeague.proto'
,	'POGOProtos/Settings/Master/CombatLeagueSettings.proto'
,	'POGOProtos/Settings/Master/CombatMoveSettings.proto'
,	'POGOProtos/Settings/Master/CombatNpcPersonality.proto'
,	'POGOProtos/Settings/Master/CombatNpcTrainer.proto'
,	'POGOProtos/Settings/Master/CombatSettings.proto'
,	'POGOProtos/Settings/Master/CombatStatStageSettings.proto'
,	'POGOProtos/Settings/Master/EncounterSettings.proto'
,	'POGOProtos/Settings/Master/EquippedBadgeSettings.proto'
,	'POGOProtos/Settings/Master/EventBadgeSettings.proto'
,	'POGOProtos/Settings/Master/ExRaidSettings.proto'
,	'POGOProtos/Settings/Master/FormSettings.proto'
,	'POGOProtos/Settings/Master/FriendshipLevelMilestoneSettings.proto'
,	'POGOProtos/Settings/Master/GenderSettings.proto'
,	'POGOProtos/Settings/Master/GymBadgeGmtSettings.proto'
,	'POGOProtos/Settings/Master/GymBattleSettings.proto'
,	'POGOProtos/Settings/Master/GymLevelSettings.proto'
,	'POGOProtos/Settings/Master/IapItemCategoryDisplay.proto'
,	'POGOProtos/Settings/Master/IapItemDisplay.proto'
,	'POGOProtos/Settings/Master/IapSettings.proto'
,	'POGOProtos/Settings/Master/Item/BattleAttributes.proto'
,	'POGOProtos/Settings/Master/Item/EggIncubatorAttributes.proto'
,	'POGOProtos/Settings/Master/Item/ExperienceBoostAttributes.proto'
,	'POGOProtos/Settings/Master/Item/FoodAttributes.proto'
,	'POGOProtos/Settings/Master/Item/FortModifierAttributes.proto'
,	'POGOProtos/Settings/Master/Item/IncenseAttributes.proto'
,	'POGOProtos/Settings/Master/Item/InventoryUpgradeAttributes.proto'
,	'POGOProtos/Settings/Master/Item/PokeballAttributes.proto'
,	'POGOProtos/Settings/Master/Item/PotionAttributes.proto'
,	'POGOProtos/Settings/Master/Item/ReviveAttributes.proto'
,	'POGOProtos/Settings/Master/Item/StardustBoostAttributes.proto'
,	'POGOProtos/Settings/Master/ItemSettings.proto'
,	'POGOProtos/Settings/Master/LuckyPokemonSettings.proto'
,	'POGOProtos/Settings/Master/MoveSequenceSettings.proto'
,	'POGOProtos/Settings/Master/MoveSettings.proto'
,	'POGOProtos/Settings/Master/OnboardingSettings.proto'
, 'POGOProtos/Settings/Master/PartyRecommendationSettings.proto'
,	'POGOProtos/Settings/Master/PlayerLevelSettings.proto'
,	'POGOProtos/Settings/Master/Pokemon/CameraAttributes.proto'
,	'POGOProtos/Settings/Master/Pokemon/EncounterAttributes.proto'
,	'POGOProtos/Settings/Master/Pokemon/EvolutionBranch.proto'
,	'POGOProtos/Settings/Master/Pokemon/PokemonGenderSettings.proto'
,	'POGOProtos/Settings/Master/Pokemon/StatsAttributes.proto'
,	'POGOProtos/Settings/Master/PokemonScaleSetting.proto'
,	'POGOProtos/Settings/Master/PokemonSettings.proto'
,	'POGOProtos/Settings/Master/PokemonUpgradeSettings.proto'
,	'POGOProtos/Settings/Master/Quest/DailyQuestSettings.proto'
,	'POGOProtos/Settings/Master/QuestSettings.proto'
,	'POGOProtos/Settings/Master/TypeEffectiveSettings.proto'
,	'POGOProtos/Settings/Master/WeatherAffinity.proto'
,	'POGOProtos/Settings/Master/WeatherBonus.proto'
,	'POGOProtos/Settings/Master/OnboardingV2Settings.proto'
],{keepCase: true});
var Message = root.lookupType("POGOProtos.Networking.Responses.DownloadItemTemplatesResponse");
//console.log(Message);
//var temp = root.lookupType(".POGOProtos.Settings.Master.PokemonSettings");
//console.log(temp);

const data = fs.readFileSync(original_game_master_file);
const buffer = Buffer.from(data);
const reader = new protobuf.Reader(buffer);
const msg = Message.decode(reader);
const obj = Message.toObject(msg);
console.log(JSON.stringify(obj, null, 4));


