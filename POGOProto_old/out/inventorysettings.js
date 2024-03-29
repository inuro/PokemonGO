/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Settings.InventorySettings');

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
proto.POGOProtos.Settings.InventorySettings = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Settings.InventorySettings, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Settings.InventorySettings.displayName = 'proto.POGOProtos.Settings.InventorySettings';
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
proto.POGOProtos.Settings.InventorySettings.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Settings.InventorySettings.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Settings.InventorySettings} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.InventorySettings.toObject = function(includeInstance, msg) {
  var f, obj = {
    maxPokemon: jspb.Message.getFieldWithDefault(msg, 1, 0),
    maxBagItems: jspb.Message.getFieldWithDefault(msg, 2, 0),
    basePokemon: jspb.Message.getFieldWithDefault(msg, 3, 0),
    baseBagItems: jspb.Message.getFieldWithDefault(msg, 4, 0),
    baseEggs: jspb.Message.getFieldWithDefault(msg, 5, 0)
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
 * @return {!proto.POGOProtos.Settings.InventorySettings}
 */
proto.POGOProtos.Settings.InventorySettings.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Settings.InventorySettings;
  return proto.POGOProtos.Settings.InventorySettings.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Settings.InventorySettings} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Settings.InventorySettings}
 */
proto.POGOProtos.Settings.InventorySettings.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxPokemon(value);
      break;
    case 2:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxBagItems(value);
      break;
    case 3:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setBasePokemon(value);
      break;
    case 4:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setBaseBagItems(value);
      break;
    case 5:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setBaseEggs(value);
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
proto.POGOProtos.Settings.InventorySettings.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Settings.InventorySettings.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Settings.InventorySettings} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.InventorySettings.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getMaxPokemon();
  if (f !== 0) {
    writer.writeInt32(
      1,
      f
    );
  }
  f = message.getMaxBagItems();
  if (f !== 0) {
    writer.writeInt32(
      2,
      f
    );
  }
  f = message.getBasePokemon();
  if (f !== 0) {
    writer.writeInt32(
      3,
      f
    );
  }
  f = message.getBaseBagItems();
  if (f !== 0) {
    writer.writeInt32(
      4,
      f
    );
  }
  f = message.getBaseEggs();
  if (f !== 0) {
    writer.writeInt32(
      5,
      f
    );
  }
};


/**
 * optional int32 max_pokemon = 1;
 * @return {number}
 */
proto.POGOProtos.Settings.InventorySettings.prototype.getMaxPokemon = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.InventorySettings.prototype.setMaxPokemon = function(value) {
  jspb.Message.setProto3IntField(this, 1, value);
};


/**
 * optional int32 max_bag_items = 2;
 * @return {number}
 */
proto.POGOProtos.Settings.InventorySettings.prototype.getMaxBagItems = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 2, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.InventorySettings.prototype.setMaxBagItems = function(value) {
  jspb.Message.setProto3IntField(this, 2, value);
};


/**
 * optional int32 base_pokemon = 3;
 * @return {number}
 */
proto.POGOProtos.Settings.InventorySettings.prototype.getBasePokemon = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 3, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.InventorySettings.prototype.setBasePokemon = function(value) {
  jspb.Message.setProto3IntField(this, 3, value);
};


/**
 * optional int32 base_bag_items = 4;
 * @return {number}
 */
proto.POGOProtos.Settings.InventorySettings.prototype.getBaseBagItems = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 4, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.InventorySettings.prototype.setBaseBagItems = function(value) {
  jspb.Message.setProto3IntField(this, 4, value);
};


/**
 * optional int32 base_eggs = 5;
 * @return {number}
 */
proto.POGOProtos.Settings.InventorySettings.prototype.getBaseEggs = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 5, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.InventorySettings.prototype.setBaseEggs = function(value) {
  jspb.Message.setProto3IntField(this, 5, value);
};


