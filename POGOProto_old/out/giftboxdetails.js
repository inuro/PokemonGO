/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Data.Gift.GiftBoxDetails');

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
proto.POGOProtos.Data.Gift.GiftBoxDetails = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Data.Gift.GiftBoxDetails, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Data.Gift.GiftBoxDetails.displayName = 'proto.POGOProtos.Data.Gift.GiftBoxDetails';
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
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Data.Gift.GiftBoxDetails.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Data.Gift.GiftBoxDetails} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.toObject = function(includeInstance, msg) {
  var f, obj = {
    giftboxId: jspb.Message.getFieldWithDefault(msg, 1, 0),
    senderId: jspb.Message.getFieldWithDefault(msg, 2, ""),
    senderCodename: jspb.Message.getFieldWithDefault(msg, 3, ""),
    receiverId: jspb.Message.getFieldWithDefault(msg, 4, ""),
    receiverCodename: jspb.Message.getFieldWithDefault(msg, 5, ""),
    fortId: jspb.Message.getFieldWithDefault(msg, 6, ""),
    fortName: jspb.Message.getFieldWithDefault(msg, 7, ""),
    fortLat: +jspb.Message.getFieldWithDefault(msg, 8, 0.0),
    fortLng: +jspb.Message.getFieldWithDefault(msg, 9, 0.0),
    fortImageUrl: jspb.Message.getFieldWithDefault(msg, 10, ""),
    creationTimestamp: jspb.Message.getFieldWithDefault(msg, 11, 0),
    sentTimestamp: jspb.Message.getFieldWithDefault(msg, 12, 0),
    deliveryPokemonId: jspb.Message.getFieldWithDefault(msg, 13, 0),
    isSponsored: jspb.Message.getFieldWithDefault(msg, 14, false)
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
 * @return {!proto.POGOProtos.Data.Gift.GiftBoxDetails}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Data.Gift.GiftBoxDetails;
  return proto.POGOProtos.Data.Gift.GiftBoxDetails.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Data.Gift.GiftBoxDetails} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Data.Gift.GiftBoxDetails}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.deserializeBinaryFromReader = function(msg, reader) {
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
      msg.setSenderCodename(value);
      break;
    case 4:
      var value = /** @type {string} */ (reader.readString());
      msg.setReceiverId(value);
      break;
    case 5:
      var value = /** @type {string} */ (reader.readString());
      msg.setReceiverCodename(value);
      break;
    case 6:
      var value = /** @type {string} */ (reader.readString());
      msg.setFortId(value);
      break;
    case 7:
      var value = /** @type {string} */ (reader.readString());
      msg.setFortName(value);
      break;
    case 8:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setFortLat(value);
      break;
    case 9:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setFortLng(value);
      break;
    case 10:
      var value = /** @type {string} */ (reader.readString());
      msg.setFortImageUrl(value);
      break;
    case 11:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setCreationTimestamp(value);
      break;
    case 12:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setSentTimestamp(value);
      break;
    case 13:
      var value = /** @type {number} */ (reader.readFixed64());
      msg.setDeliveryPokemonId(value);
      break;
    case 14:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setIsSponsored(value);
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
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Data.Gift.GiftBoxDetails.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Data.Gift.GiftBoxDetails} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.serializeBinaryToWriter = function(message, writer) {
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
  f = message.getSenderCodename();
  if (f.length > 0) {
    writer.writeString(
      3,
      f
    );
  }
  f = message.getReceiverId();
  if (f.length > 0) {
    writer.writeString(
      4,
      f
    );
  }
  f = message.getReceiverCodename();
  if (f.length > 0) {
    writer.writeString(
      5,
      f
    );
  }
  f = message.getFortId();
  if (f.length > 0) {
    writer.writeString(
      6,
      f
    );
  }
  f = message.getFortName();
  if (f.length > 0) {
    writer.writeString(
      7,
      f
    );
  }
  f = message.getFortLat();
  if (f !== 0.0) {
    writer.writeDouble(
      8,
      f
    );
  }
  f = message.getFortLng();
  if (f !== 0.0) {
    writer.writeDouble(
      9,
      f
    );
  }
  f = message.getFortImageUrl();
  if (f.length > 0) {
    writer.writeString(
      10,
      f
    );
  }
  f = message.getCreationTimestamp();
  if (f !== 0) {
    writer.writeInt64(
      11,
      f
    );
  }
  f = message.getSentTimestamp();
  if (f !== 0) {
    writer.writeInt64(
      12,
      f
    );
  }
  f = message.getDeliveryPokemonId();
  if (f !== 0) {
    writer.writeFixed64(
      13,
      f
    );
  }
  f = message.getIsSponsored();
  if (f) {
    writer.writeBool(
      14,
      f
    );
  }
};


/**
 * optional fixed64 giftbox_id = 1;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getGiftboxId = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setGiftboxId = function(value) {
  jspb.Message.setProto3IntField(this, 1, value);
};


/**
 * optional string sender_id = 2;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getSenderId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 2, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setSenderId = function(value) {
  jspb.Message.setProto3StringField(this, 2, value);
};


/**
 * optional string sender_codename = 3;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getSenderCodename = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 3, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setSenderCodename = function(value) {
  jspb.Message.setProto3StringField(this, 3, value);
};


/**
 * optional string receiver_id = 4;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getReceiverId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 4, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setReceiverId = function(value) {
  jspb.Message.setProto3StringField(this, 4, value);
};


/**
 * optional string receiver_codename = 5;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getReceiverCodename = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 5, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setReceiverCodename = function(value) {
  jspb.Message.setProto3StringField(this, 5, value);
};


/**
 * optional string fort_id = 6;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getFortId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 6, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setFortId = function(value) {
  jspb.Message.setProto3StringField(this, 6, value);
};


/**
 * optional string fort_name = 7;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getFortName = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 7, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setFortName = function(value) {
  jspb.Message.setProto3StringField(this, 7, value);
};


/**
 * optional double fort_lat = 8;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getFortLat = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 8, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setFortLat = function(value) {
  jspb.Message.setProto3FloatField(this, 8, value);
};


/**
 * optional double fort_lng = 9;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getFortLng = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 9, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setFortLng = function(value) {
  jspb.Message.setProto3FloatField(this, 9, value);
};


/**
 * optional string fort_image_url = 10;
 * @return {string}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getFortImageUrl = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 10, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setFortImageUrl = function(value) {
  jspb.Message.setProto3StringField(this, 10, value);
};


/**
 * optional int64 creation_timestamp = 11;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getCreationTimestamp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 11, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setCreationTimestamp = function(value) {
  jspb.Message.setProto3IntField(this, 11, value);
};


/**
 * optional int64 sent_timestamp = 12;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getSentTimestamp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 12, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setSentTimestamp = function(value) {
  jspb.Message.setProto3IntField(this, 12, value);
};


/**
 * optional fixed64 delivery_pokemon_id = 13;
 * @return {number}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getDeliveryPokemonId = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 13, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setDeliveryPokemonId = function(value) {
  jspb.Message.setProto3IntField(this, 13, value);
};


/**
 * optional bool is_sponsored = 14;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.getIsSponsored = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 14, false));
};


/** @param {boolean} value */
proto.POGOProtos.Data.Gift.GiftBoxDetails.prototype.setIsSponsored = function(value) {
  jspb.Message.setProto3BooleanField(this, 14, value);
};

