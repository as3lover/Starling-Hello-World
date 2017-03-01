package
{
import flash.geom.Point;

import starling.core.Starling;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.Color;

public class Game extends Sprite
{
    private var quad:Quad

    public function Game()
    {
    }

    public function start():void
    {
        setup(stage.stageWidth, stage.stageHeight);
        stage.addEventListener(Event.RESIZE, onResize);

        var quad:Quad = new Quad(200,200, Color.RED);
        quad.x = 50;
        quad.y = 50;
        addChild(quad);
    }

    private function setup(width:Number, height:Number):void
    {
        trace(width, height);
        trace(stage.stageWidth, stage.stageHeight);
        trace(Starling.current.viewPort.width , Starling.current.viewPort.height)
        trace('========================')

        if(quad)
            quad.removeFromParent(true)
        quad = new Quad(width-10, height-10, Color.YELLOW);
        quad.x = 5;
        quad.y = 5;
        addChildAt(quad,0);
    }

    private function onResize(event:ResizeEvent):void
    {
        updateViewPort(event.width, event.height);
        //setup(event.width, event.height);
        setup(stage.stageWidth, stage.stageHeight);
    }

    private function updateViewPort(width:int, height:int):void
    {
        var current:Starling = Starling.current;
        var scale:Number = current.contentScaleFactor;

        stage.stageWidth  = width  / scale;
        stage.stageHeight = height / scale;

        current.viewPort.width  = stage.stageWidth  * scale;
        current.viewPort.height = stage.stageHeight * scale;
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