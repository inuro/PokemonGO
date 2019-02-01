/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Settings.FortSettings');

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
proto.POGOProtos.Settings.FortSettings = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Settings.FortSettings, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Settings.FortSettings.displayName = 'proto.POGOProtos.Settings.FortSettings';
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
proto.POGOProtos.Settings.FortSettings.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Settings.FortSettings.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Settings.FortSettings} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.FortSettings.toObject = function(includeInstance, msg) {
  var f, obj = {
    interactionRangeMeters: +jspb.Message.getFieldWithDefault(msg, 1, 0.0),
    maxTotalDeployedPokemon: jspb.Message.getFieldWithDefault(msg, 2, 0),
    maxPlayerDeployedPokemon: jspb.Message.getFieldWithDefault(msg, 3, 0),
    deployStaminaMultiplier: +jspb.Message.getFieldWithDefault(msg, 4, 0.0),
    deployAttackMultiplier: +jspb.Message.getFieldWithDefault(msg, 5, 0.0),
    farInteractionRangeMeters: +jspb.Message.getFieldWithDefault(msg, 6, 0.0),
    disableGyms: jspb.Message.getFieldWithDefault(msg, 7, false),
    maxSamePokemonAtFort: jspb.Message.getFieldWithDefault(msg, 8, 0),
    maxPlayerTotalDeployedPokemon: jspb.Message.getFieldWithDefault(msg, 9, 0),
    enableHyperlinksInPoiDescriptions: jspb.Message.getFieldWithDefault(msg, 10, false),
    enableRightToLeftTextDisplay: jspb.Message.getFieldWithDefault(msg, 11, false)
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
 * @return {!proto.POGOProtos.Settings.FortSettings}
 */
proto.POGOProtos.Settings.FortSettings.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Settings.FortSettings;
  return proto.POGOProtos.Settings.FortSettings.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Settings.FortSettings} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Settings.FortSettings}
 */
proto.POGOProtos.Settings.FortSettings.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setInteractionRangeMeters(value);
      break;
    case 2:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxTotalDeployedPokemon(value);
      break;
    case 3:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxPlayerDeployedPokemon(value);
      break;
    case 4:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setDeployStaminaMultiplier(value);
      break;
    case 5:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setDeployAttackMultiplier(value);
      break;
    case 6:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setFarInteractionRangeMeters(value);
      break;
    case 7:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setDisableGyms(value);
      break;
    case 8:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxSamePokemonAtFort(value);
      break;
    case 9:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxPlayerTotalDeployedPokemon(value);
      break;
    case 10:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setEnableHyperlinksInPoiDescriptions(value);
      break;
    case 11:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setEnableRightToLeftTextDisplay(value);
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
proto.POGOProtos.Settings.FortSettings.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Settings.FortSettings.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Settings.FortSettings} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.FortSettings.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getInteractionRangeMeters();
  if (f !== 0.0) {
    writer.writeDouble(
      1,
      f
    );
  }
  f = message.getMaxTotalDeployedPokemon();
  if (f !== 0) {
    writer.writeInt32(
      2,
      f
    );
  }
  f = message.getMaxPlayerDeployedPokemon();
  if (f !== 0) {
    writer.writeInt32(
      3,
      f
    );
  }
  f = message.getDeployStaminaMultiplier();
  if (f !== 0.0) {
    writer.writeDouble(
      4,
      f
    );
  }
  f = message.getDeployAttackMultiplier();
  if (f !== 0.0) {
    writer.writeDouble(
      5,
      f
    );
  }
  f = message.getFarInteractionRangeMeters();
  if (f !== 0.0) {
    writer.writeDouble(
      6,
      f
    );
  }
  f = message.getDisableGyms();
  if (f) {
    writer.writeBool(
      7,
      f
    );
  }
  f = message.getMaxSamePokemonAtFort();
  if (f !== 0) {
    writer.writeInt32(
      8,
      f
    );
  }
  f = message.getMaxPlayerTotalDeployedPokemon();
  if (f !== 0) {
    writer.writeInt32(
      9,
      f
    );
  }
  f = message.getEnableHyperlinksInPoiDescriptions();
  if (f) {
    writer.writeBool(
      10,
      f
    );
  }
  f = message.getEnableRightToLeftTextDisplay();
  if (f) {
    writer.writeBool(
      11,
      f
    );
  }
};


/**
 * optional double interaction_range_meters = 1;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getInteractionRangeMeters = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 1, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setInteractionRangeMeters = function(value) {
  jspb.Message.setProto3FloatField(this, 1, value);
};


/**
 * optional int32 max_total_deployed_pokemon = 2;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getMaxTotalDeployedPokemon = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 2, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setMaxTotalDeployedPokemon = function(value) {
  jspb.Message.setProto3IntField(this, 2, value);
};


/**
 * optional int32 max_player_deployed_pokemon = 3;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getMaxPlayerDeployedPokemon = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 3, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setMaxPlayerDeployedPokemon = function(value) {
  jspb.Message.setProto3IntField(this, 3, value);
};


/**
 * optional double deploy_stamina_multiplier = 4;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getDeployStaminaMultiplier = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 4, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setDeployStaminaMultiplier = function(value) {
  jspb.Message.setProto3FloatField(this, 4, value);
};


/**
 * optional double deploy_attack_multiplier = 5;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getDeployAttackMultiplier = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 5, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setDeployAttackMultiplier = function(value) {
  jspb.Message.setProto3FloatField(this, 5, value);
};


/**
 * optional double far_interaction_range_meters = 6;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getFarInteractionRangeMeters = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 6, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setFarInteractionRangeMeters = function(value) {
  jspb.Message.setProto3FloatField(this, 6, value);
};


/**
 * optional bool disable_gyms = 7;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getDisableGyms = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 7, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.FortSettings.prototype.setDisableGyms = function(value) {
  jspb.Message.setProto3BooleanField(this, 7, value);
};


/**
 * optional int32 max_same_pokemon_at_fort = 8;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getMaxSamePokemonAtFort = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 8, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setMaxSamePokemonAtFort = function(value) {
  jspb.Message.setProto3IntField(this, 8, value);
};


/**
 * optional int32 max_player_total_deployed_pokemon = 9;
 * @return {number}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getMaxPlayerTotalDeployedPokemon = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 9, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.FortSettings.prototype.setMaxPlayerTotalDeployedPokemon = function(value) {
  jspb.Message.setProto3IntField(this, 9, value);
};


/**
 * optional bool enable_hyperlinks_in_poi_descriptions = 10;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getEnableHyperlinksInPoiDescriptions = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 10, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.FortSettings.prototype.setEnableHyperlinksInPoiDescriptions = function(value) {
  jspb.Message.setProto3BooleanField(this, 10, value);
};


/**
 * optional bool enable_right_to_left_text_display = 11;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.FortSettings.prototype.getEnableRightToLeftTextDisplay = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 11, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.FortSettings.prototype.setEnableRightToLeftTextDisplay = function(value) {
  jspb.Message.setProto3BooleanField(this, 11, value);
};

