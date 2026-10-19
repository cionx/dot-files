require("luasnip")

local function basic_env(snip_trigger, snip_desc, env_name, env_content_desc)
  return
  s(
    { trig = snip_trigger, desc = snip_desc },
    fmta(
      [[
        \begin{<name>}
        <indent><content>
        \end{<name>}
        <afterwards>
      ]],
      {
        name = t(env_name),
        indent = t("\t"),
        content = i(1, env_content_desc),
        afterwards = i(0),
      }
    )
  )
end

local generic_env =
s(
  { trig = "begin", desc = "\\begin{} \\end{}" },
  fmta(
    [[
      \begin{<name>}
      <indent><contents>
      \end{<name>}
      <afterwards>
    ]],
    {
      name = i(1, "name"),
      indent = t("\t"),
      contents = i(2, "contents"),
      afterwards = i(0),
    },
    {
      repeat_duplicates = true
    }
  )
)

local equation_env =
s(
  { trig = "equation", desc = "\\[ \\] environment" },
  fmta(
    [[
      \[
      <indent><content>
      \]
      <afterwards>
    ]],
    {
      indent = t("\t"),
      content = i(1, "mathematics"),
      afterwards = i(0),
    }
  )
)

local tikz_cd_env = 
s(
  { trig = "tikzcd", desc = "TikZ-cd environment" },
  fmta(
    [[
      \[
      <indent>\begin{tikzcd}
      <indent><indent><content>
      <indent>\end{tizkcd}
      \]
      <afterwards>
    ]],
    {
      indent = t("\t"),
      content = i(1, "diagram"),
      afterwards = i(0),
    }
  )
)

return
{
  -- Generic environment.
  generic_env,

  -- Text environments.
  basic_env("convention",  "convention environment",  "convention",  "text"),
  basic_env("corollary",   "corollary environment",   "corollary",   "text"),
  basic_env("definition",  "definition environment",  "definition",  "text"),
  basic_env("example",     "example environment",     "example",     "text"),
  basic_env("fluff",       "fluff environment",       "fluff",       "text"),
  basic_env("lemma",       "lemma environment",       "lemma",       "text"),
  basic_env("notation",    "notation environment",    "notation",    "text"),
  basic_env("proof",       "proof environment",       "proof",       "text"),
  basic_env("proposition", "proposition environment", "proposition", "text"),
  basic_env("recall",      "recall environment",      "recall",      "text"),
  basic_env("remark",      "remark environment",      "remark",      "text"),
  basic_env("theorem",     "theorem environment",     "theorem",     "text"),
  basic_env("warning",     "warning environment",     "warning",     "text"),

  -- Math environments.
  basic_env("align",  "align environment",  "align*",  "first line"),
  basic_env("cases",  "cases environment",  "cases*",  "first case"),
  equation_env,
  basic_env("gather", "gather environment", "gather*", "first line"),
  tikz_cd_env,

  -- Matrices.
  basic_env("matrix",  "matrix environment",   "matrix",  "entries"),
  basic_env("bmatrix", "[matrix] environment", "bmatrix", "entries"),
  basic_env("pmatrix", "(matrix) environment", "pmatrix", "entries"),
}
