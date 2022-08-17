const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require('./models/room.js');
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require("socket.io")(server);
// middle ware
app.use(express.json());

const password = encodeURIComponent("kY3FSj.:u5d.XVa");
const DB = `mongodb+srv://Mustafa:${password}@cluster0.lqguv.mongodb.net/?retryWrites=true&w=majority`;

io.on("connection", (socket) => {
  console.log("connected!");

  socket.on("createRoom",async ({ nickname })=>{
      try{
          let room = new Room();

              let player = {
                  socketID : socket.id,
                  nickname,
                  playerType : 'X',
              };

              room.players.push(player);
              console.log(room);
              room.turn = player;
              await room.save();

              const roomId = room._id.toString();
              console.log(roomId);

              io.to(roomId).emit("updatePlayers", room.players);
              socket.join(roomId);
              io.to(roomId).emit('createRoomSuccess' , room);

      }catch(e){
          console.log(e);
      }
    });
    socket.on("createRoom4",async ({ nickname })=>{
            try{
                let room = new Room();

                    let player = {
                        socketID : socket.id,
                        nickname,
                        playerType : 'X',
                    };

                    room.players.push(player);
                    console.log(room);
                    room.turn = player;
                    await room.save();

                    const roomId = room._id.toString();
                    console.log(roomId);

                    io.to(roomId).emit("updatePlayers4", room.players);
                    socket.join(roomId);
                    io.to(roomId).emit('createRoomSuccess4' , room);

            }catch(e){
                console.log(e);
            }
          });





          socket.on("createRoom5",async ({ nickname })=>{
                  try{
                      let room = new Room();

                          let player = {
                              socketID : socket.id,
                              nickname,
                              playerType : 'X',
                          };

                          room.players.push(player);
                          console.log(room);
                          room.turn = player;
                          await room.save();

                          const roomId = room._id.toString();
                          console.log(roomId);

                          io.to(roomId).emit("updatePlayers5", room.players);
                          socket.join(roomId);
                          io.to(roomId).emit('createRoomSuccess5' , room);

                  }catch(e){
                      console.log(e);
                  }
                });

  socket.on('joinRoom',async({nickname,roomId})=>{
      try{
          if(!roomId.match(/^[0-9a-fA-F]{24}$/)){
              socket.emit("errorOcurred","Please enter a valid room ID.");
              return;
          }
          let room = await Room.findById(roomId);
          if(room.isJoin){
              let player = {
                  nickname,
                  socketID: socket.id,
                  playerType: 'O'
              }
              socket.join(roomId);
              room.players.push(player);
              room = await room.save();
              console.log(room);
              io.to(roomId).emit('joinRoomSuccess' , room);
              io.to(roomId).emit("updatePlayers", room.players);
              io.to(roomId).emit("updateRoom", room);
          } else{
          socket.emit(
          "errorOccurred",
          "The game is in progress, try again later."
          );
          }
      }catch(e){
          console.log(e);
      }
    });

    socket.on('joinRoom4',async({nickname,roomId})=>{
            try{
                if(!roomId.match(/^[0-9a-fA-F]{24}$/)){
                    socket.emit("errorOcurred","Please enter a valid room ID.");
                    return;
                }
                let room = await Room.findById(roomId);
                if(room.isJoin){
                    let player = {
                        nickname,
                        socketID: socket.id,
                        playerType: 'O'
                    }
                    socket.join(roomId);
                    room.players.push(player);
                    room = await room.save();
                    console.log(room);
                    io.to(roomId).emit('joinRoomSuccess4' , room);
                    io.to(roomId).emit("updatePlayers4", room.players);
                    io.to(roomId).emit("updateRoom4", room);
                } else{
                socket.emit(
                "errorOccurred",
                "The game is in progress, try again later."
                );
                }
            }catch(e){
                console.log(e);
            }
          });


          socket.on('joinRoom5',async({nickname,roomId})=>{
                  try{
                      if(!roomId.match(/^[0-9a-fA-F]{24}$/)){
                          socket.emit("errorOcurred","Please enter a valid room ID.");
                          return;
                      }
                      let room = await Room.findById(roomId);
                      if(room.isJoin){
                          let player = {
                              nickname,
                              socketID: socket.id,
                              playerType: 'O'
                          }
                          socket.join(roomId);
                          room.players.push(player);
                          room = await room.save();
                          console.log(room);
                          io.to(roomId).emit('joinRoomSuccess5' , room);
                          io.to(roomId).emit("updatePlayers5", room.players);
                          io.to(roomId).emit("updateRoom5", room);
                      } else{
                      socket.emit(
                      "errorOccurred",
                      "The game is in progress, try again later."
                      );
                      }
                  }catch(e){
                      console.log(e);
                  }
                });

  socket.on("tap", async ({ index, roomId }) => {
            try {
              let room = await Room.findById(roomId);
              console.log(room);
              let choice = room.turn.playerType;
               console.log(choice);// x or o
              if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;
              } else {
                room.turn = room.players[0];
                room.turnIndex = 0;
              }
              room = await room.save();
              io.to(roomId).emit("tapped", {
                index,
                choice,
                room,
              });
            } catch (e) {
              console.log(e);
            }
    });

    socket.on("tap4", async ({ index, roomId }) => {
              try {
                let room = await Room.findById(roomId);
                console.log(room);
                let choice = room.turn.playerType;
                 console.log(choice);// x or o
                if (room.turnIndex == 0) {
                  room.turn = room.players[1];
                  room.turnIndex = 1;
                } else {
                  room.turn = room.players[0];
                  room.turnIndex = 0;
                }
                room = await room.save();
                io.to(roomId).emit("tapped4", {
                  index,
                  choice,
                  room,
                });
              } catch (e) {
                console.log(e);
              }
  });

  socket.on("tap5", async ({ index, roomId }) => {
            try {
              let room = await Room.findById(roomId);
              console.log(room);
              let choice = room.turn.playerType;
               console.log(choice);// x or o
              if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;
              } else {
                room.turn = room.players[0];
                room.turnIndex = 0;
              }
              room = await room.save();
              io.to(roomId).emit("tapped5", {
                index,
                choice,
                room,
              });
            } catch (e) {
              console.log(e);
            }
  });




      socket.on("winner", async ({ winnerSocketId, roomId }) => {
          try {
            let room = await Room.findById(roomId);
            let player = room.players.find(
              (player) => player.socketID == winnerSocketId
            );
            player.points += 1;
            room = await room.save();

            if (player.points >= room.maxRounds) {
              io.to(roomId).emit("endGame", player);
            } else {
              io.to(roomId).emit("pointIncrease", player);
            }
          } catch (e) {
            console.log(e);
          }
        });
      });


mongoose.connect(DB).then(()=>{
    console.log('connected to db');
}).catch((e)=>{
    console.log(e);
});
server.listen(port , '0.0.0.0' ,()=>{
       console.log(`server is working on port ${port}`);
});
