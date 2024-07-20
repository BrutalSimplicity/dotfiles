local function content_match(matchers)
  return function(path, bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    if #lines == 0 then
      return
    end
    for _, m in ipairs(matchers) do
      local res = m(path, lines)
      if res ~= nil then
        return res
      end
    end
  end
end
local function match_cloudformation(_, lines)
  local line1 = lines[1] or ""
  local line2 = lines[2] or ""
  if
    vim.regex([[^AWSTemplateFormatVersion]]):match_str(line1)
    or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line1)
  then
    return "yaml.cloudformation"
  elseif
    vim.regex([[["']AWSTemplateFormatVersion]]):match_str(line1)
    or vim.regex([[["']AWSTemplateFormatVersion]]):match_str(line2)
    or vim.regex([[["']AWSTemplateFormatVersion]]):match_str(line1)
    or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line2)
  then
    return "json.cloudformation"
  end
end
-- local function match_gotmpl(_, lines)
--   for _, line in lines do
--     if string.match(line, "{{%..*}}") ~= nil then
--
--     end
--   end
-- end
vim.filetype.add({
  extension = {
    gmpl = "gotmpl",
    gomplate = "gotmpl",
  },
  pattern = {
    [".*"] = {
      content_match({
        match_cloudformation,
      }),
      { priority = math.huge },
    },
    -- [".*%.yaml"] = {
    --   match_cloudformation,
    --   { priority = math.huge },
    -- },
    -- [".*%.yml"] = {
    --   match_cloudformation,
    --   { priority = math.huge },
    -- },
    -- [".*%.json"] = {
    --   match_cloudformation,
    --   { priority = math.huge },
    -- },
  },
})
