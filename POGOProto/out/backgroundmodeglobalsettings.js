/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Settings.BackgroundModeGlobalSettings');

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
proto.POGOProtos.Settings.BackgroundModeGlobalSettings = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Settings.BackgroundModeGlobalSettings, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Settings.BackgroundModeGlobalSettings.displayName = 'proto.POGOProtos.Settings.BackgroundModeGlobalSettings';
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
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Settings.BackgroundModeGlobalSettings.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Settings.BackgroundModeGlobalSettings} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.toObject = function(includeInstance, msg) {
  var f, obj = {
    minPlayerLevelFitness: jspb.Message.getFieldWithDefault(msg, 1, 0)
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
 * @return {!proto.POGOProtos.Settings.BackgroundModeGlobalSettings}
 */
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Settings.BackgroundModeGlobalSettings;
  return proto.POGOProtos.Settings.BackgroundModeGlobalSettings.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Settings.BackgroundModeGlobalSettings} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Settings.BackgroundModeGlobalSettings}
 */
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readUint32());
      msg.setMinPlayerLevelFitness(value);
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
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Settings.BackgroundModeGlobalSettings.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Settings.BackgroundModeGlobalSettings} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getMinPlayerLevelFitness();
  if (f !== 0) {
    writer.writeUint32(
      1,
      f
    );
  }
};


/**
 * optional uint32 min_player_level_fitness = 1;
 * @return {number}
 */
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.prototype.getMinPlayerLevelFitness = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.BackgroundModeGlobalSettings.prototype.setMinPlayerLevelFitness = function(value) {
  jspb.Message.setProto3IntField(this, 1, value);
};


