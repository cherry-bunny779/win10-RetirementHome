__Keywords__: Multiple Displays; Integrated Graphics; Driver; Issue; System UI; Remote Desktop; Unresolved

Following [this issue](IntegratedGraphicsDisplayConnectError.md), disabling the integrated graphics device will result in Desktop Icons being garbled; dissaranged and some icons even dissapearing/off screen. Semi-transparent UI elements will also render incorrectly (e.g. semi-transparent dark elemets will appear black)

To fix this:
- renable the integrated graphics driver, icons will be reverted without issue
- restart the PC and login

Interestingly, during the restart boot process only the display connected to the MB/Integrated graphics will be on, but will freeze with the MB manufacturor logo after the discrete graphics display is showing the Windows login page. It will stay like this even after logging in

There is a small chance that the system would freeze after logging in to the host PC after reenabling the integrated device during a Remote Desktop Session