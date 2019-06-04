package;

import networking.Network;
import networking.utils.NetworkEvent;
import networking.utils.NetworkMode;
import openfl.display.Sprite;

/**
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
  var _ids = 0;

  /**
   * Create the main object container.
   */
  public function new() {
    super();
    run();
  }

  /**
   * Run the application in server mode. This methid will be executed after
   * clicking on the `Server` button.
   */
  private function run() {
    var server = Network.registerSession(NetworkMode.SERVER, {
        ip: '0.0.0.0',
        port: 8888,
        flash_policy_file_port: 9999
    });

    // When a client is connected...
    server.addEventListener(NetworkEvent.CONNECTED, function(event: NetworkEvent) {
      event.client.send(["LOL"]);

    });

    // When recieving a message from a client...
    server.addEventListener(NetworkEvent.MESSAGE_RECEIVED, function(event: NetworkEvent) {
      server.send(event.data);
    });

    server.start();
  }
}
