/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Data.Beluga.BelugaPokemon');
goog.provide('proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonCostume');
goog.provide('proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonForm');
goog.provide('proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonGender');
goog.provide('proto.POGOProtos.Data.Beluga.BelugaPokemon.Team');
goog.provide('proto.POGOProtos.Data.Beluga.BelugaPokemon.TrainerGender');

goog.require('jspb.BinaryReader');
goog.require('jspb.BinaryWriter');
goog.require('jspb.Message');


/**
 * Generated by JsPbCodeGenerator.
 * @param {Array=} opt_data Optional initial data array, typically from a
 * server response, or constructed directly in Javascript. The array is used
 * in place and becomes part of the constructed object. It is not cloned.
 * If no data is provided, the constructed object will be empty, but still
 * valid.
 * @extends {jspb.Message}
 * @constructor
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Data.Beluga.BelugaPokemon, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Data.Beluga.BelugaPokemon.displayName = 'proto.POGOProtos.Data.Beluga.BelugaPokemon';
}


if (jspb.Message.GENERATE_TO_OBJECT) {
/**
 * Creates an object representation of this proto suitable for use in Soy templates.
 * Field names that are reserved in JavaScript and will be renamed to pb_name.
 * To access a reserved field use, foo.pb_<name>, eg, foo.pb_default.
 * For the list of reserved names please see:
 *     com.google.apps.jspb.JsClassTemplate.JS_RESERVED_WORDS.
 * @param {boolean=} opt_includeInstance Whether to include the JSPB instance
 *     for transitional soy proto support: http://goto/soy-param-migration
 * @return {!Object}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Data.Beluga.BelugaPokemon.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.toObject = function(includeInstance, msg) {
  var f, obj = {
    trainerName: jspb.Message.getFieldWithDefault(msg, 1, ""),
    trainerGender: jspb.Message.getFieldWithDefault(msg, 2, 0),
    trainerTeam: jspb.Message.getFieldWithDefault(msg, 3, 0),
    trainerLevel: jspb.Message.getFieldWithDefault(msg, 4, 0),
    pokedexId: jspb.Message.getFieldWithDefault(msg, 5, 0),
    cp: jspb.Message.getFieldWithDefault(msg, 6, 0),
    pokemonLevel: +jspb.Message.getFieldWithDefault(msg, 7, 0.0),
    maxHp: jspb.Message.getFieldWithDefault(msg, 8, 0),
    originLat: +jspb.Message.getFieldWithDefault(msg, 9, 0.0),
    originLng: +jspb.Message.getFieldWithDefault(msg, 10, 0.0),
    height: +jspb.Message.getFieldWithDefault(msg, 11, 0.0),
    weight: +jspb.Message.getFieldWithDefault(msg, 12, 0.0),
    individualAttack: jspb.Message.getFieldWithDefault(msg, 13, 0),
    individualDefense: jspb.Message.getFieldWithDefault(msg, 14, 0),
    individualStamina: jspb.Message.getFieldWithDefault(msg, 15, 0),
    creationDay: jspb.Message.getFieldWithDefault(msg, 16, 0),
    creationMonth: jspb.Message.getFieldWithDefault(msg, 17, 0),
    creationYear: jspb.Message.getFieldWithDefault(msg, 18, 0),
    nickname: jspb.Message.getFieldWithDefault(msg, 19, ""),
    gender: jspb.Message.getFieldWithDefault(msg, 20, 0),
    costume: jspb.Message.getFieldWithDefault(msg, 21, 0),
    form: jspb.Message.getFieldWithDefault(msg, 22, 0),
    shiny: jspb.Message.getFieldWithDefault(msg, 23, false),
    move1: jspb.Message.getFieldWithDefault(msg, 24, 0),
    move2: jspb.Message.getFieldWithDefault(msg, 25, 0)
  };

  if (includeInstance) {
    obj.$jspbMessageInstance = msg;
  }
  return obj;
};
}


/**
 * Deserializes binary data (in protobuf wire format).
 * @param {jspb.ByteSource} bytes The bytes to deserialize.
 * @return {!proto.POGOProtos.Data.Beluga.BelugaPokemon}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Data.Beluga.BelugaPokemon;
  return proto.POGOProtos.Data.Beluga.BelugaPokemon.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Data.Beluga.BelugaPokemon}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {string} */ (reader.readString());
      msg.setTrainerName(value);
      break;
    case 2:
      var value = /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.TrainerGender} */ (reader.readEnum());
      msg.setTrainerGender(value);
      break;
    case 3:
      var value = /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.Team} */ (reader.readEnum());
      msg.setTrainerTeam(value);
      break;
    case 4:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setTrainerLevel(value);
      break;
    case 5:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setPokedexId(value);
      break;
    case 6:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setCp(value);
      break;
    case 7:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setPokemonLevel(value);
      break;
    case 8:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxHp(value);
      break;
    case 9:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setOriginLat(value);
      break;
    case 10:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setOriginLng(value);
      break;
    case 11:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setHeight(value);
      break;
    case 12:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setWeight(value);
      break;
    case 13:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setIndividualAttack(value);
      break;
    case 14:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setIndividualDefense(value);
      break;
    case 15:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setIndividualStamina(value);
      break;
    case 16:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setCreationDay(value);
      break;
    case 17:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setCreationMonth(value);
      break;
    case 18:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setCreationYear(value);
      break;
    case 19:
      var value = /** @type {string} */ (reader.readString());
      msg.setNickname(value);
      break;
    case 20:
      var value = /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonGender} */ (reader.readEnum());
      msg.setGender(value);
      break;
    case 21:
      var value = /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonCostume} */ (reader.readEnum());
      msg.setCostume(value);
      break;
    case 22:
      var value = /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonForm} */ (reader.readEnum());
      msg.setForm(value);
      break;
    case 23:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setShiny(value);
      break;
    case 24:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMove1(value);
      break;
    case 25:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMove2(value);
      break;
    default:
      reader.skipField();
      break;
    }
  }
  return msg;
};


/**
 * Serializes the message to binary data (in protobuf wire format).
 * @return {!Uint8Array}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Data.Beluga.BelugaPokemon.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getTrainerName();
  if (f.length > 0) {
    writer.writeString(
      1,
      f
    );
  }
  f = message.getTrainerGender();
  if (f !== 0.0) {
    writer.writeEnum(
      2,
      f
    );
  }
  f = message.getTrainerTeam();
  if (f !== 0.0) {
    writer.writeEnum(
      3,
      f
    );
  }
  f = message.getTrainerLevel();
  if (f !== 0) {
    writer.writeInt32(
      4,
      f
    );
  }
  f = message.getPokedexId();
  if (f !== 0) {
    writer.writeInt32(
      5,
      f
    );
  }
  f = message.getCp();
  if (f !== 0) {
    writer.writeInt32(
      6,
      f
    );
  }
  f = message.getPokemonLevel();
  if (f !== 0.0) {
    writer.writeFloat(
      7,
      f
    );
  }
  f = message.getMaxHp();
  if (f !== 0) {
    writer.writeInt32(
      8,
      f
    );
  }
  f = message.getOriginLat();
  if (f !== 0.0) {
    writer.writeDouble(
      9,
      f
    );
  }
  f = message.getOriginLng();
  if (f !== 0.0) {
    writer.writeDouble(
      10,
      f
    );
  }
  f = message.getHeight();
  if (f !== 0.0) {
    writer.writeFloat(
      11,
      f
    );
  }
  f = message.getWeight();
  if (f !== 0.0) {
    writer.writeFloat(
      12,
      f
    );
  }
  f = message.getIndividualAttack();
  if (f !== 0) {
    writer.writeInt32(
      13,
      f
    );
  }
  f = message.getIndividualDefense();
  if (f !== 0) {
    writer.writeInt32(
      14,
      f
    );
  }
  f = message.getIndividualStamina();
  if (f !== 0) {
    writer.writeInt32(
      15,
      f
    );
  }
  f = message.getCreationDay();
  if (f !== 0) {
    writer.writeInt32(
      16,
      f
    );
  }
  f = message.getCreationMonth();
  if (f !== 0) {
    writer.writeInt32(
      17,
      f
    );
  }
  f = message.getCreationYear();
  if (f !== 0) {
    writer.writeInt32(
      18,
      f
    );
  }
  f = message.getNickname();
  if (f.length > 0) {
    writer.writeString(
      19,
      f
    );
  }
  f = message.getGender();
  if (f !== 0.0) {
    writer.writeEnum(
      20,
      f
    );
  }
  f = message.getCostume();
  if (f !== 0.0) {
    writer.writeEnum(
      21,
      f
    );
  }
  f = message.getForm();
  if (f !== 0.0) {
    writer.writeEnum(
      22,
      f
    );
  }
  f = message.getShiny();
  if (f) {
    writer.writeBool(
      23,
      f
    );
  }
  f = message.getMove1();
  if (f !== 0) {
    writer.writeInt32(
      24,
      f
    );
  }
  f = message.getMove2();
  if (f !== 0) {
    writer.writeInt32(
      25,
      f
    );
  }
};


/**
 * @enum {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonCostume = {
  UNSET: 0,
  HOLIDAY_2016: 1,
  ANNIVERSARY: 2,
  ONE_YEAR_ANNIVERSARY: 3,
  HALLOWEEN_2017: 4
};

/**
 * @enum {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonForm = {
  FORM_UNSET: 0,
  ALOLA: 1
};

/**
 * @enum {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonGender = {
  GENDER_UNSET: 0,
  MALE: 1,
  FEMALE: 2,
  GENDERLESS: 3
};

/**
 * @enum {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.Team = {
  NONE: 0,
  TEAM_BLUE: 1,
  TEAM_RED: 2,
  TEAM_YELLOW: 3
};

/**
 * @enum {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.TrainerGender = {
  TRAINER_MALE: 0,
  TRAINER_FEMALE: 1
};

/**
 * optional string trainer_name = 1;
 * @return {string}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getTrainerName = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 1, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setTrainerName = function(value) {
  jspb.Message.setProto3StringField(this, 1, value);
};


/**
 * optional TrainerGender trainer_gender = 2;
 * @return {!proto.POGOProtos.Data.Beluga.BelugaPokemon.TrainerGender}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getTrainerGender = function() {
  return /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.TrainerGender} */ (jspb.Message.getFieldWithDefault(this, 2, 0));
};


/** @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon.TrainerGender} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setTrainerGender = function(value) {
  jspb.Message.setProto3EnumField(this, 2, value);
};


/**
 * optional Team trainer_team = 3;
 * @return {!proto.POGOProtos.Data.Beluga.BelugaPokemon.Team}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getTrainerTeam = function() {
  return /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.Team} */ (jspb.Message.getFieldWithDefault(this, 3, 0));
};


/** @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon.Team} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setTrainerTeam = function(value) {
  jspb.Message.setProto3EnumField(this, 3, value);
};


/**
 * optional int32 trainer_level = 4;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getTrainerLevel = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 4, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setTrainerLevel = function(value) {
  jspb.Message.setProto3IntField(this, 4, value);
};


/**
 * optional int32 pokedex_id = 5;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getPokedexId = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 5, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setPokedexId = function(value) {
  jspb.Message.setProto3IntField(this, 5, value);
};


/**
 * optional int32 cp = 6;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getCp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 6, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setCp = function(value) {
  jspb.Message.setProto3IntField(this, 6, value);
};


/**
 * optional float pokemon_level = 7;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getPokemonLevel = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 7, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setPokemonLevel = function(value) {
  jspb.Message.setProto3FloatField(this, 7, value);
};


/**
 * optional int32 max_hp = 8;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getMaxHp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 8, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setMaxHp = function(value) {
  jspb.Message.setProto3IntField(this, 8, value);
};


/**
 * optional double origin_lat = 9;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getOriginLat = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 9, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setOriginLat = function(value) {
  jspb.Message.setProto3FloatField(this, 9, value);
};


/**
 * optional double origin_lng = 10;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getOriginLng = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 10, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setOriginLng = function(value) {
  jspb.Message.setProto3FloatField(this, 10, value);
};


/**
 * optional float height = 11;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getHeight = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 11, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setHeight = function(value) {
  jspb.Message.setProto3FloatField(this, 11, value);
};


/**
 * optional float weight = 12;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getWeight = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 12, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setWeight = function(value) {
  jspb.Message.setProto3FloatField(this, 12, value);
};


/**
 * optional int32 individual_attack = 13;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getIndividualAttack = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 13, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setIndividualAttack = function(value) {
  jspb.Message.setProto3IntField(this, 13, value);
};


/**
 * optional int32 individual_defense = 14;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getIndividualDefense = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 14, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setIndividualDefense = function(value) {
  jspb.Message.setProto3IntField(this, 14, value);
};


/**
 * optional int32 individual_stamina = 15;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getIndividualStamina = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 15, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setIndividualStamina = function(value) {
  jspb.Message.setProto3IntField(this, 15, value);
};


/**
 * optional int32 creation_day = 16;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getCreationDay = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 16, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setCreationDay = function(value) {
  jspb.Message.setProto3IntField(this, 16, value);
};


/**
 * optional int32 creation_month = 17;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getCreationMonth = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 17, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setCreationMonth = function(value) {
  jspb.Message.setProto3IntField(this, 17, value);
};


/**
 * optional int32 creation_year = 18;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getCreationYear = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 18, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setCreationYear = function(value) {
  jspb.Message.setProto3IntField(this, 18, value);
};


/**
 * optional string nickname = 19;
 * @return {string}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getNickname = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 19, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setNickname = function(value) {
  jspb.Message.setProto3StringField(this, 19, value);
};


/**
 * optional PokemonGender gender = 20;
 * @return {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonGender}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getGender = function() {
  return /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonGender} */ (jspb.Message.getFieldWithDefault(this, 20, 0));
};


/** @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonGender} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setGender = function(value) {
  jspb.Message.setProto3EnumField(this, 20, value);
};


/**
 * optional PokemonCostume costume = 21;
 * @return {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonCostume}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getCostume = function() {
  return /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonCostume} */ (jspb.Message.getFieldWithDefault(this, 21, 0));
};


/** @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonCostume} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setCostume = function(value) {
  jspb.Message.setProto3EnumField(this, 21, value);
};


/**
 * optional PokemonForm form = 22;
 * @return {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonForm}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getForm = function() {
  return /** @type {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonForm} */ (jspb.Message.getFieldWithDefault(this, 22, 0));
};


/** @param {!proto.POGOProtos.Data.Beluga.BelugaPokemon.PokemonForm} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setForm = function(value) {
  jspb.Message.setProto3EnumField(this, 22, value);
};


/**
 * optional bool shiny = 23;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getShiny = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 23, false));
};


/** @param {boolean} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setShiny = function(value) {
  jspb.Message.setProto3BooleanField(this, 23, value);
};


/**
 * optional int32 move1 = 24;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getMove1 = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 24, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setMove1 = function(value) {
  jspb.Message.setProto3IntField(this, 24, value);
};


/**
 * optional int32 move2 = 25;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.getMove2 = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 25, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaPokemon.prototype.setMove2 = function(value) {
  jspb.Message.setProto3IntField(this, 25, value);
};

