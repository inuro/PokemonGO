/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon');

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
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.displayName = 'proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon';
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
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.toObject = function(includeInstance, msg) {
  var f, obj = {
    timestamp: jspb.Message.getFieldWithDefault(msg, 1, 0),
    correlationVector: jspb.Message.getFieldWithDefault(msg, 2, ""),
    eventId: jspb.Message.getFieldWithDefault(msg, 3, ""),
    clientTimestampMs: jspb.Message.getFieldWithDefault(msg, 4, 0)
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
 * @return {!proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon}
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon;
  return proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon}
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setTimestamp(value);
      break;
    case 2:
      var value = /** @type {string} */ (reader.readString());
      msg.setCorrelationVector(value);
      break;
    case 3:
      var value = /** @type {string} */ (reader.readString());
      msg.setEventId(value);
      break;
    case 4:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setClientTimestampMs(value);
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
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getTimestamp();
  if (f !== 0) {
    writer.writeInt64(
      1,
      f
    );
  }
  f = message.getCorrelationVector();
  if (f.length > 0) {
    writer.writeString(
      2,
      f
    );
  }
  f = message.getEventId();
  if (f.length > 0) {
    writer.writeString(
      3,
      f
    );
  }
  f = message.getClientTimestampMs();
  if (f !== 0) {
    writer.writeInt64(
      4,
      f
    );
  }
};


/**
 * optional int64 timestamp = 1;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.getTimestamp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.setTimestamp = function(value) {
  jspb.Message.setProto3IntField(this, 1, value);
};


/**
 * optional string correlation_vector = 2;
 * @return {string}
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.getCorrelationVector = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 2, ""));
};


/** @param {string} value */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.setCorrelationVector = function(value) {
  jspb.Message.setProto3StringField(this, 2, value);
};


/**
 * optional string event_id = 3;
 * @return {string}
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.getEventId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 3, ""));
};


/** @param {string} value */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.setEventId = function(value) {
  jspb.Message.setProto3StringField(this, 3, value);
};


/**
 * optional int64 client_timestamp_ms = 4;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.getClientTimestampMs = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 4, 0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Telemetry.TelemetryCommon.prototype.setClientTimestampMs = function(value) {
  jspb.Message.setProto3IntField(this, 4, value);
};


