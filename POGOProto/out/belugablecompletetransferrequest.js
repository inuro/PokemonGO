/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest');

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
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.displayName = 'proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest';
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
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.toObject = function(includeInstance, msg) {
  var f, obj = {
    transactionId: jspb.Message.getFieldWithDefault(msg, 1, 0),
    belugaRequestedItemId: jspb.Message.getFieldWithDefault(msg, 2, 0),
    nonce: jspb.Message.getFieldWithDefault(msg, 3, "")
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
 * @return {!proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest}
 */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest;
  return proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest}
 */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setTransactionId(value);
      break;
    case 2:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setBelugaRequestedItemId(value);
      break;
    case 3:
      var value = /** @type {string} */ (reader.readString());
      msg.setNonce(value);
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
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getTransactionId();
  if (f !== 0) {
    writer.writeInt64(
      1,
      f
    );
  }
  f = message.getBelugaRequestedItemId();
  if (f !== 0) {
    writer.writeInt32(
      2,
      f
    );
  }
  f = message.getNonce();
  if (f.length > 0) {
    writer.writeString(
      3,
      f
    );
  }
};


/**
 * optional int64 transaction_id = 1;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.getTransactionId = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.setTransactionId = function(value) {
  jspb.Message.setProto3IntField(this, 1, value);
};


/**
 * optional int32 beluga_requested_item_id = 2;
 * @return {number}
 */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.getBelugaRequestedItemId = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 2, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.setBelugaRequestedItemId = function(value) {
  jspb.Message.setProto3IntField(this, 2, value);
};


/**
 * optional string nonce = 3;
 * @return {string}
 */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.getNonce = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 3, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.Beluga.BelugaBleCompleteTransferRequest.prototype.setNonce = function(value) {
  jspb.Message.setProto3StringField(this, 3, value);
};


