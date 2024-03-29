/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Settings.LevelSettings');

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
proto.POGOProtos.Settings.LevelSettings = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Settings.LevelSettings, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Settings.LevelSettings.displayName = 'proto.POGOProtos.Settings.LevelSettings';
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
proto.POGOProtos.Settings.LevelSettings.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Settings.LevelSettings.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Settings.LevelSettings} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.LevelSettings.toObject = function(includeInstance, msg) {
  var f, obj = {
    trainerCpModifier: +jspb.Message.getFieldWithDefault(msg, 2, 0.0),
    trainerDifficultyModifier: +jspb.Message.getFieldWithDefault(msg, 3, 0.0)
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
 * @return {!proto.POGOProtos.Settings.LevelSettings}
 */
proto.POGOProtos.Settings.LevelSettings.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Settings.LevelSettings;
  return proto.POGOProtos.Settings.LevelSettings.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Settings.LevelSettings} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Settings.LevelSettings}
 */
proto.POGOProtos.Settings.LevelSettings.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 2:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setTrainerCpModifier(value);
      break;
    case 3:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setTrainerDifficultyModifier(value);
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
proto.POGOProtos.Settings.LevelSettings.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Settings.LevelSettings.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Settings.LevelSettings} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.LevelSettings.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getTrainerCpModifier();
  if (f !== 0.0) {
    writer.writeDouble(
      2,
      f
    );
  }
  f = message.getTrainerDifficultyModifier();
  if (f !== 0.0) {
    writer.writeDouble(
      3,
      f
    );
  }
};


/**
 * optional double trainer_cp_modifier = 2;
 * @return {number}
 */
proto.POGOProtos.Settings.LevelSettings.prototype.getTrainerCpModifier = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 2, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.LevelSettings.prototype.setTrainerCpModifier = function(value) {
  jspb.Message.setProto3FloatField(this, 2, value);
};


/**
 * optional double trainer_difficulty_modifier = 3;
 * @return {number}
 */
proto.POGOProtos.Settings.LevelSettings.prototype.getTrainerDifficultyModifier = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 3, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Settings.LevelSettings.prototype.setTrainerDifficultyModifier = function(value) {
  jspb.Message.setProto3FloatField(this, 3, value);
};


