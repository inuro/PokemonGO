/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Map.Weather.WeatherAlert');
goog.provide('proto.POGOProtos.Map.Weather.WeatherAlert.Severity');

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
proto.POGOProtos.Map.Weather.WeatherAlert = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Map.Weather.WeatherAlert, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Map.Weather.WeatherAlert.displayName = 'proto.POGOProtos.Map.Weather.WeatherAlert';
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
proto.POGOProtos.Map.Weather.WeatherAlert.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Map.Weather.WeatherAlert.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Map.Weather.WeatherAlert} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Map.Weather.WeatherAlert.toObject = function(includeInstance, msg) {
  var f, obj = {
    severity: jspb.Message.getFieldWithDefault(msg, 1, 0),
    warnWeather: jspb.Message.getFieldWithDefault(msg, 2, false)
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
 * @return {!proto.POGOProtos.Map.Weather.WeatherAlert}
 */
proto.POGOProtos.Map.Weather.WeatherAlert.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Map.Weather.WeatherAlert;
  return proto.POGOProtos.Map.Weather.WeatherAlert.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Map.Weather.WeatherAlert} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Map.Weather.WeatherAlert}
 */
proto.POGOProtos.Map.Weather.WeatherAlert.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {!proto.POGOProtos.Map.Weather.WeatherAlert.Severity} */ (reader.readEnum());
      msg.setSeverity(value);
      break;
    case 2:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setWarnWeather(value);
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
proto.POGOProtos.Map.Weather.WeatherAlert.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Map.Weather.WeatherAlert.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Map.Weather.WeatherAlert} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Map.Weather.WeatherAlert.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getSeverity();
  if (f !== 0.0) {
    writer.writeEnum(
      1,
      f
    );
  }
  f = message.getWarnWeather();
  if (f) {
    writer.writeBool(
      2,
      f
    );
  }
};


/**
 * @enum {number}
 */
proto.POGOProtos.Map.Weather.WeatherAlert.Severity = {
  NONE: 0,
  MODERATE: 1,
  EXTREME: 2
};

/**
 * optional Severity severity = 1;
 * @return {!proto.POGOProtos.Map.Weather.WeatherAlert.Severity}
 */
proto.POGOProtos.Map.Weather.WeatherAlert.prototype.getSeverity = function() {
  return /** @type {!proto.POGOProtos.Map.Weather.WeatherAlert.Severity} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/** @param {!proto.POGOProtos.Map.Weather.WeatherAlert.Severity} value */
proto.POGOProtos.Map.Weather.WeatherAlert.prototype.setSeverity = function(value) {
  jspb.Message.setProto3EnumField(this, 1, value);
};


/**
 * optional bool warn_weather = 2;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Map.Weather.WeatherAlert.prototype.getWarnWeather = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 2, false));
};


/** @param {boolean} value */
proto.POGOProtos.Map.Weather.WeatherAlert.prototype.setWarnWeather = function(value) {
  jspb.Message.setProto3BooleanField(this, 2, value);
};


