'use strict'

const path = require('path')
const fs = require('fs');
const protobuf = require("protobufjs");

protobuf.load({file:"POGOProtos/Networking/Responses/DownloadItemTemplatesResponse.proto", root:path.resolve(".")}, function(err, root) {
//protobuf.load("POGOProtos/Networking/Responses/DownloadItemTemplatesResponse.proto", function(err, root) {
//protobuf.load("tmp/hoge/awesome.proto", function(err, root) {
        //protobuf.load("POGOProtos/src/POGOProtos/Networking/Responses/DownloadItemTemplatesResponse.proto", function(err, root) {
    if (err){
        console.log("error");
        console.log(err.message);
        //throw err;
    }else{
        // Obtain a message type
        var AwesomeMessage = root.lookup("POGOProtos.Networking.Responses.DownloadItemTemplatesResponse");
        console.log("ok");
        console.log(AwesomeMessage);
        }
});

/*
//protobuf.load("./POGOProtos/Networking/Responses/DownloadItemTemplatesResponse.proto")
protobuf.load({root:"hoge", file:"Networking/Responses/DownloadItemTemplatesResponse.protofadfa"})
.then(function(root) {
    const DownloadItemTemplatesResponse = root.lookup
    console.log(DownloadItemTemplatesResponse)
})
.err(function(hoge){
    console.log("err");
});
*/




