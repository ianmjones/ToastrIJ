# ToastrIJ
Xojo web control for simple notifications.

ToastrIJ is a [Xojo](https://www.xojo.com) Web SDK Control that wraps the most excellent [**toastr**](https://github.com/CodeSeven/toastr) JavaScript library.

### Simple Notifications
You can create simple notifications that fade away after an interval.

![Simple Notifications](https://raw.githubusercontent.com/ianmjones/ToastrIJ/master/Assets/ToastrIJ%20-%20Simple%20Notifications.png)

### Sticky Notifications & Titles
You can also create sticky notifications that need to be closed, and optionally can add a title.

![Sticky Notifications With Titles](https://raw.githubusercontent.com/ianmjones/ToastrIJ/master/Assets/ToastrIJ%20-%20Stick%20Notifications%20With%20Titles.png)

### Custom WebStyles
Custom WebStyles can also be applied programatically.

![Custom WebStyles](https://raw.githubusercontent.com/ianmjones/ToastrIJ/master/Assets/ToastrIJ%20-%20Custom%20WebStyles.png)

## How To Use
Open the **ToastrIJ** project and copy the `ToastrIJ` folder, or just the `ToastrIJ` control from inside it into your project.

Drag the `ToastrIJ` control onto your page and give it a useful name such as `Toastr`. It'll sit in the page's tray as it can not be positioned on the page.

### Inspector
In the inspector you can change some default **Notification Options**, **Notification Icons** and the **Notification Position** settings. All of these options can also be set programatically.

![ToastrIJ Inspector](https://raw.githubusercontent.com/ianmjones/ToastrIJ/master/Assets/ToastrIJ%20-%20Inspector.png)

#### CloseButton
Whether or not every notification should have a close button, regardless of whether it is a sticky notification or not. Sticky notifications always have a close button.

#### ExtendedTimeOut
How long does rolling the mouse over a notification extend how long it takes before it fades away. Default is 1 second (1,000 miliseconds).

#### NewestOnTop
Should new notifications appear at the top of the stack (default) or bottom.

#### TimeOut
How long until a non-sticky notification fades away. Default is 5 seconds (5,000 miliseconds).

#### ErrorIcon / InfoIcon / SuccessIcon / WarningIcon
Specify a `Picture` to be used in place of the default icon for the respective notification type. For best results icons should be no greater than 24x24px.

#### HorizontalPosition
Can be `Left`, `Center`, `Right` or `Full Width`. Default is `Right`.

#### VerticalPosition
Can be `Top` or `Bottom`. Default is `Top`.

### Displaying a Notification
It's as simple as...

    Toastr.Display("This is a message")

That'll get you the default **Info** type message.

For an **Error** message...

    Toastr.Display("Does not compute!", ToastrIJ.Type.Error)

There are four types:

    ToastrIJ.Type.Info
    ToastrIJ.Type.Success
    ToastrIJ.Type.Warning
    ToastrIJ.Type.Error

There are two signatures for the `Display` method:

    Public Sub Display(Message As String, Type As ToastrIJ.Type = ToastrIJ.Type.Info, Sticky As Boolean = False)
    
    Public Sub Display(Message As String, Type As ToastrIJ.Type = ToastrIJ.Type.Info, Title As String = "", Sticky As Boolean = False)

### Clearing Notifications
If you need to clear all notifications in one fell swoop, use:

    Toastr.Clear

To turn off the fade animation:

    Toastr.Clear(False)

## Demo App
The included demo app can be run to see some of the features.

![ToastrIJ Demo](https://raw.githubusercontent.com/ianmjones/ToastrIJ/master/Assets/ToastrIJ%20Demo.png)

## How To Get
[Download, clone or fork from GitHub](https://github.com/ianmjones/ToastrIJ)

    git clone https://github.com/ianmjones/ToastrIJ.git

## Author
Ian M. Jones  
https://www.ianmjones.com  
mailto:ian@ianmjones.com  

## License
Standard MIT license (a.k.a. do what you like with it except claim it as your own)...

Copyright (c) 2017 Ian M. Jones, Byte Pixie Ltd

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.


## Version History

1.1 2017-03-??

* Added `InfoIcon`, `SuccessIcon`, `WarningIcon` and `ErrorIcon` properties that can be used to set custom icons.
* Added `NewestOnTop` boolean property to enable showing new notifications either at the top of the stack (default) or bottom.

1.0 2017-03-02

* Initial public release.

--- EOF ---