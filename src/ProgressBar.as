/**
 * Created by SalmanPC3 on 3/1/2017.
 */
package {
import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.Color;

public class ProgressBar extends Sprite{
    private var quad:Quad;

    public function ProgressBar(width:int, height:int) {
        quad = new Quad(width,height, Color.RED);
        addChild(quad);

        quad = new Quad(width,height, Color.BLUE);
        addChild(quad);
    }

    public function set ratio(ratio:Number):void {
        quad.scaleX = ratio;
    }
}
}
