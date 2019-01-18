/**
  decode_game_master.js
  Decode PokemonGO GAME_MASTER Protocol Buffers binary file into JSON file

  [usage]
  $ node decode_game_master.js ${original_game_master_file} > ${output_file}
  $ node decode_game_master.js .game_master/0000015A62513FDA_GAME_MASTER > ./out/game_master.json

  [requiremnt]
  - fs
  - protobufjs  https://github.com/dcodeIO/ProtoBuf.js
  - PokemonGO Protobuf message schemas(.proto) https://github.com/Furtif/POGOProtos
*/

'use strict'

const original_game_master_file = process.argv[2];
console.error(`Parse GAME_MASTER file:${original_game_master_file}`);

const fs = require("fs");
const protobuf = require("protobufjs");

const root = new protobuf.Root().loadSync([
	'POGOProtos/src/POGOProtos/Networking/Responses/DownloadItemTemplatesResponse.proto'
,	'POGOProtos/src/POGOProtos/Data/Avatar/AvatarCustomization.proto'
,	'POGOProtos/src/POGOProtos/Data/Badge/BadgeCaptureReward.proto'
,	'POGOProtos/src/POGOProtos/Data/Combat/CombatMoveBuffs.proto'
,	'POGOProtos/src/POGOProtos/Data/Combat/PokemonCondition.proto'
,	'POGOProtos/src/POGOProtos/Data/Combat/UnlockCondition.proto'
,	'POGOProtos/src/POGOProtos/Data/Combat/WithPlayerLevel.proto'
,	'POGOProtos/src/POGOProtos/Data/Combat/WithPokemonCategory.proto'
,	'POGOProtos/src/POGOProtos/Data/Combat/WithPokemonCpLimit.proto'
,	'POGOProtos/src/POGOProtos/Data/Combat/WithPokemonType.proto'
,	'POGOProtos/src/POGOProtos/Data/NpcPokemon.proto'
,	'POGOProtos/src/POGOProtos/Data/Player/PlayerAvatar.proto'
,	'POGOProtos/src/POGOProtos/Data/Player/PlayerAvatarType.proto'
,	'POGOProtos/src/POGOProtos/Data/PokemonDisplay.proto'
,	'POGOProtos/src/POGOProtos/Enums/BadgeType.proto'
,	'POGOProtos/src/POGOProtos/Enums/BuddySize.proto'
,	'POGOProtos/src/POGOProtos/Enums/CameraInterpolation.proto'
,	'POGOProtos/src/POGOProtos/Enums/CameraTarget.proto'
,	'POGOProtos/src/POGOProtos/Enums/ConditionType.proto'
,	'POGOProtos/src/POGOProtos/Enums/Costume.proto'
,	'POGOProtos/src/POGOProtos/Enums/Form.proto'
,	'POGOProtos/src/POGOProtos/Enums/FriendshipLevelMilestone.proto'
,	'POGOProtos/src/POGOProtos/Enums/Gender.proto'
,	'POGOProtos/src/POGOProtos/Enums/IapItemCategory.proto'
,	'POGOProtos/src/POGOProtos/Enums/ItemCategory.proto'
,	'POGOProtos/src/POGOProtos/Enums/ItemEffect.proto'
,	'POGOProtos/src/POGOProtos/Enums/PokemonFamilyId.proto'
,	'POGOProtos/src/POGOProtos/Enums/PokemonId.proto'
,	'POGOProtos/src/POGOProtos/Enums/PokemonMove.proto'
,	'POGOProtos/src/POGOProtos/Enums/PokemonMovementType.proto'
,	'POGOProtos/src/POGOProtos/Enums/PokemonRarity.proto'
,	'POGOProtos/src/POGOProtos/Enums/PokemonTradingType.proto'
,	'POGOProtos/src/POGOProtos/Enums/PokemonType.proto'
,	'POGOProtos/src/POGOProtos/Enums/QuestType.proto'
,	'POGOProtos/src/POGOProtos/Enums/WeatherCondition.proto'
,	'POGOProtos/src/POGOProtos/Inventory/EggIncubatorType.proto'
,	'POGOProtos/src/POGOProtos/Inventory/InventoryUpgradeType.proto'
,	'POGOProtos/src/POGOProtos/Inventory/Item/ItemId.proto'
,	'POGOProtos/src/POGOProtos/Inventory/Item/ItemType.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/AvatarCustomizationSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/BackgroundModeSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/BadgeSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/BelugaPokemonWhitelist.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CameraSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CombatLeague.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CombatLeagueSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CombatMoveSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CombatNpcPersonality.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CombatNpcTrainer.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CombatSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/CombatStatStageSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/EncounterSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/EquippedBadgeSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/EventBadgeSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/ExRaidSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/FormSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/FriendshipLevelMilestoneSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/GenderSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/GymBadgeGmtSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/GymBattleSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/GymLevelSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/IapItemCategoryDisplay.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/IapItemDisplay.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/IapSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/BattleAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/EggIncubatorAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/ExperienceBoostAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/FoodAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/FortModifierAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/IncenseAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/InventoryUpgradeAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/PokeballAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/PotionAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/ReviveAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Item/StardustBoostAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/ItemSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/LuckyPokemonSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/MoveSequenceSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/MoveSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/OnboardingSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/PlayerLevelSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Pokemon/CameraAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Pokemon/EncounterAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Pokemon/EvolutionBranch.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Pokemon/PokemonGenderSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Pokemon/StatsAttributes.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/PokemonScaleSetting.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/PokemonSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/PokemonUpgradeSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/Quest/DailyQuestSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/QuestSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/TypeEffectiveSettings.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/WeatherAffinity.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/WeatherBonus.proto'
,	'POGOProtos/src/POGOProtos/Settings/Master/OnboardingV2Settings.proto'
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


