/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Data.Gift.GiftBox');

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
proto.POGOProtos.Data.Gift.GiftBox = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Data.Gift.GiftBox, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Data.Gift.GiftBox.displayName = 'proto.POGOProtos.Data.Gift.GiftBox';
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
proto.POGOProtos.Data.Gift.GiftBox.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Data.Gift.GiftBox.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Data.Gift.GiftBox} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Gift.GiftBox.toObject = function(includeInstance, msg) {
  var f, obj = {
    giftboxId: jspb.Message.getFieldWithDefault(msg, 1, 0),
    senderId: jspb.Message.getFieldWithDefault(msg, 2, ""),
    receiverId: jspb.Message.getFieldWithDefault(msg, 3, ""),
    fortId: jspb.Message.getFieldWithDefault(msg, 4, ""),
    fortLat: +jspb.Message.getFieldWithDefault(msg, 5, 0.0),
    fortLng: +jspb.Message.getFieldWithDefault(msg, 6, 0.0),
    creationTimestamp: jspb.Message.getFieldWithDefault(msg, 7, 0),
    sentTimestamp: jspb.Message.getFieldWithDefault(msg, 8, 0),
    sentBucket: jspb.Message.getFieldWithDefault(msg, 9, 0)
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
 * @return {!proto.POGOProtos.Data.Gift.GiftBox}
 */
proto.POGOProtos.Data.Gift.GiftBox.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Data.Gift.GiftBox;
  return proto.POGOProtos.Data.Gift.GiftBox.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Data.Gift.GiftBox} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Data.Gift.GiftBox}
 */
proto.POGOProtos.Data.Gift.GiftBox.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readFixed64());
      msg.setGiftboxId(value);
      break;
    case 2:
      var value = /** @type {string} */ (reader.readString());
      msg.setSenderId(value);
      break;
    case 3:
      var value = /** @type {string} */ (reader.readString());
      msg.setReceiverId(value);
      break;
    case 4:
      var value = /** @type {string} */ (reader.readString());
      msg.setFortId(value);
      break;
    case 5:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setFortLat(value);
      break;
    case 6:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setFortLng(value);
      break;
    case 7:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setCreationTimestamp(value);
      break;
    case 8:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setSentTimestamp(value);
      break;
    case 9:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setSentBucket(value);
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
proto.POGOProtos.Data.Gift.GiftBox.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Data.Gift.GiftBox.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Data.Gift.GiftBox} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Gift.GiftBox.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getGiftboxId();
  if (f !== 0) {
    writer.writeFixed64(
      1,
      f
    );
  }
  f = message.getSenderId();
  if (f.length > 0) {
    writer.writeString(
      2,
      f
    );
  }
  f = message.getReceiverId();
  if (f.length > 0) {
    writer.writeString(
      3,
      f
    );
  }
  f = message.getFortId();
  if (f.length > 0) {
    writer.writeString(
      4,
      f
    );
  }
  f = message.getFortLat();
  if (f !== 0.0) {
    writer.writeDouble(
      5,
      f
    );
  }
  f = message.getFortLng();
  if (f !== 0.0) {
    writer.writeDouble(
      6,
      f
    );
  }
  f = message.getCreationTimestamp();
  if (f !== 0) {
    writer.writeInt64(
      7,
      f
    );
  }
  f = message.getSentTimestamp();
  if (f !== 0) {
    writer.writeInt64(
      8,
      f
    );
  }
  f = message.getSentBucket();
  if (f !== 0) {
    writer.writeInt64(
      9,
      f
    );
  }
};


/**
 * optional fixed64 giftbox_id = 1;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getGiftboxId = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setGiftboxId = function(value) {
  jspb.Message.setProto3IntField(this, 1, value);
};


/**
 * optional string sender_id = 2;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getSenderId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 2, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setSenderId = function(value) {
  jspb.Message.setProto3StringField(this, 2, value);
};


/**
 * optional string receiver_id = 3;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getReceiverId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 3, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setReceiverId = function(value) {
  jspb.Message.setProto3StringField(this, 3, value);
};


/**
 * optional string fort_id = 4;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getFortId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 4, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setFortId = function(value) {
  jspb.Message.setProto3StringField(this, 4, value);
};


/**
 * optional double fort_lat = 5;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getFortLat = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 5, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setFortLat = function(value) {
  jspb.Message.setProto3FloatField(this, 5, value);
};


/**
 * optional double fort_lng = 6;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getFortLng = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 6, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setFortLng = function(value) {
  jspb.Message.setProto3FloatField(this, 6, value);
};


/**
 * optional int64 creation_timestamp = 7;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getCreationTimestamp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 7, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setCreationTimestamp = function(value) {
  jspb.Message.setProto3IntField(this, 7, value);
};


/**
 * optional int64 sent_timestamp = 8;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getSentTimestamp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 8, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setSentTimestamp = function(value) {
  jspb.Message.setProto3IntField(this, 8, value);
};


/**
 * optional int64 sent_bucket = 9;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBox.prototype.getSentBucket = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 9, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBox.prototype.setSentBucket = function(value) {
  jspb.Message.setProto3IntField(this, 9, value);
};

