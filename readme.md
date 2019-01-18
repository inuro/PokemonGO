# PokemonGO

## dependencies

- Node fs module https://nodejs.org/api/fs.html
- ProtoBuf.js  https://github.com/dcodeIO/ProtoBuf.js
- PokemonGO Protobuf message schemas(.proto) https://github.com/Furtif/POGOProtos



## usage

### decode original protobuf into JSON
```
$ node decode_game_master.js 00000168B89D100A_GAME_MASTER > game_master_01-12-19.json
```

### extract information from JSON
```
$ ./extract_game_master.sh game_master_01-12-19.json masterfiles
```

### import into PostgreSQL
```
# create database 
$ createdb pokemongo
# import
$ ./import2psql.sh pokemongo masterfiles sidefiles
```

## GAME_MASTER
- 00000168B89D100A_GAME_MASTER (1/9/2019)

