---@meta hs.alert
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Simple on-screen alerts
---@class hs.alert
local M = {}
hs.alert = M

-- Closes all alerts currently open on the screen
--
-- Parameters:
--  * seconds - Optional number specifying the fade out duration. Defaults to `fadeOutDuration` value currently defined in the [hs.alert.defaultStyle](#defaultStyle)
--
-- Returns:
--  * None
function M.closeAll(seconds, ...) end
-- Closes the alert with the specified identifier
--
-- Parameters:
--  * uuid    - the identifier of the alert to close
--  * seconds - Optional number specifying the fade out duration. Defaults to `fadeOutDuration` value currently defined in the [hs.alert.defaultStyle](#defaultStyle)
--
-- Returns:
--  * None
--
-- Notes:
--  * Use this function to close an alert which is indefinite or close an alert with a long duration early.
function M.closeSpecific(uuid, seconds, ...) end
-- A table defining the default visual style for the alerts generated by this module.
--
-- The following may be specified in this table (any other key is ignored):
--  * Keys which affect the alert rectangle:
--    * fillColor   - a table as defined by the `hs.drawing.color` module to specify the background color for the alert, defaults to { white = 0, alpha = 0.75 }.
--    * strokeColor - a table as defined by the `hs.drawing.color` module to specify the outline color for the alert, defaults to { white = 1, alpha = 1 }.
--    * strokeWidth - a number specifying the width of the outline for the alert, defaults to 2
--    * radius      - a number specifying the radius used for the rounded corners of the alert box, defaults to 27
--
--  * Keys which affect the text of the alert when the message is a string (note that these keys will be ignored if the message being displayed is already an `hs.styledtext` object):
--    * textColor   - a table as defined by the `hs.drawing.color` module to specify the message text color for the alert, defaults to { white = 1, alpha = 1 }.
--    * textFont    - a string specifying the font to be used for the alert text, defaults to ".AppleSystemUIFont" which is a symbolic name representing the systems default user interface font.
--    * textSize    - a number specifying the font size to be used for the alert text, defaults to 27.
--    * textStyle   - an optional table, defaults to `nil`, specifying that a string message should be converted to an `hs.styledtext` object using the style elements specified in this table.  This table should conform to the key-value pairs as described in the documentation for the `hs.styledtext` module.  If this table does not contain a `font` key-value pair, one will be constructed from the `textFont` and `textSize` keys (or their defaults); likewise, if this table does not contain a `color` key-value pair, one will be constructed from the `textColor` key (or its default).
--    * padding     - the number of pixels to reserve around each side of the text and/or image, defaults to textSize/2
--    * atScreenEdge   - 0: screen center (default); 1: top edge; 2: bottom edge . Note when atScreenEdge>0, the latest alert will overlay above the previous ones if multiple alerts visible on same edge; and when atScreenEdge=0, latest alert will show below previous visible ones without overlap.
--    * fadeInDuration  - a number in seconds specifying the fade in duration of the alert, defaults to 0.15
--    * fadeOutDuration - a number in seconds specifying the fade out duration of the alert, defaults to 0.15
--
-- If you modify these values directly, it will affect all future alerts generated by this module.  To adjust one of these properties for a single alert, use the optional `style` argument to the [hs.alert.show](#show) function.
---@type table
M.defaultStyle = {}
-- Shows a message in large words briefly in the middle of the screen; does tostring() on its argument for convenience.
--
-- Parameters:
--  * str     - The string or `hs.styledtext` object to display in the alert
--  * style   - an optional table containing one or more of the keys specified in [hs.alert.defaultStyle](#defaultStyle).  If `str` is already an `hs.styledtext` object, this argument is ignored.
--  * screen  - an optional `hs.screen` userdata object specifying the screen (monitor) to display the alert on.  Defaults to `hs.screen.mainScreen()` which corresponds to the screen with the currently focused window.
--  * seconds - The number of seconds to display the alert. Defaults to 2.  If seconds is specified and is not a number, displays the alert indefinitely.
--
-- Returns:
--  * a string identifier for the alert.
--
-- Notes:
--  * For convenience, you can call this function as `hs.alert(...)`
--  * This function effectively calls `hs.alert.showWithImage(msg, nil, ...)`. As such, all the same rules apply regarding argument processing
function M.show(str, style, screen, seconds, ...) end
-- Shows an image and a message in large words briefly in the middle of the screen; does tostring() on its argument for convenience.
--
-- Parameters:
--  * str     - The string or `hs.styledtext` object to display in the alert
--  * image   - The image to display in the alert
--  * style   - an optional table containing one or more of the keys specified in [hs.alert.defaultStyle](#defaultStyle).  If `str` is already an `hs.styledtext` object, this argument is ignored.
--  * screen  - an optional `hs.screen` userdata object specifying the screen (monitor) to display the alert on.  Defaults to `hs.screen.mainScreen()` which corresponds to the screen with the currently focused window.
--  * seconds - The number of seconds to display the alert. Defaults to 2.  If seconds is specified and is not a number, displays the alert indefinitely.
--
-- Returns:
--  * a string identifier for the alert.
--
-- Notes:
--  * The optional parameters are parsed in the order presented as follows:
--    * if the argument is a table and `style` has not previously been set, then the table is assigned to `style`
--    * if the argument is a userdata and `screen` has not previously been set, then the userdata is assigned to `screen`
--    * if `duration` has not been set, then it is assigned the value of the argument
--    * if all of these conditions fail for a given argument, then an error is returned
--  * The reason for this logic is to support the creation of persistent alerts as was previously handled by the module: If you specify a non-number value for `seconds` you will need to store the string identifier returned by this function so that you can close it manually with `hs.alert.closeSpecific` when the alert should be removed.
--  * Any style element which is not specified in the `style` argument table will use the value currently defined in the [hs.alert.defaultStyle](#defaultStyle) table.
function M.showWithImage(str, image, style, screen, seconds, ...) end


return M
