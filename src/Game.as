package
{
import flash.geom.Point;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.Color;

public class Game extends Sprite
{
    public function Game()
    {
        var quad:Quad = new Quad(200, 200, Color.RED);
        quad.x = 100;
        quad.y = 50;
        addChild(quad);
    }

    public function start():void
    {
        trace('started');
        this.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function onTouch(event:TouchEvent):void
    {

        var localPos:Point

        var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
        if (touch)
        {
            localPos = touch.getLocation(this);
            trace('---------------');
            trace("start: " + localPos);
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        touch = event.getTouch(this, TouchPhase.MOVED);
        if (touch)
        {
            localPos = touch.getLocation(this);
            trace("move: " + localPos);
        }

        touch = event.getTouch(this, TouchPhase.STATIONARY);
        if (touch)
        {
            localPos = touch.getLocation(this);
            trace("\t pause at: " + localPos);
        }

        touch = event.getTouch(this, TouchPhase.ENDED);
        if (touch)
        {
            localPos = touch.getLocation(this);
            trace("end: " + localPos);
            trace('---------------');
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    private function onEnterFrame(event:Event, passedTime:Number):void
    {
        trace("Time passed since last frame: " + passedTime);
    }

}
}