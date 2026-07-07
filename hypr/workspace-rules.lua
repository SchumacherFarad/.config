for i = 1, 5 do
  hl.workspace_rule({
    workspace = string.format("%d", i),
    persistent = true,
  })
end
