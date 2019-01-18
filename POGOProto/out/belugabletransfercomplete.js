/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete');

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
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.displayName = 'proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete';
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
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.toObject = function(includeInstance, msg) {
  var f, obj = {
    nonce: jspb.Message.getFieldWithDefault(msg, 1, ""),
    belugaId: jspb.Message.getFieldWithDefault(msg, 2, "")
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
 * @return {!proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete}
 */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete;
  return proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete}
 */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {string} */ (reader.readString());
      msg.setNonce(value);
      break;
    case 2:
      var value = /** @type {string} */ (reader.readString());
      msg.setBelugaId(value);
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
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getNonce();
  if (f.length > 0) {
    writer.writeString(
      1,
      f
    );
  }
  f = message.getBelugaId();
  if (f.length > 0) {
    writer.writeString(
      2,
      f
    );
  }
};


/**
 * optional string nonce = 1;
 * @return {string}
 */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.prototype.getNonce = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 1, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.prototype.setNonce = function(value) {
  jspb.Message.setProto3StringField(this, 1, value);
};


/**
 * optional string beluga_id = 2;
 * @return {string}
 */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.prototype.getBelugaId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 2, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Beluga.BelugaBleTransferComplete.prototype.setBelugaId = function(value) {
  jspb.Message.setProto3StringField(this, 2, value);
};


