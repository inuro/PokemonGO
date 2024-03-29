/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Data.News.NewsArticle');
goog.provide('proto.POGOProtos.Data.News.NewsArticle.NewsTemplate');

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
proto.POGOProtos.Data.News.NewsArticle = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, proto.POGOProtos.Data.News.NewsArticle.repeatedFields_, null);
};
goog.inherits(proto.POGOProtos.Data.News.NewsArticle, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Data.News.NewsArticle.displayName = 'proto.POGOProtos.Data.News.NewsArticle';
}
/**
 * List of repeated fields within this message type.
 * @private {!Array<number>}
 * @const
 */
proto.POGOProtos.Data.News.NewsArticle.repeatedFields_ = [2];



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
proto.POGOProtos.Data.News.NewsArticle.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Data.News.NewsArticle.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Data.News.NewsArticle} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.News.NewsArticle.toObject = function(includeInstance, msg) {
  var f, obj = {
    id: jspb.Message.getFieldWithDefault(msg, 1, ""),
    imageUrlList: jspb.Message.getRepeatedField(msg, 2),
    headerKey: jspb.Message.getFieldWithDefault(msg, 3, ""),
    subheaderKey: jspb.Message.getFieldWithDefault(msg, 4, ""),
    mainTextKey: jspb.Message.getFieldWithDefault(msg, 5, ""),
    timestamp: jspb.Message.getFieldWithDefault(msg, 6, 0),
    template: jspb.Message.getFieldWithDefault(msg, 7, 0),
    enabled: jspb.Message.getFieldWithDefault(msg, 8, false),
    articleRead: jspb.Message.getFieldWithDefault(msg, 9, false)
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
 * @return {!proto.POGOProtos.Data.News.NewsArticle}
 */
proto.POGOProtos.Data.News.NewsArticle.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Data.News.NewsArticle;
  return proto.POGOProtos.Data.News.NewsArticle.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Data.News.NewsArticle} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Data.News.NewsArticle}
 */
proto.POGOProtos.Data.News.NewsArticle.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {string} */ (reader.readString());
      msg.setId(value);
      break;
    case 2:
      var value = /** @type {string} */ (reader.readString());
      msg.addImageUrl(value);
      break;
    case 3:
      var value = /** @type {string} */ (reader.readString());
      msg.setHeaderKey(value);
      break;
    case 4:
      var value = /** @type {string} */ (reader.readString());
      msg.setSubheaderKey(value);
      break;
    case 5:
      var value = /** @type {string} */ (reader.readString());
      msg.setMainTextKey(value);
      break;
    case 6:
      var value = /** @type {number} */ (reader.readInt64());
      msg.setTimestamp(value);
      break;
    case 7:
      var value = /** @type {!proto.POGOProtos.Data.News.NewsArticle.NewsTemplate} */ (reader.readEnum());
      msg.setTemplate(value);
      break;
    case 8:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setEnabled(value);
      break;
    case 9:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setArticleRead(value);
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
proto.POGOProtos.Data.News.NewsArticle.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Data.News.NewsArticle.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Data.News.NewsArticle} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Data.News.NewsArticle.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getId();
  if (f.length > 0) {
    writer.writeString(
      1,
      f
    );
  }
  f = message.getImageUrlList();
  if (f.length > 0) {
    writer.writeRepeatedString(
      2,
      f
    );
  }
  f = message.getHeaderKey();
  if (f.length > 0) {
    writer.writeString(
      3,
      f
    );
  }
  f = message.getSubheaderKey();
  if (f.length > 0) {
    writer.writeString(
      4,
      f
    );
  }
  f = message.getMainTextKey();
  if (f.length > 0) {
    writer.writeString(
      5,
      f
    );
  }
  f = message.getTimestamp();
  if (f !== 0) {
    writer.writeInt64(
      6,
      f
    );
  }
  f = message.getTemplate();
  if (f !== 0.0) {
    writer.writeEnum(
      7,
      f
    );
  }
  f = message.getEnabled();
  if (f) {
    writer.writeBool(
      8,
      f
    );
  }
  f = message.getArticleRead();
  if (f) {
    writer.writeBool(
      9,
      f
    );
  }
};


/**
 * @enum {number}
 */
proto.POGOProtos.Data.News.NewsArticle.NewsTemplate = {
  UNSET: 0,
  DEFAULT_TEMPLATE: 1
};

/**
 * optional string id = 1;
 * @return {string}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getId = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 1, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setId = function(value) {
  jspb.Message.setProto3StringField(this, 1, value);
};


/**
 * repeated string image_url = 2;
 * @return {!Array<string>}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getImageUrlList = function() {
  return /** @type {!Array<string>} */ (jspb.Message.getRepeatedField(this, 2));
};


/** @param {!Array<string>} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setImageUrlList = function(value) {
  jspb.Message.setField(this, 2, value || []);
};


/**
 * @param {!string} value
 * @param {number=} opt_index
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.addImageUrl = function(value, opt_index) {
  jspb.Message.addToRepeatedField(this, 2, value, opt_index);
};


proto.POGOProtos.Data.News.NewsArticle.prototype.clearImageUrlList = function() {
  this.setImageUrlList([]);
};


/**
 * optional string header_key = 3;
 * @return {string}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getHeaderKey = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 3, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setHeaderKey = function(value) {
  jspb.Message.setProto3StringField(this, 3, value);
};


/**
 * optional string subheader_key = 4;
 * @return {string}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getSubheaderKey = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 4, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setSubheaderKey = function(value) {
  jspb.Message.setProto3StringField(this, 4, value);
};


/**
 * optional string main_text_key = 5;
 * @return {string}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getMainTextKey = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 5, ""));
};


/** @param {string} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setMainTextKey = function(value) {
  jspb.Message.setProto3StringField(this, 5, value);
};


/**
 * optional int64 timestamp = 6;
 * @return {number}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getTimestamp = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 6, 0));
};


/** @param {number} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setTimestamp = function(value) {
  jspb.Message.setProto3IntField(this, 6, value);
};


/**
 * optional NewsTemplate template = 7;
 * @return {!proto.POGOProtos.Data.News.NewsArticle.NewsTemplate}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getTemplate = function() {
  return /** @type {!proto.POGOProtos.Data.News.NewsArticle.NewsTemplate} */ (jspb.Message.getFieldWithDefault(this, 7, 0));
};


/** @param {!proto.POGOProtos.Data.News.NewsArticle.NewsTemplate} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setTemplate = function(value) {
  jspb.Message.setProto3EnumField(this, 7, value);
};


/**
 * optional bool enabled = 8;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getEnabled = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 8, false));
};


/** @param {boolean} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setEnabled = function(value) {
  jspb.Message.setProto3BooleanField(this, 8, value);
};


/**
 * optional bool article_read = 9;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Data.News.NewsArticle.prototype.getArticleRead = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 9, false));
};


/** @param {boolean} value */
proto.POGOProtos.Data.News.NewsArticle.prototype.setArticleRead = function(value) {
  jspb.Message.setProto3BooleanField(this, 9, value);
};


