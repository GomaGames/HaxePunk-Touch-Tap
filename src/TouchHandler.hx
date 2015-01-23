import haxe.ds.IntMap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;

/*
  
  Scene will instantiate this, and call it's update() method
  
 */
class TouchHandler
{
  
  // store all touches here
  private var touches:IntMap<Touch>;

  private var scene:MainScene;

  public function new( scene:MainScene )
  {
    this.scene = scene;
    this.touches = new IntMap<Touch>();
  }

  /*
    React to and store touch inputs (for multitouch capability)
    http://haxepunk.com/documentation/api/com/haxepunk/utils/Input.html
   */
  public function update()
  {

    if (Input.multiTouchSupported){

      // http://haxepunk.com/documentation/api/com/haxepunk/utils/Input.html#touchPoints
      Input.touchPoints(handleTouch);

      // check for any released touches
      for(touch in touches){

        // http://haxepunk.com/documentation/api/com/haxepunk/utils/Input.html#touches
        if(Input.touches[touch.id] == null){
          touchRelease(touch);
        }
      }

    }

  }

  private inline function handleTouch( touch:Touch )
  {
    if(!touches.exists(touch.id)){
      touches.set(touch.id, touch);
      scene.handleInputDown(touch.x, touch.y);
    }
  }

  private inline function touchRelease(touch:Touch)
  {
    scene.handleInputUp(touch.x, touch.y);
    
    touches.remove(touch.id);
  }

}