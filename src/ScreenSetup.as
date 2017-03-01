package {
import flash.geom.Rectangle;
import flash.system.Capabilities;

public class ScreenSetup {
    private var _stageWidth:Number;
    private var _stageHeight:Number;
    private var _viewPort:Rectangle;
    private var _scale:Number;
    private var _assetScale:Number;

    public function ScreenSetup(fullScreenWidth:uint, fullScreenHeight:uint,
                                assetScales:Array = null, screenDPI:Number = -1)
    {
        if (screenDPI <= 0) screenDPI = Capabilities.screenDPI;
        if (assetScales == null || assetScales.length == 0) assetScales = [1];

        var iPad:Boolean = Capabilities.os.indexOf("iPad") != -1;
        var baseDPI:Number = iPad ? 130 : 160;
        var exactScale:Number = screenDPI / baseDPI;

        if (exactScale < 1.25) _scale = 1.0;
        else if (exactScale < 1.75) _scale = 1.5;
        else _scale = Math.round(exactScale);

        _stageWidth = int(fullScreenWidth / _scale);
        _stageHeight = int(fullScreenHeight / _scale);

        assetScales.sort(Array.NUMERIC | Array.DESCENDING);
        _assetScale = assetScales[0];

        for (var i:int = 0; i < assetScales.length; ++i)
            if (assetScales[i] >= _scale) _assetScale = assetScales[i];

        _viewPort = new Rectangle(0, 0, _stageWidth * _scale, _stageHeight * _scale);
    }

    public function get stageWidth():Number {
        return _stageWidth;
    }

    public function get stageHeight():Number {
        return _stageHeight;
    }

    public function get viewPort():Rectangle {
        return _viewPort;
    }

    public function get scale():Number {
        return _scale;
    }

    public function get assetScale():Number {
        return _assetScale;
    }
}
}