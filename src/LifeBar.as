/**
 * Created by SalmanPC3 on 3/1/2017.
 */
package {
import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.Color;

public class LifeBar extends Sprite{
    public function LifeBar(width:Number) {
        var quad:Quad = new Quad(width, 20, Color.YELLOW);
        addChild(quad);
    }
}
}
