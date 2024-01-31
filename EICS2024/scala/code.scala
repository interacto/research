import interacto._
import Predef._
import Conversions.flatThen
import Conversions.flatThenData


class MoveShape(val obj: Object, val parent: Object)
class DeleteAll()

def usesLeftButton(o: MousePointData | TouchPointData): Boolean =
  o match { case m: MousePointData => m.button == MouseButton.LEFT; case default => true }

@main def entryPoint() =
  val canvas = new Object()
  val delete = new Object()
  val i1: Interaction[DnDData[MousePointData]] = new MouseDnD() ! new KeyTyped("ESC")
  val i1b: Interaction[DnDData[MousePointData]] = new ReciprocalDnD()
  val i2: Interaction[DnDData[TouchPointData]] = new TouchDnD()
  val i3: Interaction[ThenData[TouchPointData, TouchPointData]] = new LongTap(2000) + new Tap()
  val dnd = i1 | i2

  dnd.on(canvas)
    .toProduce(data => new MoveShape(data.src, canvas))
    .when((data: DnDData[MousePointData] | DnDData[TouchPointData]) => usesLeftButton(data.tgt))


  val i = new Swipe() | new ButtonPressed()

  i
   .on(delete, canvas)
   .toProduce((data: MultiTouchData | WidgetData) => new DeleteAll())


// ~/.local/share/coursier/bin/scalac -explain -feature -language:implicitConversions interacto.scala code.scala -d out
// ~/.local/share/coursier/bin/scala -explain -feature -language:implicitConversions interacto.scala code.scala -d out

