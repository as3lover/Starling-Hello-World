package {
import flash.display.Sprite;

import starling.core.Starling;
import starling.events.Event;

[SWF(width="400", height="300", frameRate="60", backgroundColor="#808080")]
public class Main extends Sprite {
    private var _starling:Starling;


    public function Main() {
        _starling = new Starling(Game, stage);
        _starling.addEventListener(Event.ROOT_CREATED, onRootCreated);
        _starling.start();
        _starling.showStats = true;

    }

    private function onRootCreated(event:Event, root:Game):void {
        root.start(); // 'start' defined in the 'Game' class
    }
}
}
