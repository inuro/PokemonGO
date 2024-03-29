/**
 * @fileoverview
 * @enhanceable
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!

goog.provide('proto.POGOProtos.Settings.SocialClientSettings');

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
proto.POGOProtos.Settings.SocialClientSettings = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.POGOProtos.Settings.SocialClientSettings, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  proto.POGOProtos.Settings.SocialClientSettings.displayName = 'proto.POGOProtos.Settings.SocialClientSettings';
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
proto.POGOProtos.Settings.SocialClientSettings.prototype.toObject = function(opt_includeInstance) {
  return proto.POGOProtos.Settings.SocialClientSettings.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Whether to include the JSPB
 *     instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.POGOProtos.Settings.SocialClientSettings} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.SocialClientSettings.toObject = function(includeInstance, msg) {
  var f, obj = {
    enableSocial: jspb.Message.getFieldWithDefault(msg, 1, false),
    maxFriendDetails: jspb.Message.getFieldWithDefault(msg, 2, 0),
    playerLevelGate: jspb.Message.getFieldWithDefault(msg, 3, 0),
    maxFriendNicknameLength: jspb.Message.getFieldWithDefault(msg, 4, 0),
    enableAddFriendViaQrCode: jspb.Message.getFieldWithDefault(msg, 5, false),
    enableShareExPass: jspb.Message.getFieldWithDefault(msg, 6, false),
    enableFacebookFriends: jspb.Message.getFieldWithDefault(msg, 7, false),
    facebookFriendLimitPerRequest: jspb.Message.getFieldWithDefault(msg, 8, 0),
    disableFacebookFriendsOpeningPrompt: jspb.Message.getFieldWithDefault(msg, 9, false)
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
 * @return {!proto.POGOProtos.Settings.SocialClientSettings}
 */
proto.POGOProtos.Settings.SocialClientSettings.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.POGOProtos.Settings.SocialClientSettings;
  return proto.POGOProtos.Settings.SocialClientSettings.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.POGOProtos.Settings.SocialClientSettings} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.POGOProtos.Settings.SocialClientSettings}
 */
proto.POGOProtos.Settings.SocialClientSettings.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setEnableSocial(value);
      break;
    case 2:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxFriendDetails(value);
      break;
    case 3:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setPlayerLevelGate(value);
      break;
    case 4:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setMaxFriendNicknameLength(value);
      break;
    case 5:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setEnableAddFriendViaQrCode(value);
      break;
    case 6:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setEnableShareExPass(value);
      break;
    case 7:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setEnableFacebookFriends(value);
      break;
    case 8:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setFacebookFriendLimitPerRequest(value);
      break;
    case 9:
      var value = /** @type {boolean} */ (reader.readBool());
      msg.setDisableFacebookFriendsOpeningPrompt(value);
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
proto.POGOProtos.Settings.SocialClientSettings.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.POGOProtos.Settings.SocialClientSettings.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.POGOProtos.Settings.SocialClientSettings} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.POGOProtos.Settings.SocialClientSettings.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getEnableSocial();
  if (f) {
    writer.writeBool(
      1,
      f
    );
  }
  f = message.getMaxFriendDetails();
  if (f !== 0) {
    writer.writeInt32(
      2,
      f
    );
  }
  f = message.getPlayerLevelGate();
  if (f !== 0) {
    writer.writeInt32(
      3,
      f
    );
  }
  f = message.getMaxFriendNicknameLength();
  if (f !== 0) {
    writer.writeInt32(
      4,
      f
    );
  }
  f = message.getEnableAddFriendViaQrCode();
  if (f) {
    writer.writeBool(
      5,
      f
    );
  }
  f = message.getEnableShareExPass();
  if (f) {
    writer.writeBool(
      6,
      f
    );
  }
  f = message.getEnableFacebookFriends();
  if (f) {
    writer.writeBool(
      7,
      f
    );
  }
  f = message.getFacebookFriendLimitPerRequest();
  if (f !== 0) {
    writer.writeInt32(
      8,
      f
    );
  }
  f = message.getDisableFacebookFriendsOpeningPrompt();
  if (f) {
    writer.writeBool(
      9,
      f
    );
  }
};


/**
 * optional bool enable_social = 1;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getEnableSocial = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 1, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setEnableSocial = function(value) {
  jspb.Message.setProto3BooleanField(this, 1, value);
};


/**
 * optional int32 max_friend_details = 2;
 * @return {number}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getMaxFriendDetails = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 2, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setMaxFriendDetails = function(value) {
  jspb.Message.setProto3IntField(this, 2, value);
};


/**
 * optional int32 player_level_gate = 3;
 * @return {number}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getPlayerLevelGate = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 3, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setPlayerLevelGate = function(value) {
  jspb.Message.setProto3IntField(this, 3, value);
};


/**
 * optional int32 max_friend_nickname_length = 4;
 * @return {number}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getMaxFriendNicknameLength = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 4, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setMaxFriendNicknameLength = function(value) {
  jspb.Message.setProto3IntField(this, 4, value);
};


/**
 * optional bool enable_add_friend_via_qr_code = 5;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getEnableAddFriendViaQrCode = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 5, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setEnableAddFriendViaQrCode = function(value) {
  jspb.Message.setProto3BooleanField(this, 5, value);
};


/**
 * optional bool enable_share_ex_pass = 6;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getEnableShareExPass = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 6, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setEnableShareExPass = function(value) {
  jspb.Message.setProto3BooleanField(this, 6, value);
};


/**
 * optional bool enable_facebook_friends = 7;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getEnableFacebookFriends = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 7, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setEnableFacebookFriends = function(value) {
  jspb.Message.setProto3BooleanField(this, 7, value);
};


/**
 * optional int32 facebook_friend_limit_per_request = 8;
 * @return {number}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getFacebookFriendLimitPerRequest = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 8, 0));
};


/** @param {number} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setFacebookFriendLimitPerRequest = function(value) {
  jspb.Message.setProto3IntField(this, 8, value);
};


/**
 * optional bool disable_facebook_friends_opening_prompt = 9;
 * Note that Boolean fields may be set to 0/1 when serialized from a Java server.
 * You should avoid comparisons like {@code val === true/false} in those cases.
 * @return {boolean}
 */
proto.POGOProtos.Settings.SocialClientSettings.prototype.getDisableFacebookFriendsOpeningPrompt = function() {
  return /** @type {boolean} */ (jspb.Message.getFieldWithDefault(this, 9, false));
};


/** @param {boolean} value */
proto.POGOProtos.Settings.SocialClientSettings.prototype.setDisableFacebookFriendsOpeningPrompt = function(value) {
  jspb.Message.setProto3BooleanField(this, 9, value);
};


