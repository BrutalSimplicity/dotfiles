---@meta hs.dialog.color
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- A panel that allows users to select a color.
---@class hs.dialog.color
local M = {}
hs.dialog.color = M

-- Set or display the selected opacity.
--
-- Parameters:
--  * [value] - A opacity value as a number between 0 and 1, where 0 is 100% transparent/see-through.
--
-- Returns:
--  * The current alpha value as a number.
--
-- Notes:
--  * Example:
--      `hs.dialog.color.alpha(0.5)`
---@return number
function M.alpha(value, ...) end
-- Sets or removes the callback function for the color panel.
--
-- Parameters:
--  * a function, or `nil` to remove the current function, which will be invoked as a callback for messages generated by this color panel. The callback function should expect 2 arguments as follows:
--    ** A table containing the color values from the color panel.
--    ** A boolean which returns `true` if the color panel has been closed otherwise `false` indicating that the color panel is still open (i.e. it may change color again).
--
-- Returns:
--  * The last callbackFn or `nil` so you can save it and re-attach it if something needs to temporarily take the callbacks.
--
-- Notes:
--  * Example:
--      `hs.dialog.color.callback(function(a,b) print("COLOR CALLBACK:\nSelected Color: " .. hs.inspect(a) .. "\nPanel Closed: " .. hs.inspect(b)) end)`
function M.callback(callbackFn, ...) end
-- Set or display the currently selected color in a color wheel.
--
-- Parameters:
--  * [value] - The color values in a table (as described in `hs.drawing.color`).
--
-- Returns:
--  * A table of the currently selected color in the form of `hs.drawing.color`.
--
-- Notes:
--  * Example:
--      `hs.dialog.color.color(hs.drawing.color.blue)`
function M.color(value, ...) end
-- Set or display whether or not the callback should be continuously updated when a user drags a color slider or control.
--
-- Parameters:
--  * [value] - `true` if you want to continuously trigger the callback, otherwise `false`.
--
-- Returns:
--  * `true` if continuous is enabled otherwise `false`
--
-- Notes:
--  * Example:
--      `hs.dialog.color.continuous(true)`
---@return boolean
function M.continuous(value, ...) end
-- Hides the Color Panel.
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
--
-- Notes:
--  * Example:
--      `hs.dialog.color.hide()`
function M.hide() end
-- Set or display the currently selected color panel mode.
--
-- Parameters:
--  * [value] - The mode you wish to use as a string from the following options:
--    ** "wheel" - Color Wheel
--    ** "gray" - Gray Scale Slider
--    ** "RGB" - RGB Sliders
--    ** "CMYK" - CMYK Sliders
--    ** "HSB" - HSB Sliders
--    ** "list" - Color Palettes
--    ** "custom" - Image Palettes
--    ** "crayon" - Pencils
--    ** "none"
--
-- Returns:
--  * The current mode as a string.
--
-- Notes:
--  * Example:
--      `hs.dialog.color.mode("RGB")`
function M.mode(value, ...) end
-- Shows the Color Panel.
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
--
-- Notes:
--  * Example:
--      `hs.dialog.color.show()`
function M.show() end
-- Set or display whether or not the color panel should display an opacity slider.
--
-- Parameters:
--  * [value] - `true` if you want to display an opacity slider, otherwise `false`.
--
-- Returns:
--  * `true` if the opacity slider is displayed otherwise `false`
--
-- Notes:
--  * Example:
--      `hs.dialog.color.showsAlpha(true)`
---@return boolean
function M.showsAlpha(value, ...) end


return M
