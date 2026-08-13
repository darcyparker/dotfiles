if vim.g.vscode then
  return {}
end

local markdownlint_config = vim.fn.stdpath("config") .. "/.markdownlint.jsonc"

local markdownlint_config_files = {
  ".markdownlint-cli2.jsonc",
  ".markdownlint-cli2.yaml",
  ".markdownlint-cli2.cjs",
  ".markdownlint-cli2.mjs",
  ".markdownlint.jsonc",
  ".markdownlint.json",
  ".markdownlint.yaml",
  ".markdownlint.yml",
  ".markdownlint.cjs",
  ".markdownlint.mjs",
}

local oxlint_config_files = {
  ".oxlintrc.json",
  ".oxlintrc.jsonc",
  "oxlint.config.ts",
  "oxlint.config.mts",
}

local function dirname(filename)
  if filename and filename ~= "" then
    return vim.fn.fnamemodify(filename, ":p:h")
  end

  local current = vim.api.nvim_buf_get_name(0)
  return current ~= "" and vim.fn.fnamemodify(current, ":p:h") or vim.fn.getcwd()
end

local function find_config(names, filename)
  return vim.fs.find(names, { path = dirname(filename), upward = true, type = "file", limit = 1 })[1]
end

local function path_depth(path)
  local normalized = vim.fs.normalize(path)
  local _, count = normalized:gsub("[/\\]", "")
  return count
end

local function closest_lint_config(filename)
  local markdownlint = find_config(markdownlint_config_files, filename)
  local oxlint = find_config(oxlint_config_files, filename)

  if markdownlint and oxlint then
    local markdownlint_depth = path_depth(vim.fn.fnamemodify(markdownlint, ":h"))
    local oxlint_depth = path_depth(vim.fn.fnamemodify(oxlint, ":h"))
    if oxlint_depth > markdownlint_depth then
      return { name = "oxlint", path = oxlint }
    end
    return { name = "markdownlint", path = markdownlint }
  end

  if oxlint then
    return { name = "oxlint", path = oxlint }
  end

  return { name = "markdownlint", path = markdownlint or markdownlint_config }
end

local function markdownlint_is_active(filename)
  return closest_lint_config(filename).name == "markdownlint"
end

local function active_markdownlint_config(filename)
  local config = closest_lint_config(filename)
  return config.name == "markdownlint" and config.path or markdownlint_config
end

local function has_markdownlint_diagnostics(_, ctx)
  if not markdownlint_is_active(ctx.filename) then
    return false
  end

  local diagnostics = vim.tbl_filter(function(diagnostic)
    return diagnostic.source == "markdownlint"
  end, vim.diagnostic.get(ctx.buf))
  return #diagnostics > 0
end

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = {
        args = {
          "--config",
          function()
            return active_markdownlint_config(vim.api.nvim_buf_get_name(0))
          end,
          "-",
        },
        condition = function(ctx)
          return markdownlint_is_active(ctx.filename)
        end,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters["markdownlint-cli2"] = {
        args = function(_, ctx)
          return { "--config", active_markdownlint_config(ctx.filename), "--fix", "$FILENAME" }
        end,
        condition = has_markdownlint_diagnostics,
      }
    end,
  },
}
