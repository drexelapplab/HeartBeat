// Run the Socket.IO server on port 3333
var port = 3333;

// Initialize the color counter at 0
var counter = 0;

// Create the Socket.IO server and tell it to listen on the port declared above.
var socketServer = require('socket.io').listen(port);

// Create a new namespace on the socketServer for iOS connections.
var iOS = socketServer.of('/ios');

function updateDevices() 
{
   // Check to see if the count is greater than 3 - if so, reset it to 0.
   if(counter > 3)
   {
        counter = 0;
   }
   
   // Send an "updateColor" message with the current counter
   // to all connections on the iOS namespace.
   iOS.emit('updateColor', counter);

   // Increase the counter by 1
   counter++;
}

// Call the updateDevices function every 1000ms
setInterval(updateDevices, 1000);
