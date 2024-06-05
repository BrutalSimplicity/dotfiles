local M = {}
M.icons = {
  breakpoint = "",
  step_in = "󰆹",
  step_out = "󰆸",
  step_over = "",
  continue = "",
  run_to_cursor = "",
  eval = "",
  next_line = "⬿",
  stop = "",
  leave = "󰗼",
  section_break = "┊",
  arrow = "➜",
  bug = "",
}

function M.setup()
  if M.hydra ~= nil then
    return
  end
  local icons = M.icons

  local hint = [[
   DEBUG

  _<F9>_: Breakpoint          ^_<F5>_: Continue
  _<F4>_/_<F6>_: Step In/Out  ^ ^ ^_<F2>_: Run to Cursor
  _<F1>_: Step Over           ^_<F7>_: Eval

  _<C-c><C-c>_: Close Window  ^_<F10>_: Terminate          
]]
  ---@type hydra.Config | { hint: string }
  local opts = {
    name = "Debug",
    hint = hint,
    config = {
      color = "pink",
      desc = "Debug",
      hint = {
        type = "window",
        position = "top-right",
        border = "single",
        offset = 2,
      },
    },
    heads = {
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        { desc = "Toggle Breakpoint" },
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        { desc = "Continue" },
      },
      {
        "<F2>",
        function()
          require("dap").run_to_cursor()
        end,
        { desc = "Run to Cursor" },
      },
      {
        "<F4>",
        function()
          require("dap").step_into()
        end,
        { desc = "Step Into" },
      },
      {
        "<F1>",
        function()
          require("dap").step_over()
        end,
        { desc = "Step Over" },
      },
      {
        "<F6>",
        function()
          require("dap").step_out()
        end,
        { desc = "Step Out" },
      },
      {
        "<F10>",
        function()
          require("dap").terminate()
        end,
        { desc = "Terminate" },
      },
      {
        "<F7>",
        function()
          require("dapui").eval()
        end,
        { mode = { "n", "v" }, desc = "Eval" },
      },
      {
        "<C-c><C-c>",
        nil,
        { exit = true },
      },
    },
  }
  M.hydra = require("hydra")(opts)
end
return M
