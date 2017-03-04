package {
import flash.display.Sprite;

import starling.core.Starling;
import starling.events.Event;

[SWF(width="800", height="450", frameRate="60", backgroundColor="#808080")]
public class Main extends Sprite {

    private var _starling:Starling;
    public var screen:ScreenSetup;
    public function Main() {
        screen = new ScreenSetup(
                stage.fullScreenWidth, stage.fullScreenHeight, [1, 2]);

        _starling = new Starling(Game, stage, screen.viewPort);
        _starling.stage.stageWidth = screen.stageWidth;
        _starling.stage.stageHeight = screen.stageHeight;
        _starling.showStats = true;
        _starling.start();
        _starling.addEventListener(Event.ROOT_CREATED, onRootCreated);
    }

    //master

    private function onRootCreated(event:Event, root:Game):void
    {
        root.start(screen.assetScale); // 'start' defined in the 'Game' class
    }
}
}
