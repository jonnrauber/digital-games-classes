package;

import networking.Network;
import networking.sessions.Session;
import networking.utils.NetworkEvent;
import networking.utils.NetworkMode;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;

/*
 * Simple application to test the networking extension. This simple application will
 * share the position of an display object (bitmap) between two executables: a server and a client.
 *
 * The sprite wrapper objects for bitmaps are to handle click events, which are not supported
 * by Bitmap.
 *
 * Please, read the console (stdout) logs to understand the fired events.
 *
 * @author Daniel Herzog
 */
class Server extends Sprite {
    
    // Create the main object container.
    public function new() {
        super();
        run();
    }

    private function run() {
        // Create the server...
        var server = Network.registerSession(NetworkMode.SERVER, {
            ip: '0.0.0.0',
            port: 8888,
            flash_policy_file_port: 9999
        });

        // When a client is connected...
        server.addEventListener(NetworkEvent.CONNECTED, function(event: NetworkEvent) {
            // Send the current position of the cube.
            event.client.send({ x: 10 });
        });

        // When recieving a message from a client...
        server.addEventListener(NetworkEvent.MESSAGE_RECEIVED, function(event: NetworkEvent) {
            server.send({ x: 12 });
        });

        // ... and run it!
        server.start();
    }
}