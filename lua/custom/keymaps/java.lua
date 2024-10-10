function _G.run_java()
  local file = vim.fn.expand '%:p'
  local compile_cmd = 'javac ' .. file
  local class_name = vim.fn.expand '%:t:r'

  vim.cmd 'vsplit | terminal' -- Open a terminal in a vertical split
  vim.fn.feedkeys 'i' -- Enter insert mode in the terminal
  vim.cmd('call jobsend(b:terminal_job_id, "' .. compile_cmd .. ' && java ' .. class_name .. '\\n")')
end

function _G.run_gradle()
  local file = vim.fn.expand '%:p'
  local compile_cmd = 'gradle run -q --console=plain'
  local class_name = vim.fn.expand '%:t:r'

  vim.cmd 'vsplit | terminal' -- Open a terminal in a vertical split
  vim.fn.feedkeys 'i' -- Enter insert mode in the terminal
  vim.cmd('call jobsend(b:terminal_job_id, "' .. compile_cmd .. '\\n")')
end
