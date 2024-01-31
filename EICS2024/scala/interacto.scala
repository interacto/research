package interacto

object Conversions:
  given flatThenData[D1, D2, D3]: Conversion[ThenData[ThenData[D1, D2], D3], ThenData3[D1, D2, D3]] with
    def apply(d: ThenData[ThenData[D1, D2], D3]): ThenData3[D1, D2, D3] = new ThenData3Impl[D1, D2, D3](d.data._1.data._1, d.data._1.data._2, d.data._2)

  given flatThen[I1 <: Interaction[D1], I2 <: Interaction[D2], I3 <: Interaction[D3], D1, D2, D3]: Conversion[Then[Then[I1, I2, D1, D2], I3, ThenData[D1, D2], D3], Then3[I1, I2, I3, D1, D2, D3]] with
    def apply(i: Then[Then[I1, I2, D1, D2], I3, ThenData[D1, D2], D3]): Then3[I1, I2, I3, D1, D2, D3] =
    new Then3(i.i1.i1, i.i1.i2, i.i2)

object Predef:
  class InteractionOps[I1 <: Interaction[D1], D1](x: I1):
    def + [I2 <: Interaction[D2], D2](y: I2): Then[I1, I2, D1, D2] = new Then(x, y)
    def ! [I2 <: Interaction[D2], D2](y: I2): Not[I1, I2, D1, D2] = new Not(x, y)

  implicit def applyOps[I1 <: Interaction[D1], D1](x: I1): InteractionOps[I1, D1] = new InteractionOps(x)


trait Interaction[D]:
  def data: D
  def started: Boolean
  def |[D2](i: Interaction[D2]): Interaction[D | D2]
  //def +[D2](i: Interaction[D2]): Interaction[ThenData[D, D2]]
  def toProduce(fct: (D) => Unit): Interaction[D] = return this
  def on(o: Object): Interaction[D] = return this
  def when(fct: (D) => Boolean): Interaction[D] = return this
  def stopPropagation(): Interaction[D] = return this

enum MouseButton :
  case LEFT, RIGHT, MIDDLE

trait MousePointData:
  def x: Int
  def y: Int
  def button: MouseButton

trait TouchPointData:
  def x: Int
  def y: Int
  def force: Double

trait DnDData[T]:
  def src: T
  def tgt: T

trait KeyData:
  def code: String

trait WidgetData:
  def widget: Object

trait PointsData:
  def points: List[MousePointData]

trait MultiTouchData

trait ThenData[D1, D2]:
  def data: (D1, D2)

class ThenDataImpl[D1, D2](private val d1: D1, private val d2: D2) extends ThenData[D1, D2]:
  def data = (d1, d2)

trait ThenData3[D1, D2, D3]:
  def data: (D1, D2, D3)

class ThenData3Impl[D1, D2, D3](private val d1: D1, private val d2: D2, private val d3: D3) extends ThenData3[D1, D2, D3]:
  def data = (d1, d2, d3)


class KeyDataImpl extends KeyData:
  private var _code: String = ""

  def code = _code

class WidgetDataImpl extends WidgetData:
  private var _w: Object = new Object()

  def widget = _w

class TouchDnDDataImpl extends DnDData[TouchPointData]:
  private var _src: TouchPointData = new TouchPointDataImpl()
  private var _tgt: TouchPointData = new TouchPointDataImpl()

  def src = _src
  def tgt = _tgt

class MouseDnDDataImpl extends DnDData[MousePointData]:
  private var _src: MousePointData = new MousePointDataImpl()
  private var _tgt: MousePointData = new MousePointDataImpl()

  def src = _src
  def tgt = _tgt

class MousePointDataImpl extends MousePointData:
  private var _x: Int = 0
  private var _y: Int = 0
  private var _b: MouseButton = MouseButton.LEFT

  def x = _y
  def y = _y
  def button = _b


class TouchPointDataImpl extends TouchPointData:
  private var _x: Int = 0
  private var _y: Int = 0
  private var _force: Double = 0

  def x = _y
  def y = _y
  def force = _force


class PointsDataImpl extends PointsData:
  private val _pts: List[MousePointData] = List()
  def points: List[MousePointData] = _pts


class MultiTouchDataImpl extends MultiTouchData



trait InteractionBase[D](d: D) extends Interaction[D]:
  protected val _data: D = d

  def data = this._data

  def started = false

  def |[D2](i: Interaction[D2]): Interaction[D | D2] = new Or(this, i)

  //def +[D2](i: Interaction[D2]): Interaction[ThenData[D, D2]] = new Then(this, i)

class Not[I1 <: Interaction[D1], I2 <: Interaction[D2], D1, D2](val i1: I1, val i2: I2)
  extends InteractionBase[D1](i1.data):
  override def started: Boolean = this.i1.started || this.i2.started

class Then [I1 <: Interaction[D1], I2 <: Interaction[D2], D1, D2](val i1: I1, val i2: I2)
  extends InteractionBase[ThenData[D1, D2]](new ThenDataImpl(i1.data, i2.data)):
  override def started: Boolean = this.i1.started || this.i2.started

class Then3 [I1 <: Interaction[D1], I2 <: Interaction[D2], I3 <: Interaction[D3], D1, D2, D3](val i1: I1, val i2: I2, private val i3: I3)
  extends InteractionBase[ThenData3[D1, D2, D3]](new ThenData3Impl(i1.data, i2.data, i3.data)):
  override def started: Boolean = this.i1.started || this.i2.started || this.i3.started


class Or[I1 <: Interaction[D1], I2 <: Interaction[D2], D1, D2](val i1: I1, val i2: I2) extends Interaction[D1 | D2]:
  def data: D1 | D2 = if (this.i1.started) this.i1.data else this.i2.data

  def started: Boolean = this.i1.started || this.i2.started

  def |[D3](i: Interaction[D3]): Interaction[D1 | D2 | D3] = new Or(this, i)

  //def +[D3](i: Interaction[D3]): Interaction[ThenData[D1 | D2, D3]] = new Then(this, i)


class Click extends InteractionBase[MousePointData](new MousePointDataImpl())
class Tap extends InteractionBase[TouchPointData](new TouchPointDataImpl())
class Drag extends InteractionBase[PointsData](new PointsDataImpl())
class KeyTyped(val code: String) extends InteractionBase[KeyData](new KeyDataImpl())
class LongTap(val duration: Int) extends InteractionBase[TouchPointData](new TouchPointDataImpl())
class TouchDnD() extends InteractionBase[DnDData[TouchPointData]](new TouchDnDDataImpl())
class MouseDnD() extends InteractionBase[DnDData[MousePointData]](new MouseDnDDataImpl())
class ReciprocalDnD() extends InteractionBase[DnDData[MousePointData]](new MouseDnDDataImpl())
class Swipe() extends InteractionBase[MultiTouchData](new MultiTouchDataImpl())
class ButtonPressed() extends InteractionBase[WidgetData](new WidgetDataImpl())

