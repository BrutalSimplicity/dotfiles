local M = {
  ---@type Hydra
  hydra = nil,
}

function M.close()
  if M.hydra ~= nil then
    M.hydra:exit()
    M.hydra = nil
  end
end

function M.setup()
  -- Window Control Hydra {{{
  local hint = [[
 󰭩 Windows

  _>_/_<_: +/- Width     _s_/_v_:^ ^ ^ ^ Split Horizontal/Vertical    _x_: Swap
  _+_/_-_: +/- Height    _H_/_J_/_K_/_L_: Move L/D/U/R                _=_: Equal Height/Width
  ^ ^ ^ ^                _h_/_j_/_k_/_l_: Navigate L/D/U/R            _w_: Cycle next
  ^ ^ ^ ^                _q_:^ ^ ^ ^ ^ ^ Close Window                 _T_: Open in new tab
]]
  local opts = {
    name = "Window Control",
    hint = hint,
    body = "<leader>ww",
    config = {
      color = "amaranth",
      hint = {
        type = "window",
        border = "rounded",
      },
    },
    heads = {
      { ">", "5<c-w>>" },
      { "<", "5<c-w><" },
      { "+", "2<c-w>+" },
      { "-", "2<c-w>-" },
      { "v", "<c-w>v" },
      { "s", "<c-w>s" },
      { "T", "<c-w>T" },
      { "H", "<c-w>H" },
      { "J", "<c-w>J" },
      { "K", "<c-w>K" },
      { "L", "<c-w>L" },
      { "h", "<c-w>h" },
      { "j", "<c-w>j" },
      { "k", "<c-w>k" },
      { "l", "<c-w>l" },
      { "x", "<c-w>x" },
      { "=", "<c-w>=" },
      { "w", "<c-w>w" },
      { "q", "<c-w>q" },
    },
  }
  M.hydra = require("hydra")(opts)
end
return M
