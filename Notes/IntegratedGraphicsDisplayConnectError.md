__Keywords__: Multiple Displays; Integrated Graphics; Driver; Thunderbolt; Settings; Issue; Connectivity; Solved

Upon starting the Windows 10 PC from certain power states, it is observed that dispalys that are driven though a physical thunderbolt 4 port would fail to connect.

Dislay configuration;

Display 1 is a 1920x1080 portable display connected to the PC though a thunderbolt 5 port (running thunderbolt 4) on the motherboard. It is connected to CPU integrated graphics

Display 2 is a 3840x2160 display connected to the discrete graphics device

The following issue applies to Display 1:

- Display protocol could be DP, or some non-standard protocol over downward compatability mode in usb 3
- In the system, usb device plugged in system sound is audiable, but would quickly disconnect, and the display would go to sleep

This connection error can be solved by having the Windows __Settings->System->Display__ settings page open and in-focus _before_ turning on Display 1