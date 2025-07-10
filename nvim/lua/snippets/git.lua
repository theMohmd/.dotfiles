local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

ls.add_snippets("gitcommit", {
  -- Basic conventional commits
  s("feat", { t("feat: "), i(1, "implement "), i(0) }),
  s("fix", { t("fix: "), i(1, "resolve issue with ") }),
  s("docs", { t("docs: "), i(1, "update documentation for ") }),
  s("style", { t("style: "), i(1, "format code without logic changes") }),
  s("refactor", { t("refactor: "), i(1, "improve code structure") }),
  s("perf", { t("perf: "), i(1, "optimize performance of ") }),
  s("test", { t("test: "), i(1, "add tests for ") }),
  s("chore", { t("chore: "), i(1, "update build process") }),
  s("ci", { t("ci: "), i(1, "update CI/CD configuration") }),
  s("build", { t("build: "), i(1, "update build system") }),
  s("revert", { t("revert: "), i(1, "revert previous commit") }),

  -- With scopes
  s("featscope", fmt("feat({}): {}", { i(1, "scope"), i(2, "add new feature") })),
  s("fixscope", fmt("fix({}): {}", { i(1, "scope"), i(2, "resolve issue") })),
  s("docsscope", fmt("docs({}): {}", { i(1, "scope"), i(2, "update documentation") })),
  s("testscope", fmt("test({}): {}", { i(1, "scope"), i(2, "add tests") })),

  -- Breaking changes
  s("breaking", fmt("feat!: {}", { i(1, "introduce breaking change") })),
  s("breakingscope", fmt("feat({})!: {}", { i(1, "scope"), i(2, "breaking change") })),

  -- Common specific patterns
  s("fixtypo", { t("fix: correct typo") }),
  s("fixbug", { t("fix: resolve bug in "), i(1, "component") }),
  s("fixminor", { t("fix: minor bug fix") }),
  s("addtest", { t("test: add unit tests for "), i(1, "function") }),
  s("updatetest", { t("test: update existing tests") }),
  s("updatereadme", { t("docs: update README") }),
  s("adddep", { t("chore: add dependency "), i(1, "package-name") }),
  s("updatedep", { t("chore: update dependencies") }),
  s("removedep", { t("chore: remove unused dependency "), i(1, "package-name") }),
  s("removecode", { t("refactor: remove unused code") }),
  s("cleanup", { t("refactor: code cleanup") }),
  s("prettier", { t("style: run prettier") }),
  s("eslint", { t("style: fix linting issues") }),
  s("wip", { t("wip: "), i(1, "work in progress") }),

  -- Multi-line commits with body
  s("featbody", fmt("feat: {}\n\n{}", { i(1, "add new feature"), i(2, "Detailed description") })),
  s("fixbody", fmt("fix: {}\n\n{}", { i(1, "resolve issue"), i(2, "Explanation of the fix") })),

  -- Interactive commit type selector
  s("commit", fmt("{}: {}", { 
    c(1, {
      t("feat"),
      t("fix"),
      t("docs"),
      t("style"),
      t("refactor"),
      t("perf"),
      t("test"),
      t("chore"),
      t("ci"),
      t("build")
    }),
    i(2, "description")
  })),
})
