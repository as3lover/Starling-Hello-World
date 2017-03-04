package
{
import com.greensock.TweenLite;

import flash.geom.Point;
import flash.system.System;

import starling.core.Starling;
import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.AssetManager;
import starling.utils.Color;
import starling.utils.MathUtil;
import starling.utils.rad2deg;

public class Game extends Sprite
{
    public static var asset:AssetManager;
    private var quad:Quad;
    private var _progressBar:ProgressBar;
    private var _startPoint:Point;
    private var _degrees:Array = new Array();
    private var _tracedDegree:Boolean = true;
    private var _txt:TextField;
    private var _distanse:int;
    private var _touchNum:int;
    private var _text:String;
    private const RIGHT_UP:String = 'RightUp';
    private const LEFT_UP:String = 'LeftUp';
    private const RIGHT:String = 'Right';
    private const LEFT:String = 'Left';
    private const UP:String = 'Up';
    private const TO_LEFT:String = 'toLeft';
    private const TO_RIGTH:String = 'toRight';
    private var _box:Quad;

    public function Game()
    {
    }

    public function start(scaleFactor:Number):void
    {
        setup(stage.stageWidth, stage.stageHeight);
        stage.addEventListener(Event.RESIZE, onResize);

        var quad:Quad = new Quad(200,200, Color.RED);
        quad.x = 50;
        quad.y = 50;
        addChild(quad);

        _progressBar = new ProgressBar(175, 20);
        _progressBar.x = (stage.stageWidth - _progressBar.width) / 2;
        _progressBar.y =  stage.stageHeight * 0.7;
        addChild(_progressBar);

        asset = new AssetManager();
        //asset.scaleFactor = scaleFactor;
        asset.enqueue(EmpeddedAssets);

        asset.loadQueue(function(ratio:Number):void
        {
            _progressBar.ratio = ratio;
            if (ratio == 1)
            {
                // now would be a good time for a clean-up
                System.pauseForGCIfCollectionImminent(0);
                System.gc();

                onComplete();
            }
        });


    }

    private function onComplete():void {
        addChild(new Image(asset.getTexture("background")));
        stage.addEventListener(TouchEvent.TOUCH, onTouch);

        _txt = new TextField(100,100);
        addChild(_txt);

        _box = new Quad(50,50, Color.RED);
        addChild(_box)
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
            _tracedDegree = false
            _degrees = [];
            _txt.text = '...';
            _distanse = 0;
            _touchNum = 0;
            _startPoint = localPos;
            _box.x = 400;
            _box.y = 400;
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        if(_tracedDegree)
                return;


        touch = event.getTouch(this, TouchPhase.MOVED);
        if (touch)
        {
            localPos = touch.getLocation(this);
            //trace("move: " + localPos);
            _distanse += DistanceTwoPoints(_startPoint,localPos);
             _degrees.push(getAngleFromPoint(_startPoint,localPos));
            _startPoint = localPos;

            if(_degrees.length > 5)
            {
                calcDegree(_degrees);
            }
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
            _degrees.push(getAngleFromPoint(_startPoint,localPos));

            if(_distanse < -30 && _distanse > +30)
                calcDegree(_degrees);
            else if(_touchNum <= 15)
            {
                if(_startPoint)
                {
                    if(_startPoint.x > 400)
                        text=RIGHT_UP;
                    else
                        text=LEFT_UP;
                }
            }


            _tracedDegree = true;
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    private function calcDegree(degs:Array):void
    {
        removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        trace(_distanse)
        var sum:int = 0;
        var len:int = degs.length;
        for (var i:int = 0; i<len; i++)
        {
            sum += degs[i]
        }
        sum /= len;
        calcDirection(sum);
    }

    private function calcDirection(deg:int):void
    {
        var dir:String;

        if(deg <= 22.5)
               dir = RIGHT;
        else if(deg <=45+22.5)
            dir = RIGHT_UP;
        else if(deg <=90+22.5)
            dir = UP;
        else if(deg <=180-22.5)
            dir = LEFT_UP;
        else
            dir = LEFT;

        trace(dir);

        _tracedDegree = true;

        text = dir;
    }

    private function DistanceTwoPoints(p1:Point, p2:Point):Number
    {
        var dx:Number = p1.x-p2.x;
        var dy:Number = p1.y-p2.y;
        return Math.sqrt(dx * dx + dy * dy);
    }

    private function getAngleFromPoint(p1:Point,p2:Point):Number
    {
        return getAngle(p1.x, p1.y, p2.x, p2.y)
    }

    private function getAngle (x1:Number, y1:Number, x2:Number, y2:Number):Number
    {
        var dx:Number = x2 - x1;
        var dy:Number = y2 - y1;
        var angle:Number = rad2deg(Math.atan2(dy,dx));

        if(angle <= 0)
            angle = -angle;
        else if(angle < 90)
            angle = 0;
        else
            angle = 180;
        
        return angle;
    }

    private function onEnterFrame(event:Event, passedTime:Number):void
    {
        _touchNum++;

        if(_startPoint && _touchNum > 15)
        {
            if(_startPoint.x > 400)
                text=TO_RIGTH;
            else
                text=TO_LEFT;
        }
    }

    public function get touchNum():int
    {
        return _touchNum;
    }

    public function set touchNum(value:int):void
    {
        _touchNum = value;
    }

    public function get text():String
    {
        return _text;
    }

    public function set text(value:String):void
    {

        _text = value;
        _txt.text = _text;

        var x:int = _box.x;
        var y:int = _box.y;

        switch (value)
        {
            case UP:
                y -= 300;
                break;

            case LEFT_UP:
                y -= 300;
                x -= 200;
                break;

            case RIGHT_UP:
                y -= 300;
                x += 200;
                break;

            case LEFT:
                x -= 200;
                break;

            case RIGHT:
                x += 200;
                break;

            case TO_LEFT:
                x-=5;
                break;

            case TO_RIGTH:
                x += 5;
                break;
        }

        if(value == TO_LEFT || value == TO_RIGTH)
        {
            _box.x = x;
            _box.y = y;
        }
        else
        {
            _tracedDegree = true;
            TweenLite.to(_box, 1, {x:x, y:y});
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }
}
}