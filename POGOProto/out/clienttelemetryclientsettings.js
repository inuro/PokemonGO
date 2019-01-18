/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings');

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
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.displayName = 'proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings';
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
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.toObject = function(includeInstance, msg) {
  var f, obj = {
    isUploadEnabled: jspb.Message.getFieldWithDefault(msg, 1, false),
    maxUploadSizeInBytes: jspb.Message.getFieldWithDefault(msg, 2, 0),
    updateIntervalInSec: jspb.Message.getFieldWithDefault(msg, 3, 0),
    settingsUpdateIntervalInSec: jspb.Message.getFieldWithDefault(msg, 4, 0),
    maxEnvelopeQueueSize: jspb.Message.getFieldWithDefault(msg, 5, 0),
    samplingProbability: +jspb.Message.getFieldWithDefault(msg, 6, 0.0),
    usePlayerBasedSampling: jspb.Message.getFieldWithDefault(msg, 7, false),
    playerHash: +jspb.Message.getFieldWithDefault(msg, 8, 0.0),
    playerExternalOmniId: jspb.Message.getFieldWithDefault(msg, 9, ""),
    disableOmniSending: jspb.Message.getFieldWithDefault(msg, 10, false)
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
 * @return {!proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings;
  return proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setIsUploadEnabled(value);
      break;
    case 2:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setMaxUploadSizeInBytes(value);
      break;
    case 3:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setUpdateIntervalInSec(value);
      break;
    case 4:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setSettingsUpdateIntervalInSec(value);
      break;
    case 5:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setMaxEnvelopeQueueSize(value);
      break;
    case 6:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setSamplingProbability(value);
      break;
    case 7:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setUsePlayerBasedSampling(value);
      break;
    case 8:
      var value = /** @type {number} */ (reader.readDouble());
      msg.setPlayerHash(value);
      break;
    case 9:
      var value = /** @type {string} */ (reader.readString());
      msg.setPlayerExternalOmniId(value);
      break;
    case 10:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setDisableOmniSending(value);
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
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getIsUploadEnabled();
  if (f) {
    writer.writeBool(
      1,
      f
    );
  }
  f = message.getMaxUploadSizeInBytes();
  if (f !== 0) {
    writer.writeInt64(
      2,
      f
    );
  }
  f = message.getUpdateIntervalInSec();
  if (f !== 0) {
    writer.writeInt64(
      3,
      f
    );
  }
  f = message.getSettingsUpdateIntervalInSec();
  if (f !== 0) {
    writer.writeInt64(
      4,
      f
    );
  }
  f = message.getMaxEnvelopeQueueSize();
  if (f !== 0) {
    writer.writeInt64(
      5,
      f
    );
  }
  f = message.getSamplingProbability();
  if (f !== 0.0) {
    writer.writeDouble(
      6,
      f
    );
  }
  f = message.getUsePlayerBasedSampling();
  if (f) {
    writer.writeBool(
      7,
      f
    );
  }
  f = message.getPlayerHash();
  if (f !== 0.0) {
    writer.writeDouble(
      8,
      f
    );
  }
  f = message.getPlayerExternalOmniId();
  if (f.length > 0) {
    writer.writeString(
      9,
      f
    );
  }
  f = message.getDisableOmniSending();
  if (f) {
    writer.writeBool(
      10,
      f
    );
  }
};


/**
 * optional bool is_upload_enabled = 1;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getIsUploadEnabled = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 1, false));
};


/** @param {boolean} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setIsUploadEnabled = function(value) {
  jspb.Message.setProto3BooleanField(this, 1, value);
};


/**
 * optional int64 max_upload_size_in_bytes = 2;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getMaxUploadSizeInBytes = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 2, 0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setMaxUploadSizeInBytes = function(value) {
  jspb.Message.setProto3IntField(this, 2, value);
};


/**
 * optional int64 update_interval_in_sec = 3;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getUpdateIntervalInSec = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 3, 0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setUpdateIntervalInSec = function(value) {
  jspb.Message.setProto3IntField(this, 3, value);
};


/**
 * optional int64 settings_update_interval_in_sec = 4;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getSettingsUpdateIntervalInSec = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 4, 0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setSettingsUpdateIntervalInSec = function(value) {
  jspb.Message.setProto3IntField(this, 4, value);
};


/**
 * optional int64 max_envelope_queue_size = 5;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getMaxEnvelopeQueueSize = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 5, 0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setMaxEnvelopeQueueSize = function(value) {
  jspb.Message.setProto3IntField(this, 5, value);
};


/**
 * optional double sampling_probability = 6;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getSamplingProbability = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 6, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setSamplingProbability = function(value) {
  jspb.Message.setProto3FloatField(this, 6, value);
};


/**
 * optional bool use_player_based_sampling = 7;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getUsePlayerBasedSampling = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 7, false));
};


/** @param {boolean} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setUsePlayerBasedSampling = function(value) {
  jspb.Message.setProto3BooleanField(this, 7, value);
};


/**
 * optional double player_hash = 8;
 * @return {number}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getPlayerHash = function() {
  return /** @type {number} */ (+jspb.Message.getFieldWithDefault(this, 8, 0.0));
};


/** @param {number} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setPlayerHash = function(value) {
  jspb.Message.setProto3FloatField(this, 8, value);
};


/**
 * optional string player_external_omni_id = 9;
 * @return {string}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getPlayerExternalOmniId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 9, ""));
};


/** @param {string} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setPlayerExternalOmniId = function(value) {
  jspb.Message.setProto3StringField(this, 9, value);
};


/**
 * optional bool disable_omni_sending = 10;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.getDisableOmniSending = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 10, false));
};


/** @param {boolean} value */
proto.POGOProtos.Networking.Platform.Analytics.ClientTelemetryClientSettings.prototype.setDisableOmniSending = function(value) {
  jspb.Message.setProto3BooleanField(this, 10, value);
};


