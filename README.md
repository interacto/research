
# Data for replication

The different folders of this repository contain data related to a research question (RQ).

Note that RQ3 and RQ4 have no data.


# Appendix

## Undo history

The next listing details the algorithm of the standard linear undo mechanism:

```ts
export class UndoHistory {
    /** The undoable objects. */
    private readonly undos: Array<Undoable>;
    /** The redoable objects. */
    private readonly redos: Array<Undoable>;
    /** The maximal number of undo. */
    private sizeMax: number;

    public constructor() {
        this.sizeMax = 0;
        this.undos = [];
        this.redos = [];
        this.sizeMax = 30;
    }

    /** Adds an undoable object to the collector. */
    public add(undoable: Undoable): void {
        if (this.sizeMax > 0) {
            // Cleaning the oldest undoable object
            if (this.undos.length === this.sizeMax) {
                this.undos.shift();
            }
            this.undos.push(undoable);
            // You must clear the redo stack!
            this.clearRedo();
        }
    }

    private clearRedo(): void {
        if (this.redos.length > 0) {
            this.redos.length = 0;
        }
    }

    /** Undoes the last undoable object. */
    public undo(): void {
        const undoable = this.undos.pop();
        if (undoable !== undefined) {
            undoable.undo();
            this.redos.push(undoable);
        }
    }

    /** Redoes the last undoable object. */
    public redo(): void {
        const undoable = this.redos.pop();
        if (undoable !== undefined) {
            undoable.redo();
            this.undos.push(undoable);
        }
    }
}
```

The current linear implementation in Interacto is located here:
https://github.com/interacto/interacto-ts/blob/master/src/impl/undo/UndoHistoryImpl.ts

## Interacto user interactions

## Interacto routines

We detail additional details related to the Interacto API.

***with*: Keyboard Keys.**
Interacto binders that use a keyboard-based user interaction can specify the key codes a user must use.
In the following code, the user interaction of the Interacto binder is *KeysPressure*, a keyboard-based interaction.
The *with* routine specifies the key codes a user must use to produce the UI command (here to produce a *Save* command).
In the example, two key codes are specified: the *control* and *S* key codes.

```java
binder()
  .using(KeysPressure::new)
  .toProduce(d -> new Save(...))
  .on(canvas)
  .with(KeyCode.CONTROL, KeyCode.S)
  .bind();
```

***throttle*: Throttling.**
We design the user interaction throttling feature based on the throttling feature promoted by reactive programming.
In reactive programming, throttling takes as input a duration.
During this duration, only one event (generally the last one) will be emitted.
We adapted this feature for user interactions.
Graphical objects may produce a large number of UI events that user interactions will have to process.
For example with *mouse move*, a graphical object under use will trigger one event on each move of the mouse.
All these events may overload the software.
Our throttling feature also takes as input a duration.
When specified, the user interaction will process the last UI event among all the ones of the same type received during the given duration.
For example, the following Interacto binder uses a DnD interaction and configures this interaction with a throttling value of 30 ms.
If the user moves the mouse 10 times during these 30 ms, the DnD will process the first mouse move and the last mouse move 30 ms after the first one.
If the DnD receives 10 mouse events followed by one mouse release event during less than 30 ms, then the DnD will process the first mouse event, and then the last mouse moves and the mouse release events on receiving this mouse release event.

```java
binder()...
   .using(DnD::new)
   .throttle(30)
   .bind();
```

***strictStart*: Strict Interaction Start.**
When the interaction of an Interacto binding starts, the predicate *when* states whether the Interacto binding can, notably, initialize the command.
One may consider that if this predicate is not respected then the interaction execution must stop.
This is the goal of the *strictStart* routine.
In the following code example, a user can do a DnD on a *canvas* object.
The *when* routine constraints the creation and the execution of the specified *Translate* command (the source X-position of the DnD must be lower than 100).
Since this Interacto binder is configured with *strictStart*, if this predicate is not respected then the interaction execution stops.
This feature permits to stop interaction execution when a *when* predicate will never be *true*.

```java
binder()
   .on(canvas)
   .using(DnD::new)
   .toProduce(d -> new Translate(...))
   .when(d -> d.getSrcPosition().getX() < 100)
   .strictStart()
   .bind();
```

***continuous*: Continuous Command Execution.**
The *continuous* routine specifies that the current UI command will be executed on each update of the interaction execution (if the predicate *when* is respected) instead of being executed at the end of the interaction execution.
This allows users to see the effect of the UI command during the interaction execution.
For example with the following code, the user will see the shape moving while the interaction is running.
Without *continuous*, the user will see the move at the end of the interaction only.
This feature requires the UI command to be undoable:
if the user cancels the interaction (e.g. press the 'ESC' key while doing the drag-lock), then the ongoing UI command must be undone.


```java
binder()
  .using(DragLock::new)
  .toProduce(d -> new Translate(d.getSrcObject().getData())
  .on(canvas.getChildren())
  .when(d -> d.getButton() == MouseButton.SECONDARY)
  .continuous()
  .bind();
```


***consume*: Consume UI events.**
Most of graphical toolkits permit to stop the propagation of a UI event.
In several toolkits, such as JavaFX, this concept is called *consume*.
In a standard case a UI event is successively processed by all its listeners.
When one of such listeners consumes the current event, this stops the propagation of the event to the next listeners.
We reuse this concept for user interactions and Interacto bindings:
When an Interacto binding is configured to *consume* events, its user interaction will consume the UI events it processes.

```java
binder()...
  .consume()
  .bind();
```


***log*: Logging.**
Interacto binding support logging systems at different levels.
In the following code, the Interacto binding will log the user interaction execution.
The other logging levels are:
the *binding level*, that logs information related to the transformation of the interaction execution into UI commands;
the *command level*, that logs information related to the produced UI commands.


```java
binder()...
  .log(LogLevel.INTERACTION)
  .bind();
```
