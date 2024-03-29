/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes');

goog.require('jspb.BinaryReader');
goog.require('jspb.BinaryWriter');
goog.require('jspb.Message');

goog.forwardDeclare('proto.POGOProtos.Enums.PokemonMovementType');

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
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.displayName = 'proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes';
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
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.toObject = function(includeInstance, msg) {
  var f, obj = {
    baseCaptureRate: +jspb.Message.getFieldWithDefault(msg, 1, 0.0),
    baseFleeRate: +jspb.Message.getFieldWithDefault(msg, 2, 0.0),
    collisionRadiusM: +jspb.Message.getFieldWithDefault(msg, 3, 0.0),
    collisionHeightM: +jspb.Message.getFieldWithDefault(msg, 4, 0.0),
    collisionHeadRadiusM: +jspb.Message.getFieldWithDefault(msg, 5, 0.0),
    movementType: jspb.Message.getFieldWithDefault(msg, 6, 0),
    movementTimerS: +jspb.Message.getFieldWithDefault(msg, 7, 0.0),
    jumpTimeS: +jspb.Message.getFieldWithDefault(msg, 8, 0.0),
    attackTimerS: +jspb.Message.getFieldWithDefault(msg, 9, 0.0),
    bonusCandyCaptureReward: jspb.Message.getFieldWithDefault(msg, 10, 0),
    bonusStardustCaptureReward: jspb.Message.getFieldWithDefault(msg, 11, 0),
    attackProbability: +jspb.Message.getFieldWithDefault(msg, 12, 0.0),
    dodgeProbability: +jspb.Message.getFieldWithDefault(msg, 13, 0.0),
    dodgeDurationS: +jspb.Message.getFieldWithDefault(msg, 14, 0.0),
    dodgeDistance: +jspb.Message.getFieldWithDefault(msg, 15, 0.0),
    cameraDistance: +jspb.Message.getFieldWithDefault(msg, 16, 0.0),
    minPokemonActionFrequencyS: +jspb.Message.getFieldWithDefault(msg, 17, 0.0),
    maxPokemonActionFrequencyS: +jspb.Message.getFieldWithDefault(msg, 18, 0.0)
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
 * @return {!proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes;
  return proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setBaseCaptureRate(value);
      break;
    case 2:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setBaseFleeRate(value);
      break;
    case 3:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setCollisionRadiusM(value);
      break;
    case 4:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setCollisionHeightM(value);
      break;
    case 5:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setCollisionHeadRadiusM(value);
      break;
    case 6:
      var value = /** @type {!proto.POGOProtos.Enums.PokemonMovementType} */ (reader.readEnum());
      msg.setMovementType(value);
      break;
    case 7:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setMovementTimerS(value);
      break;
    case 8:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setJumpTimeS(value);
      break;
    case 9:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setAttackTimerS(value);
      break;
    case 10:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setBonusCandyCaptureReward(value);
      break;
    case 11:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setBonusStardustCaptureReward(value);
      break;
    case 12:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setAttackProbability(value);
      break;
    case 13:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setDodgeProbability(value);
      break;
    case 14:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setDodgeDurationS(value);
      break;
    case 15:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setDodgeDistance(value);
      break;
    case 16:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setCameraDistance(value);
      break;
    case 17:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setMinPokemonActionFrequencyS(value);
      break;
    case 18:
      var value = /** @type {number} */ (reader.readFloat());
      msg.setMaxPokemonActionFrequencyS(value);
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
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getBaseCaptureRate();
  if (f !== 0.0) {
    writer.writeFloat(
      1,
      f
    );
  }
  f = message.getBaseFleeRate();
  if (f !== 0.0) {
    writer.writeFloat(
      2,
      f
    );
  }
  f = message.getCollisionRadiusM();
  if (f !== 0.0) {
    writer.writeFloat(
      3,
      f
    );
  }
  f = message.getCollisionHeightM();
  if (f !== 0.0) {
    writer.writeFloat(
      4,
      f
    );
  }
  f = message.getCollisionHeadRadiusM();
  if (f !== 0.0) {
    writer.writeFloat(
      5,
      f
    );
  }
  f = message.getMovementType();
  if (f !== 0.0) {
    writer.writeEnum(
      6,
      f
    );
  }
  f = message.getMovementTimerS();
  if (f !== 0.0) {
    writer.writeFloat(
      7,
      f
    );
  }
  f = message.getJumpTimeS();
  if (f !== 0.0) {
    writer.writeFloat(
      8,
      f
    );
  }
  f = message.getAttackTimerS();
  if (f !== 0.0) {
    writer.writeFloat(
      9,
      f
    );
  }
  f = message.getBonusCandyCaptureReward();
  if (f !== 0) {
    writer.writeInt32(
      10,
      f
    );
  }
  f = message.getBonusStardustCaptureReward();
  if (f !== 0) {
    writer.writeInt32(
      11,
      f
    );
  }
  f = message.getAttackProbability();
  if (f !== 0.0) {
    writer.writeFloat(
      12,
      f
    );
  }
  f = message.getDodgeProbability();
  if (f !== 0.0) {
    writer.writeFloat(
      13,
      f
    );
  }
  f = message.getDodgeDurationS();
  if (f !== 0.0) {
    writer.writeFloat(
      14,
      f
    );
  }
  f = message.getDodgeDistance();
  if (f !== 0.0) {
    writer.writeFloat(
      15,
      f
    );
  }
  f = message.getCameraDistance();
  if (f !== 0.0) {
    writer.writeFloat(
      16,
      f
    );
  }
  f = message.getMinPokemonActionFrequencyS();
  if (f !== 0.0) {
    writer.writeFloat(
      17,
      f
    );
  }
  f = message.getMaxPokemonActionFrequencyS();
  if (f !== 0.0) {
    writer.writeFloat(
      18,
      f
    );
  }
};


/**
 * optional float base_capture_rate = 1;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getBaseCaptureRate = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 1, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setBaseCaptureRate = function(value) {
  jspb.Message.setProto3FloatField(this, 1, value);
};


/**
 * optional float base_flee_rate = 2;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getBaseFleeRate = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 2, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setBaseFleeRate = function(value) {
  jspb.Message.setProto3FloatField(this, 2, value);
};


/**
 * optional float collision_radius_m = 3;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getCollisionRadiusM = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 3, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setCollisionRadiusM = function(value) {
  jspb.Message.setProto3FloatField(this, 3, value);
};


/**
 * optional float collision_height_m = 4;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getCollisionHeightM = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 4, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setCollisionHeightM = function(value) {
  jspb.Message.setProto3FloatField(this, 4, value);
};


/**
 * optional float collision_head_radius_m = 5;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getCollisionHeadRadiusM = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 5, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setCollisionHeadRadiusM = function(value) {
  jspb.Message.setProto3FloatField(this, 5, value);
};


/**
 * optional POGOProtos.Enums.PokemonMovementType movement_type = 6;
 * @return {!proto.POGOProtos.Enums.PokemonMovementType}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getMovementType = function() {
  return /** @type {!proto.POGOProtos.Enums.PokemonMovementType} */ (jspb.Message.getFieldWithDefault(this, 6, 0));
};


/** @param {!proto.POGOProtos.Enums.PokemonMovementType} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setMovementType = function(value) {
  jspb.Message.setProto3EnumField(this, 6, value);
};


/**
 * optional float movement_timer_s = 7;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getMovementTimerS = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 7, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setMovementTimerS = function(value) {
  jspb.Message.setProto3FloatField(this, 7, value);
};


/**
 * optional float jump_time_s = 8;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getJumpTimeS = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 8, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setJumpTimeS = function(value) {
  jspb.Message.setProto3FloatField(this, 8, value);
};


/**
 * optional float attack_timer_s = 9;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getAttackTimerS = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 9, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setAttackTimerS = function(value) {
  jspb.Message.setProto3FloatField(this, 9, value);
};


/**
 * optional int32 bonus_candy_capture_reward = 10;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getBonusCandyCaptureReward = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 10, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setBonusCandyCaptureReward = function(value) {
  jspb.Message.setProto3IntField(this, 10, value);
};


/**
 * optional int32 bonus_stardust_capture_reward = 11;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getBonusStardustCaptureReward = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 11, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setBonusStardustCaptureReward = function(value) {
  jspb.Message.setProto3IntField(this, 11, value);
};


/**
 * optional float attack_probability = 12;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getAttackProbability = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 12, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setAttackProbability = function(value) {
  jspb.Message.setProto3FloatField(this, 12, value);
};


/**
 * optional float dodge_probability = 13;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getDodgeProbability = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 13, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setDodgeProbability = function(value) {
  jspb.Message.setProto3FloatField(this, 13, value);
};


/**
 * optional float dodge_duration_s = 14;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getDodgeDurationS = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 14, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setDodgeDurationS = function(value) {
  jspb.Message.setProto3FloatField(this, 14, value);
};


/**
 * optional float dodge_distance = 15;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getDodgeDistance = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 15, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setDodgeDistance = function(value) {
  jspb.Message.setProto3FloatField(this, 15, value);
};


/**
 * optional float camera_distance = 16;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getCameraDistance = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 16, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setCameraDistance = function(value) {
  jspb.Message.setProto3FloatField(this, 16, value);
};


/**
 * optional float min_pokemon_action_frequency_s = 17;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getMinPokemonActionFrequencyS = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 17, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setMinPokemonActionFrequencyS = function(value) {
  jspb.Message.setProto3FloatField(this, 17, value);
};


/**
 * optional float max_pokemon_action_frequency_s = 18;
 * @return {number}
 */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.getMaxPokemonActionFrequencyS = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 18, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.Master.Pokemon.EncounterAttributes.prototype.setMaxPokemonActionFrequencyS = function(value) {
  jspb.Message.setProto3FloatField(this, 18, value);
};


